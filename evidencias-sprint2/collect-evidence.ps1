param([string]$BaseUrl = 'http://127.0.0.1:5187', [string]$OutputDirectory = "$PSScriptRoot/generated-evidence", [string]$SourceDirectory = "$PSScriptRoot/cattle-information-service")
$ErrorActionPreference = 'Stop'
New-Item -ItemType Directory -Force $OutputDirectory | Out-Null
$records = [System.Collections.Generic.List[object]]::new()
function Request([string]$Id,[string]$Method,[string]$Path,$Payload,[int]$Expected) {
  $options = @{Uri="$BaseUrl$Path"; Method=$Method; SkipHttpErrorCheck=$true}
  $json = $null
  if ($null -ne $Payload) { $json = $Payload | ConvertTo-Json -Depth 10; $options.ContentType='application/json'; $options.Body=$json }
  $response = Invoke-WebRequest @options
  $raw = if ($response.Content -is [byte[]]) {[Text.Encoding]::UTF8.GetString($response.Content)} else {[string]$response.Content}
  $body = if ($raw) { ConvertFrom-Json -InputObject $raw -NoEnumerate } else {$null}
  $records.Add([ordered]@{id=$Id;executedAt=[DateTimeOffset]::UtcNow.ToString('o');method=$Method;url="$BaseUrl$Path";request=$Payload;expectedStatus=$Expected;actualStatus=[int]$response.StatusCode;response=$body;rawResponse=$raw;contentType=[string]$response.Headers['Content-Type']})
  if ([int]$response.StatusCode -ne $Expected) {throw "$Id expected $Expected, received $($response.StatusCode)"}
  Write-Host "$Id $Method $Path -> $($response.StatusCode)"
  return $body
}
$cattle = [Guid]::NewGuid().ToString()
$device = [Guid]::NewGuid().ToString()
$time = [DateTimeOffset]::UtcNow.AddHours(-2)
$payload = @{deviceId=$device;cattleId=$cattle;bodyTemperature=40.2;activityIndex=12;ruminationMinutes=180;latitude=-13.656;longitude=-73.388;recordedAt=$time.ToString('o');origin='EdgeGateway'}
$null = Request 'EX-01' GET '/health' $null 200
$first = @(Request 'EX-02' POST '/api/v1/telemetry' $payload 201)[-1]
if (!$first.alertRaised) {throw 'Expected first fever alert'}
$retry = @(Request 'EX-03' POST '/api/v1/telemetry' $payload 200)[-1]
if (!$retry.duplicate -or $retry.readingId -ne $first.readingId) {throw 'Retry invariant failed'}
$conflict = $payload.Clone(); $conflict.bodyTemperature=40.5
$null = Request 'EX-04' POST '/api/v1/telemetry' $conflict 409
$null = Request 'EX-05' POST '/api/v1/telemetry' @{} 400
$second = $payload.Clone(); $second.recordedAt=$time.AddHours(1).ToString('o'); $second.bodyTemperature=40.5
$updated = @(Request 'EX-06' POST '/api/v1/telemetry' $second 201)[-1]
if ($updated.alertRaised -or $updated.alertId -ne $first.alertId) {throw 'Alert grouping invariant failed'}
$alerts = Request 'EX-07' GET "/api/v1/alerts?cattleId=$cattle&status=ACTIVE&limit=10" $null 200
if ($alerts.Count -ne 1 -or $alerts[0].readingCount -ne 2 -or $alerts[0].temperature -ne 40.5) {throw 'Alert list invariant failed'}
$null = Request 'EX-08' GET '/api/v1/alerts?limit=0' $null 400
$null = Request 'EX-09' GET '/api/v1/alerts?status=INVALID' $null 400
$normal=$payload.Clone();$normal.deviceId=[Guid]::NewGuid().ToString();$normal.cattleId=[Guid]::NewGuid().ToString();$normal.bodyTemperature=39.0
$normalResult = @(Request 'EX-10' POST '/api/v1/telemetry' $normal 201)[-1]
if($normalResult.alertRaised){throw 'Normal reading generated alert'}
$records | ConvertTo-Json -Depth 20 | Set-Content "$OutputDirectory/http-evidence.json" -Encoding utf8
Invoke-WebRequest "$BaseUrl/swagger/v1/swagger.json" -OutFile "$OutputDirectory/openapi-monitoring.generated.json"
$repoPath = (Resolve-Path $SourceDirectory).Path.Replace('\','/')
$manifest = [ordered]@{capturedAt=[DateTimeOffset]::UtcNow.ToString('o');timeZone='America/Lima';environment='Development';database='EF Core InMemory; data is lost on process restart';repository='https://github.com/Projecto-Fundamentos/cattle-information-service';commit=(git -c "safe.directory=$repoPath" -C $repoPath rev-parse HEAD);sdk=(dotnet --version);baseUrl=$BaseUrl;scenarioCount=$records.Count;failed=0;cattleId=$cattle;deviceId=$device}
$manifest | ConvertTo-Json | Set-Content "$OutputDirectory/manifest.json" -Encoding utf8
Write-Output 'All 10 HTTP scenarios passed.'
