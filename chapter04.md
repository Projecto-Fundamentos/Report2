# Cap¡tulo IV: Product Architecture Design

Este cap¡tulo especifica la arquitectura propuesta para **ICHU**, la soluci¢n SmartFarm de monitoreo bovino. Las decisiones son de dise¤o para los siguientes avances; no se presentan como componentes ya implementados. La trazabilidad usa las entrevistas del cap¡tulo II y las historias ICHU-US-01 a ICHU-US-22 del cap¡tulo III. El MVP cubre inventario, dispositivos, telemetr¡a, geocercas, alertas, atenci¢n en campo, operaci¢n offline e historial cl¡nico.

## 4.1. Design Concepts, ViewPoints & ER Diagrams

Se detallan principios, estilos, l¡mites, vistas y modelo de datos que gu¡an el dise¤o. Los diagramas representan una arquitectura propuesta y se acompa¤an de criterios textuales para interpretar sus decisiones.

### 4.1.1. Principles Statements

| Principio | Aplicaci¢n | Verificaci¢n |
|---|---|---|
| Trazabilidad | Lectura, alerta, asignaci¢n, observaci¢n e indicaci¢n conservan enlaces causales, autor y fechas. | Reconstruir un caso desde la se¤al hasta el seguimiento cl¡nico. |
| Continuidad | Dispositivo y m¢vil conservan datos pendientes y reintentan al recuperar red. | Una interrupci¢n no pierde registros ni crea duplicados. |
| Acceso m¡nimo | El servidor verifica rol, estancia y recurso; dispositivos y personas usan credenciales separadas. | Denegar accesos entre estancias. |
| Responsabilidad £nica | Inventario, telemetr¡a, alertas y salud tienen due¤o l¢gico y contratos. | Ning£n m¢dulo escribe tablas privadas de otro. |
| Evidencia, no diagn¢stico autom tico | La alerta ayuda al triaje; la decisi¢n cl¡nica corresponde al veterinario. | Interfaz distingue lectura, anomal¡a, observaci¢n y diagn¢stico. |
| Evoluci¢n observable | Contratos versionados, identificadores de correlaci¢n y m‚tricas de retraso/error. | Seguir una lectura desde el ingreso hasta el aviso. |

### 4.1.2. Approaches Statements: Architectural Styles & Patterns

Se propone una arquitectura **modular orientada a eventos** para telemetr¡a y una **API HTTP** para consultas y comandos humanos. La carga de lecturas es diferente a la de altas de bovinos o diagn¢sticos; separar responsabilidades evita que una r faga de sensores bloquee la atenci¢n. En el MVP los m¢dulos pueden compartir despliegue; su separaci¢n f¡sica se decidir  seg£n carga y operaci¢n medidas.

El dispositivo registra temperatura, actividad y posici¢n cuando dispone de los sensores correspondientes. Conserva lecturas durante una interrupci¢n y las transmite por pasarela LoRaWAN o red celular. Un adaptador autentica y normaliza el mensaje. Telemetr¡a valida, deduplica y persiste. El evento de lectura aceptada actualiza el £ltimo estado y activa reglas; la API sirve las vistas web y m¢vil. El m¢vil mantiene una cola local de comandos y la sincroniza al recuperar conexi¢n.

La entrega de campo se considera **al menos una vez**. Identificadores estables hacen idempotentes los reintentos. Los cambios de estado de una alerta son transaccionales; el dashboard y las notificaciones pueden actualizarse de forma eventual y muestran la fecha del £ltimo dato.

### 4.1.3. Context Diagram

El l¡mite de ICHU incluye clientes web/m¢vil, API, identidad, inventario, telemetr¡a, alertas, salud y almacenamiento. Fuera del l¡mite se ubican usuarios, dispositivos/pasarela, proveedor push/SMS y futuros sistemas cl¡nicos externos.

![Diagrama de contexto C4 de ICHU con sus usuarios y sistemas externos](images/CHAPTER04/context-diagram-c4.png)

*Figura 4.1. Diagrama de contexto de ICHU (C4, nivel 1). Elaboraci¢n propia en Visual Paradigm Online. La conexi¢n con un sistema cl¡nico externo representa una integraci¢n futura, no una funci¢n implementada en el MVP.*

| Actor externo | Env¡a a ICHU | Recibe de ICHU | Historias |
|---|---|---|---|
| Propietario/administrador | Altas, geocercas, asignaciones y reglas | Dashboard, mapa, alertas y reportes | ICHU-US-01 a 07, 20 a 22 |
| Capataz | Observaciones y confirmaciones, incluso offline | Incidencias, ubicaci¢n conocida y sincronizaci¢n | ICHU-US-08 a 13, 17 |
| Veterinario | Diagn¢stico, indicaci¢n y seguimiento | Series, historial y alertas por lote | ICHU-US-14 a 19 |
| Dispositivo/pasarela | Lectura, ID, hora y calidad de se¤al | Acuse t‚cnico si el canal lo permite | ICHU-US-03, 05, 14, 20 |
| Proveedor push/SMS | Acuse o error de entrega | Solicitud de aviso referida a una alerta | ICHU-US-09, 22 |
| Sistema cl¡nico externo | Solicitud autenticada | Datos permitidos y auditados | ICHU-US-19 |

Flujo de contexto: **dispositivo  pasarela/adaptador  telemetr¡a  reglas  alerta  aviso  atenci¢n  historial**. Cada consulta muestra cu ndo se captur¢ o actualiz¢ el dato. La figura resume las relaciones externas; los componentes internos del flujo se detallan en las vistas de 4.1.4.

### 4.1.4. Approach Driven ViewPoints Diagrams

La **vista funcional de contenedores** (figura 4.2) descompone el l¡mite de ICHU mostrado en la figura 4.1. Es un dise¤o propuesto: los nombres de tecnolog¡as indican el tipo de interfaz o almacenamiento, no un proveedor ni un despliegue ya decidido. Los clientes web y m¢vil acceden a la API por HTTPS; el m¢vil conserva comandos pendientes y los sincroniza con identificadores idempotentes. La pasarela transmite lecturas al proceso de ingesta, que autentica, normaliza y deduplica. La ingesta guarda la lectura y el evento pendiente en una misma transacci¢n; un despachador de *outbox* publica despu‚s el evento aceptado en la cola durable. La API consume el evento para aplicar reglas y actualizar alertas; consulta y modifica los datos relacionales, solicita avisos al proveedor externo y conserva referencias a archivos de evidencia. El servidor comprueba rol y pertenencia a estancia en cada operaci¢n.

![Vista funcional de contenedores C4 de ICHU con actores, clientes, API, ingesta IoT, base de datos, cola y servicios externos](images/CHAPTER04/container-view-vp.png)

*Figura 4.2. Vista de contenedores de ICHU (C4, nivel 2). Elaboraci¢n propia en Visual Paradigm. La flecha de base relacional a cola representa el despachador de outbox; los m¢dulos indicados dentro de la API comparten un contenedor l¢gico en el MVP. [Abrir diagrama editable](https://online.visual-paradigm.com/w/sooshvme/diagrams/#diagram:workspace=sooshvme&proj=0&id=9&import=draw.io&type=BlockDiagram) ú [Archivo fuente editable](images/CHAPTER04/container-view-vp.drawio).*

La **vista de flujo de datos** (figura 4.3) ordena la lectura en dos trayectos visuales: pasos 1-5 de izquierda a derecha y 6-10 de derecha a izquierda. La alerta registra qu‚ lectura y versi¢n de regla la originaron; la notificaci¢n y la intervenci¢n humana son posteriores. La franja inferior distingue los comandos capturados offline en el m¢vil de la telemetr¡a enviada por el sensor.

![Flujo de datos de ICHU desde el sensor hasta la atenci¢n y el historial, con ruta offline](images/CHAPTER04/data-flow-view-vp.png)

*Figura 4.3. Flujo de datos de una alerta en ICHU. Elaboraci¢n propia en Visual Paradigm. [Abrir diagrama editable](https://online.visual-paradigm.com/w/sooshvme/diagrams/#diagram:workspace=sooshvme&proj=0&id=10&import=draw.io&type=BlockDiagram) ú [Archivo fuente editable](images/CHAPTER04/data-flow-view-vp.drawio).*

La **vista de despliegue** (figura 4.4) separa campo, conectividad, plataforma y servicios externos. Se muestran procesos y almacenes l¢gicos, sin fijar a£n una nube. Ante un corte de enlace, el dispositivo o el m¢vil conserva elementos pendientes y reintenta; la alerta persistida no depende de que el proveedor de avisos est‚ disponible.

![Vista de despliegue propuesta de ICHU con campo, red, plataforma y servicios externos](images/CHAPTER04/deployment-view-vp.png)

*Figura 4.4. Vista de despliegue propuesta de ICHU. Elaboraci¢n propia en Visual Paradigm. [Abrir diagrama editable](https://online.visual-paradigm.com/w/sooshvme/diagrams/#diagram:workspace=sooshvme&proj=0&id=11&import=draw.io&type=BlockDiagram) ú [Archivo fuente editable](images/CHAPTER04/deployment-view-vp.drawio).*

La **vista de seguridad** (figura 4.5) separa dos rutas de confianza: personas con sesi¢n y roles, y dispositivos con credenciales propias. Una sesi¢n v lida no concede acceso indiscriminado: la API comprueba rol, estancia, recurso y acci¢n. La ingesta IoT comprueba credencial, formato, secuencia y asociaci¢n vigente antes de aceptar una lectura. Ambos recorridos generan trazas de auditor¡a sin exponer secretos.

![Vista de seguridad de ICHU con autenticaci¢n humana y de dispositivos, autorizaci¢n y auditor¡a](images/CHAPTER04/security-view-vp.png)

*Figura 4.5. Vista de seguridad de ICHU. Elaboraci¢n propia en Visual Paradigm. [Abrir diagrama editable](https://online.visual-paradigm.com/w/sooshvme/diagrams/#diagram:workspace=sooshvme&proj=0&id=12&import=draw.io&type=BlockDiagram) ú [Archivo fuente editable](images/CHAPTER04/security-view-vp.drawio).*

| Vista | Elementos y relaciones representados | Pregunta |
|---|---|---|
| Funcional/contenedores (figura 4.2) | Actores, web, m¢vil, API modular, ingesta IoT, base SQL, cola durable, pasarela, proveedor de avisos y almac‚n de evidencias. Identidad, inventario, salud, geocercas y alertas son responsabilidades de la API. | ¨Qui‚n responde por cada capacidad? |
| Flujo de datos (figura 4.3) | Captura, enlace rural, autenticaci¢n IoT, deduplicaci¢n, persistencia, evento durable, regla, alerta causal, aviso, atenci¢n e historial; ruta offline diferenciada. | ¨C¢mo llega una se¤al a una alerta? |
| Despliegue (figura 4.4) | Dispositivo, m¢vil, redes, punto de entrada, API, ingesta, cola, base, observabilidad y servicios externos. | ¨D¢nde se ejecuta y qu‚ falla con la red? |
| Seguridad (figura 4.5) | Sesi¢n humana, credencial IoT, autorizaci¢n por rol/estancia/recurso, validaci¢n de lecturas y controles de auditor¡a y cifrado. | ¨Qui‚n puede consultar o cambiar un dato? |

La secuencia de una alerta cr¡tica es lectura aceptada  regla vigente  alerta con causa  solicitud de aviso  asignaci¢n  observaci¢n  indicaci¢n. La secuencia offline es comando local con ID estable  reconexi¢n  autorizaci¢n  aplicaci¢n idempotente  confirmaci¢n o conflicto. Las cuatro figuras son perspectivas complementarias del mismo dise¤o propuesto y no evidencia de implementaci¢n o pruebas ejecutadas.

### 4.1.5. Relational/Non Relational Database Diagram

Se propone una base relacional para integridad de asociaciones, permisos y estados. La telemetr¡a se organiza por animal y tiempo, mediante particiones o almacenamiento especializado si el volumen medido lo requiere. Los archivos de evidencia se guardan en almacenamiento de objetos y la base conserva su referencia. No se fija un proveedor de nube antes de evaluar el despliegue.

![Modelo entidad-relaci¢n l¢gico propuesto de ICHU con claves primarias, claves for neas y cardinalidades](images/CHAPTER04/erd-ichu.png)

*Figura 4.6. Diagrama entidad-relaci¢n l¢gico de ICHU. Elaboraci¢n propia. Las patas de cuervo indican multiplicidad y el c¡rculo indica participaci¢n opcional. [Versi¢n vectorial](images/CHAPTER04/erd-ichu.svg) ú [Fuente editable Mermaid](images/CHAPTER04/erd-ichu.mmd).*

| Entidad l¢gica | Relaciones y reglas |
|---|---|
| Estancia, Usuario, Membres¡a | Membres¡a une usuario y estancia con rol. Toda consulta se filtra por estancia. |
| Lote, Bovino | Lote pertenece a estancia; bovino pertenece a estancia y a un lote opcional. Baja l¢gica para conservar historial. |
| Dispositivo, Asociaci¢n | Asociaci¢n une dispositivo y bovino por vigencia; se impiden v¡nculos activos incompatibles. |
| LecturaTelemetr¡a | Referencia dispositivo y bovino v lido al capturar; guarda horas de captura/recepci¢n, magnitudes, posici¢n y calidad. Clave de deduplicaci¢n por dispositivo y secuencia. |
| Geocerca, ReglaAlerta | Vinculadas a estancia/lote y versionadas; la alerta conserva la versi¢n aplicada. |
| Alerta, Transici¢nAlerta | Alerta referencia bovino, regla y lectura causal. Transici¢n guarda estados anterior/nuevo, actor y hora. |
| Observaci¢n, Evidencia | Observaci¢n referencia bovino y opcionalmente alerta; evidencia conserva autor y localizador de archivo. |
| Indicaci¢n, Seguimiento | Referencian bovino, veterinario y alerta cuando corresponde; agregan historia sin sobrescribir registros previos. |
| ComandoSincronizaci¢n | Clave £nica por estancia, cliente y comando; conserva respuesta para reintentos. |

**Reglas de integridad.** `Bovino.estancia_id` debe coincidir con la estancia del lote, cuando hay lote. Una lectura solo puede asociarse al bovino cuya asociaci¢n con el dispositivo estaba vigente en `capturada_en`; la clave `(dispositivo_id, secuencia)` evita duplicados. `Alerta.lectura_id`, `Observaci¢n.alerta_id` e `Indicaci¢n.alerta_id` pueden ser nulos cuando el hecho no nace de una lectura o alerta. `ReglaAlerta.version` se conserva al crear una alerta para que cambios posteriores de umbral no reescriban su causa. `ComandoSincronizaci¢n` es £nico por `(estancia_id, cliente_id, comando_id)` y almacena el resultado de los reintentos. Los identificadores de autor y veterinario referencian `Usuario` y requieren una membres¡a vigente con el rol adecuado; el diagrama muestra esas referencias, pero la autorizaci¢n se verifica adem s en la API.

Öndices prioritarios: alertas por estancia/estado/severidad, lecturas por bovino/tiempo y deduplicaci¢n por dispositivo/secuencia. Retenci¢n y protecci¢n de evidencias se validar n antes de producci¢n. El almac‚n de objetos no se representa como base no relacional: solo guarda archivos y devuelve un localizador persistido en `Evidencia.objeto_uri`. Tampoco se inventa una segunda base de datos sin una necesidad medida.

### 4.1.6. Design Patterns

| Patr¢n | Aplicaci¢n |
|---|---|
| Adaptador | Traduce LoRaWAN/celular a un contrato interno sin mezclar transporte con reglas cl¡nicas. |
| Repositorio | A¡sla persistencia de bovinos, alertas e indicaciones para probar el dominio. |
| Outbox | Persiste un cambio y el evento pendiente en la misma transacci¢n local. |
| Idempotencia | Devuelve el mismo resultado al repetir una lectura o comando con ID estable. |
| M quina de estados | Restringe alerta: nueva, reconocida, asignada, en atenci¢n y cerrada. |
| Estrategia de reglas | Eval£a umbrales y geocercas por tipo y versi¢n. |
| Proyecci¢n de lectura | Prepara £ltimo estado y conteos sin alterar lecturas originales. |

### 4.1.7. Tactics

Las t cticas hacen verificables los atributos de calidad. Las cifras de 4.2.3 son **metas propuestas**, no resultados medidos.

| Atributo | T ctica | Prueba prevista |
|---|---|---|
| Disponibilidad | Cola durable, reintentos progresivos y aislamiento de mensajes fallidos. | Detener evaluador y comprobar reprocesamiento sin p‚rdida. |
| Rendimiento | Proyecci¢n de £ltimo estado, ¡ndices y evaluaci¢n as¡ncrona. | Medir alerta y consulta bajo carga representativa. |
| Offline | Cola local persistente, acuse por comando e IDs idempotentes. | Capturar sin red, reiniciar y sincronizar sin duplicados. |
| Seguridad | Cifrado en tr nsito, credencial IoT separada, roles por estancia y auditor¡a. | Acceso cruzado y revocaci¢n de permisos. |
| Modificabilidad | Contratos versionados y m¢dulos por responsabilidad. | Cambiar una regla sin modificar entrada IoT o m¢vil. |
| Observabilidad | Correlaci¢n y m‚tricas de edad de lectura, cola, errores y avisos. | Seguir una lectura desde el dispositivo hasta la alerta. |
