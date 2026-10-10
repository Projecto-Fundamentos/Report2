# Capítulo IV: Product Architecture Design

Este capítulo especifica la arquitectura propuesta para **ICHU**, la solución SmartFarm de monitoreo bovino. Las decisiones son de diseño para los siguientes avances; no se presentan como componentes ya implementados. La trazabilidad usa las entrevistas del capítulo II y las historias ICHU-US-01 a ICHU-US-22 del capítulo III. El MVP cubre inventario, dispositivos, telemetría, geocercas, alertas, atención en campo, operación offline e historial clínico.

## 4.1. Design Concepts, ViewPoints & ER Diagrams

Se detallan principios, estilos, límites, vistas y modelo de datos que guían el diseño. Los diagramas representan una arquitectura propuesta y se acompañan de criterios textuales para interpretar sus decisiones.

### 4.1.1. Principles Statements

| Principio | Aplicación | Verificación |
|---|---|---|
| Trazabilidad | Lectura, alerta, asignación, observación e indicación conservan enlaces causales, autor y fechas. | Reconstruir un caso desde la señal hasta el seguimiento clínico. |
| Continuidad | Dispositivo y móvil conservan datos pendientes y reintentan al recuperar red. | Una interrupción no pierde registros ni crea duplicados. |
| Acceso mínimo | El servidor verifica rol, estancia y recurso; dispositivos y personas usan credenciales separadas. | Denegar accesos entre estancias. |
| Responsabilidad única | Inventario, telemetría, alertas y salud tienen dueño lógico y contratos. | Ningún módulo escribe tablas privadas de otro. |
| Evidencia, no diagnóstico automático | La alerta ayuda al triaje; la decisión clínica corresponde al veterinario. | Interfaz distingue lectura, anomalía, observación y diagnóstico. |
| Evolución observable | Contratos versionados, identificadores de correlación y métricas de retraso/error. | Seguir una lectura desde el ingreso hasta el aviso. |

### 4.1.2. Approaches Statements: Architectural Styles & Patterns

Se propone una arquitectura **modular orientada a eventos** para telemetría y una **API HTTP** para consultas y comandos humanos. La carga de lecturas es diferente a la de altas de bovinos o diagnósticos; separar responsabilidades evita que una ráfaga de sensores bloquee la atención. En el MVP los módulos pueden compartir despliegue; su separación física se decidirá según carga y operación medidas.

El dispositivo registra temperatura, actividad y posición cuando dispone de los sensores correspondientes. Conserva lecturas durante una interrupción y las transmite por pasarela LoRaWAN o red celular. Un adaptador autentica y normaliza el mensaje. Telemetría valida, deduplica y persiste. El evento de lectura aceptada actualiza el último estado y activa reglas; la API sirve las vistas web y móvil. El móvil mantiene una cola local de comandos y la sincroniza al recuperar conexión.

La entrega de campo se considera **al menos una vez**. Identificadores estables hacen idempotentes los reintentos. Los cambios de estado de una alerta son transaccionales; el dashboard y las notificaciones pueden actualizarse de forma eventual y muestran la fecha del último dato.

### 4.1.3. Context Diagram

El límite de ICHU incluye clientes web/móvil, API, identidad, inventario, telemetría, alertas, salud y almacenamiento. Fuera del límite se ubican usuarios, dispositivos/pasarela, proveedor push/SMS y futuros sistemas clínicos externos.

![Diagrama de contexto C4 de ICHU con sus usuarios y sistemas externos](images/CHAPTER04/context-diagram-c4.png)

*Figura 4.1. Diagrama de contexto de ICHU (C4, nivel 1). Elaboración propia en Visual Paradigm Online. La conexión con un sistema clínico externo representa una integración futura, no una función implementada en el MVP.*

| Actor externo | Envía a ICHU | Recibe de ICHU | Historias |
|---|---|---|---|
| Propietario/administrador | Altas, geocercas, asignaciones y reglas | Dashboard, mapa, alertas y reportes | ICHU-US-01 a 07, 20 a 22 |
| Capataz | Observaciones y confirmaciones, incluso offline | Incidencias, ubicación conocida y sincronización | ICHU-US-08 a 13, 17 |
| Veterinario | Diagnóstico, indicación y seguimiento | Series, historial y alertas por lote | ICHU-US-14 a 19 |
| Dispositivo/pasarela | Lectura, ID, hora y calidad de señal | Acuse técnico si el canal lo permite | ICHU-US-03, 05, 14, 20 |
| Proveedor push/SMS | Acuse o error de entrega | Solicitud de aviso referida a una alerta | ICHU-US-09, 22 |
| Sistema clínico externo | Solicitud autenticada | Datos permitidos y auditados | ICHU-US-19 |

Flujo de contexto: **dispositivo → pasarela/adaptador → telemetría → reglas → alerta → aviso → atención → historial**. Cada consulta muestra cuándo se capturó o actualizó el dato. La figura resume las relaciones externas; los componentes internos del flujo se detallan en las vistas de 4.1.4.

### 4.1.4. Approach Driven ViewPoints Diagrams

La **vista funcional de contenedores** (figura 4.2) descompone el límite de ICHU mostrado en la figura 4.1. Es un diseño propuesto: los nombres de tecnologías indican el tipo de interfaz o almacenamiento, no un proveedor ni un despliegue ya decidido. Los clientes web y móvil acceden a la API por HTTPS; el móvil conserva comandos pendientes y los sincroniza con identificadores idempotentes. La pasarela transmite lecturas al proceso de ingesta, que autentica, normaliza y deduplica. La ingesta guarda la lectura y el evento pendiente en una misma transacción; un despachador de *outbox* publica después el evento aceptado en la cola durable. La API consume el evento para aplicar reglas y actualizar alertas; consulta y modifica los datos relacionales, solicita avisos al proveedor externo y conserva referencias a archivos de evidencia. El servidor comprueba rol y pertenencia a estancia en cada operación.

![Vista funcional de contenedores C4 de ICHU con actores, clientes, API, ingesta IoT, base de datos, cola y servicios externos](images/CHAPTER04/container-view-vp.png)

*Figura 4.2. Vista de contenedores de ICHU (C4, nivel 2). Elaboración propia en Visual Paradigm. La flecha de base relacional a cola representa el despachador de outbox; los módulos indicados dentro de la API comparten un contenedor lógico en el MVP. [Abrir diagrama editable](https://online.visual-paradigm.com/w/sooshvme/diagrams/#diagram:workspace=sooshvme&proj=0&id=9&import=draw.io&type=BlockDiagram) · [Archivo fuente editable](images/CHAPTER04/container-view-vp.drawio).*

La **vista de flujo de datos** (figura 4.3) ordena la lectura en dos trayectos visuales: pasos 1–5 de izquierda a derecha y 6–10 de derecha a izquierda. La alerta registra qué lectura y versión de regla la originaron; la notificación y la intervención humana son posteriores. La franja inferior distingue los comandos capturados offline en el móvil de la telemetría enviada por el sensor.

![Flujo de datos de ICHU desde el sensor hasta la atención y el historial, con ruta offline](images/CHAPTER04/data-flow-view-vp.png)

*Figura 4.3. Flujo de datos de una alerta en ICHU. Elaboración propia en Visual Paradigm. [Abrir diagrama editable](https://online.visual-paradigm.com/w/sooshvme/diagrams/#diagram:workspace=sooshvme&proj=0&id=10&import=draw.io&type=BlockDiagram) · [Archivo fuente editable](images/CHAPTER04/data-flow-view-vp.drawio).*

La **vista de despliegue** (figura 4.4) separa campo, conectividad, plataforma y servicios externos. Se muestran procesos y almacenes lógicos, sin fijar aún una nube. Ante un corte de enlace, el dispositivo o el móvil conserva elementos pendientes y reintenta; la alerta persistida no depende de que el proveedor de avisos esté disponible.

![Vista de despliegue propuesta de ICHU con campo, red, plataforma y servicios externos](images/CHAPTER04/deployment-view-vp.png)

*Figura 4.4. Vista de despliegue propuesta de ICHU. Elaboración propia en Visual Paradigm. [Abrir diagrama editable](https://online.visual-paradigm.com/w/sooshvme/diagrams/#diagram:workspace=sooshvme&proj=0&id=11&import=draw.io&type=BlockDiagram) · [Archivo fuente editable](images/CHAPTER04/deployment-view-vp.drawio).*

La **vista de seguridad** (figura 4.5) separa dos rutas de confianza: personas con sesión y roles, y dispositivos con credenciales propias. Una sesión válida no concede acceso indiscriminado: la API comprueba rol, estancia, recurso y acción. La ingesta IoT comprueba credencial, formato, secuencia y asociación vigente antes de aceptar una lectura. Ambos recorridos generan trazas de auditoría sin exponer secretos.

![Vista de seguridad de ICHU con autenticación humana y de dispositivos, autorización y auditoría](images/CHAPTER04/security-view-vp.png)

*Figura 4.5. Vista de seguridad de ICHU. Elaboración propia en Visual Paradigm. [Abrir diagrama editable](https://online.visual-paradigm.com/w/sooshvme/diagrams/#diagram:workspace=sooshvme&proj=0&id=12&import=draw.io&type=BlockDiagram) · [Archivo fuente editable](images/CHAPTER04/security-view-vp.drawio).*

| Vista | Elementos y relaciones representados | Pregunta |
|---|---|---|
| Funcional/contenedores (figura 4.2) | Actores, web, móvil, API modular, ingesta IoT, base SQL, cola durable, pasarela, proveedor de avisos y almacén de evidencias. Identidad, inventario, salud, geocercas y alertas son responsabilidades de la API. | ¿Quién responde por cada capacidad? |
| Flujo de datos (figura 4.3) | Captura, enlace rural, autenticación IoT, deduplicación, persistencia, evento durable, regla, alerta causal, aviso, atención e historial; ruta offline diferenciada. | ¿Cómo llega una señal a una alerta? |
| Despliegue (figura 4.4) | Dispositivo, móvil, redes, punto de entrada, API, ingesta, cola, base, observabilidad y servicios externos. | ¿Dónde se ejecuta y qué falla con la red? |
| Seguridad (figura 4.5) | Sesión humana, credencial IoT, autorización por rol/estancia/recurso, validación de lecturas y controles de auditoría y cifrado. | ¿Quién puede consultar o cambiar un dato? |

La secuencia de una alerta crítica es lectura aceptada → regla vigente → alerta con causa → solicitud de aviso → asignación → observación → indicación. La secuencia offline es comando local con ID estable → reconexión → autorización → aplicación idempotente → confirmación o conflicto. Las cuatro figuras son perspectivas complementarias del mismo diseño propuesto y no evidencia de implementación o pruebas ejecutadas.

### 4.1.5. Relational/Non Relational Database Diagram

Se propone una base relacional para integridad de asociaciones, permisos y estados. La telemetría se organiza por animal y tiempo, mediante particiones o almacenamiento especializado si el volumen medido lo requiere. Los archivos de evidencia se guardan en almacenamiento de objetos y la base conserva su referencia. No se fija un proveedor de nube antes de evaluar el despliegue.

![Modelo entidad-relación lógico propuesto de ICHU con claves primarias, claves foráneas y cardinalidades](images/CHAPTER04/erd-ichu.png)

*Figura 4.6. Diagrama entidad–relación lógico de ICHU. Elaboración propia. Las patas de cuervo indican multiplicidad y el círculo indica participación opcional. [Versión vectorial](images/CHAPTER04/erd-ichu.svg) · [Fuente editable Mermaid](images/CHAPTER04/erd-ichu.mmd).*

| Entidad lógica | Relaciones y reglas |
|---|---|
| Estancia, Usuario, Membresía | Membresía une usuario y estancia con rol. Toda consulta se filtra por estancia. |
| Lote, Bovino | Lote pertenece a estancia; bovino pertenece a estancia y a un lote opcional. Baja lógica para conservar historial. |
| Dispositivo, Asociación | Asociación une dispositivo y bovino por vigencia; se impiden vínculos activos incompatibles. |
| LecturaTelemetría | Referencia dispositivo y bovino válido al capturar; guarda horas de captura/recepción, magnitudes, posición y calidad. Clave de deduplicación por dispositivo y secuencia. |
| Geocerca, ReglaAlerta | Vinculadas a estancia/lote. Cada versión de regla es inmutable y se identifica por `(regla_id, version)`; la alerta conserva la versión aplicada. |
| Alerta, TransiciónAlerta | Alerta referencia bovino, versión de regla y lectura causal; registra creación, responsable actual y última escalada, cuando exista. Transición guarda estados anterior/nuevo, actor y hora. |
| Observación, Evidencia | Observación referencia bovino y opcionalmente alerta; evidencia conserva autor y localizador de archivo. |
| Indicación, Seguimiento | Referencian bovino, veterinario y alerta cuando corresponde; agregan historia sin sobrescribir registros previos. |
| ComandoSincronización | Clave única por estancia, cliente y comando; conserva respuesta para reintentos. |

**Reglas de integridad.** `Bovino.estancia_id` debe coincidir con la estancia del lote, cuando hay lote. Una lectura solo puede asociarse al bovino cuya asociación con el dispositivo estaba vigente en `capturada_en`; registra por separado `capturada_en` y `recibida_en`, y la clave `(dispositivo_id, secuencia)` evita duplicados. `Alerta.lectura_id`, `Alerta.responsable_id`, `Alerta.escalada_en`, `Observación.alerta_id` e `Indicación.alerta_id` pueden ser nulos según el caso; `Alerta.creada_en` es obligatoria. La referencia compuesta `(Alerta.regla_id, Alerta.version_regla_aplicada)` apunta a una fila inmutable de `ReglaAlerta(regla_id, version)` para reconstruir la regla que originó la alerta. `ComandoSincronización` tiene clave primaria compuesta `(estancia_id, cliente_id, comando_id)` y almacena el resultado de los reintentos. Los identificadores de responsable, autor y veterinario referencian `Usuario` y requieren una membresía vigente con el rol adecuado; el diagrama muestra esas referencias, pero la autorización se verifica además en la API.

Índices prioritarios: alertas por estancia/estado/severidad, lecturas por bovino/tiempo y deduplicación por dispositivo/secuencia. Retención y protección de evidencias se validarán antes de producción. El almacén de objetos no se representa como base no relacional: solo guarda archivos y devuelve un localizador persistido en `Evidencia.objeto_uri`. Tampoco se inventa una segunda base de datos sin una necesidad medida.

### 4.1.6. Design Patterns

| Patrón | Aplicación |
|---|---|
| Adaptador | Traduce LoRaWAN/celular a un contrato interno sin mezclar transporte con reglas clínicas. |
| Repositorio | Aísla persistencia de bovinos, alertas e indicaciones para probar el dominio. |
| Outbox | Persiste un cambio y el evento pendiente en la misma transacción local. |
| Idempotencia | Devuelve el mismo resultado al repetir una lectura o comando con ID estable. |
| Máquina de estados | Restringe alerta: nueva, reconocida, asignada, en atención y cerrada. |
| Estrategia de reglas | Evalúa umbrales y geocercas por tipo y versión. |
| Proyección de lectura | Prepara último estado y conteos sin alterar lecturas originales. |

### 4.1.7. Tactics

Las tácticas hacen verificables los atributos de calidad. Las cifras de 4.2.3 son **metas propuestas**, no resultados medidos.

| Atributo | Táctica | Prueba prevista |
|---|---|---|
| Disponibilidad | Cola durable, reintentos progresivos y aislamiento de mensajes fallidos. | Detener evaluador y comprobar reprocesamiento sin pérdida. |
| Rendimiento | Proyección de último estado, índices y evaluación asíncrona. | Medir alerta y consulta bajo carga representativa. |
| Offline | Cola local persistente, acuse por comando e IDs idempotentes. | Capturar sin red, reiniciar y sincronizar sin duplicados. |
| Seguridad | Cifrado en tránsito, credencial IoT separada, roles por estancia y auditoría. | Acceso cruzado y revocación de permisos. |
| Modificabilidad | Contratos versionados y módulos por responsabilidad. | Cambiar una regla sin modificar entrada IoT o móvil. |
| Observabilidad | Correlación y métricas de edad de lectura, cola, errores y avisos. | Seguir una lectura desde el dispositivo hasta la alerta. |
## 4.2. Architectural Drivers

Los *architectural drivers* son los requisitos y condiciones que influyen de manera significativa en el diseño de SmartFarm. Se identifican a partir de las historias de usuario, las necesidades del sector ganadero y las condiciones de conectividad en las zonas de operación. Estos drivers orientarán las decisiones de diseño que se desarrollen en las iteraciones ADD de la sección 4.3.

### 4.2.1. Design Purpose

El propósito del diseño arquitectónico de SmartFarm es definir una solución que permita monitorear bovinos mediante dispositivos IoT y transformar los datos de ubicación, temperatura y actividad en información útil para propietarios, operarios de campo y médicos veterinarios.

La arquitectura debe respaldar el ciclo completo de atención de una incidencia: recibir la telemetría, asociarla con el bovino correspondiente, detectar una condición que requiera atención, generar una alerta, registrar la intervención y conservar el historial. Asimismo, debe permitir que el operario consulte información descargada previamente y registre observaciones cuando se encuentre en una zona sin conexión.

Para cumplir este propósito, el diseño debe establecer responsabilidades claras para los dispositivos IoT, el procesamiento en el borde (*edge*), los servicios centrales y las aplicaciones web y móvil. Esta organización facilitará la trazabilidad de los datos y permitirá identificar qué funciones pueden continuar operando durante una interrupción de la conexión a internet.

### 4.2.2. Primary Functionality (Primary User Stories)

Las siguientes historias de usuario se consideran prioritarias para el diseño arquitectónico porque determinan la organización de los datos, los servicios y la comunicación entre los componentes del sistema. Sus identificadores corresponden a las historias y al Product Backlog del capítulo III.

| Funcionalidad principal | Historias de usuario | Implicancia arquitectónica |
|---|---|---|
| Gestión de bovinos, lotes y dispositivos | ICHU-US-07, ICHU-US-20 | Mantener la relación entre cada bovino, su lote y el dispositivo asociado; evitar asociaciones activas duplicadas. |
| Recepción y consulta de telemetría | ICHU-US-03, ICHU-US-05, ICHU-US-14 | Procesar lecturas de ubicación, temperatura y actividad, y conservar la fecha y hora originales de cada captura. |
| Detección y atención de alertas | ICHU-US-02, ICHU-US-04, ICHU-US-08, ICHU-US-09 | Evaluar geocercas y condiciones de riesgo; generar alertas y registrar su asignación, atención y estado. |
| Operación en campo sin conexión | ICHU-US-10, ICHU-US-11, ICHU-US-12, ICHU-US-13 | Consultar información almacenada en el dispositivo móvil, guardar incidencias pendientes y sincronizarlas al recuperar la conexión. |
| Seguimiento clínico | ICHU-US-15, ICHU-US-16, ICHU-US-17 | Relacionar observaciones, diagnósticos, indicaciones y evolución clínica con el historial del bovino, sin eliminar registros anteriores. |
| Visualización del estado de la estancia | ICHU-US-01 | Presentar el inventario, los indicadores principales y las alertas activas en una vista para el propietario o administrador. |

Estas funcionalidades conforman el ciclo principal de monitoreo del MVP. Los reportes avanzados, las reglas configurables y las integraciones externas podrán incorporarse de acuerdo con las prioridades establecidas en el Product Backlog.

### 4.2.3. Quality Attribute Scenarios

Los escenarios de atributos de calidad describen situaciones concretas que deberán verificarse durante la implementación. Las medidas presentadas son metas iniciales de diseño y deberán validarse mediante pruebas con los dispositivos, la red y la infraestructura seleccionados.

| ID | Atributo de calidad e historias asociadas | Fuente, estímulo y entorno | Artefacto y respuesta esperada | Medida de respuesta propuesta |
|---|---|---|---|---|
| QA-01 | **Funcionamiento sin conexión:** ICHU-US-10, ICHU-US-12, ICHU-US-13 | Un capataz consulta la última ubicación conocida y registra una incidencia mientras su teléfono no tiene conexión a internet. | La aplicación móvil muestra la información almacenada y su antigüedad. Además, guarda la incidencia localmente y la sincroniza cuando se restablece la conexión. | La incidencia permanece disponible después de cerrar y volver a abrir la aplicación. Su estado indica si está pendiente, sincronizada o requiere revisión. |
| QA-02 | **Integridad de los datos:** ICHU-US-12, ICHU-US-13, ICHU-US-15, ICHU-US-16 | La conexión se interrumpe durante el envío de una incidencia y la aplicación vuelve a intentarlo. | El servicio de sincronización identifica el registro para evitar duplicaciones. El historial conserva tanto la hora original de captura como la hora de recepción. | La incidencia aparece una sola vez en el historial, incluso después de varios intentos de envío. |
| QA-03 | **Rendimiento de las alertas:** ICHU-US-02, ICHU-US-04, ICHU-US-08, ICHU-US-09 | El sistema central recibe una lectura válida que indica que un bovino salió de una geocerca activa, mientras los servicios se encuentran operativos. | El procesamiento de telemetría evalúa la regla, registra una alerta y la pone a disposición de los usuarios autorizados. | Como meta inicial, la alerta queda registrada en menos de 30 segundos desde la recepción de la lectura en el sistema central. |
| QA-04 | **Seguridad:** ICHU-US-02, ICHU-US-16, ICHU-US-19 | Un usuario intenta consultar datos de una estancia a la que no pertenece o registrar una indicación clínica sin el permiso necesario. | La API verifica la identidad del usuario, la estancia y su rol antes de permitir la consulta o modificación. El intento rechazado queda registrado. | Una solicitud no autorizada no devuelve datos de la estancia ni modifica su historial. |
| QA-05 | **Observabilidad:** ICHU-US-20 | Un dispositivo deja de transmitir durante un periodo superior al esperado. | El sistema conserva la fecha de su última transmisión y permite distinguir los datos recientes de los desactualizados. | La ficha del bovino muestra la hora de la última transmisión y el estado del dispositivo según el umbral configurado. |
| QA-06 | **Modificabilidad:** ICHU-US-04, ICHU-US-21 | Un administrador autorizado modifica una geocerca o un criterio de severidad. | El módulo de reglas utiliza la nueva configuración para evaluar las lecturas posteriores y conserva el motivo de las alertas ya generadas. | La modificación no cambia las alertas históricas y puede comprobarse mediante pruebas de las reglas actualizadas. |

En QA-03, el tiempo se mide desde que la lectura **llega al sistema central**. La conectividad rural puede retrasar la transmisión desde el dispositivo, por lo que ese retraso debe evaluarse por separado del tiempo de procesamiento de la alerta.

### 4.2.4. Constraints

| ID | Restricción | Efecto en el diseño |
|---|---|---|
| CON-01 | Los bovinos serán monitoreados mediante dispositivos IoT capaces de proporcionar datos de ubicación y variables biométricas o de actividad, según las capacidades del prototipo. | La recepción de telemetría debe validar cada lectura y asociarla con un dispositivo, un bovino y una fecha y hora de captura. |
| CON-02 | La solución se utilizará en zonas rurales donde la conexión a internet puede ser intermitente. | Las funciones móviles de consulta y registro deben incluir almacenamiento local y sincronización posterior. |
| CON-03 | El capítulo I establece que el prototipo del dispositivo se diseñará o simulará con herramientas autorizadas, como Cirkit Designer o Wokwi, y se comunicará con el Edge API. | Los datos enviados y las pruebas de integración deben poder verificarse con el prototipo o simulador disponible. |
| CON-04 | SmartFarm tiene usuarios con responsabilidades diferentes: propietarios o administradores, operarios de campo y médicos veterinarios. | El sistema debe controlar el acceso a la información y a las acciones según el rol del usuario y la estancia autorizada. |
| CON-05 | Las observaciones de campo y las actuaciones clínicas deben conservar su trazabilidad. | Los registros deben preservar la fecha de captura, el autor y el historial de eventos, sin sobrescribir la información anterior. |
| CON-06 | El alcance inicial del producto debe seguir las historias clasificadas como **Must** en el Product Backlog. | El diseño debe priorizar la identificación de bovinos, la telemetría, las alertas, la atención de incidencias y el seguimiento clínico. |

Estas restricciones se derivan de los requisitos actuales del informe. La elección de un proveedor de nube, una base de datos o una tecnología específica de mensajería deberá justificarse cuando se desarrollen las decisiones de diseño.

### 4.2.5. Architectural Concerns

| ID | Preocupación arquitectónica | Aspecto que debe resolver el diseño |
|---|---|---|
| ARC-01 | **Lecturas tardías o incompletas:** un dispositivo puede transmitir datos después de recuperar la conexión o enviar una lectura inválida. | Definir la validación de lecturas, el tratamiento de datos recibidos fuera de orden y la diferencia entre la hora de captura y la hora de recepción. |
| ARC-02 | **Continuidad del trabajo en campo:** el operario necesita consultar información y registrar incidencias sin conexión. | Definir qué datos se almacenan en el teléfono, cómo se protegen y cómo se gestionan los errores de sincronización. |
| ARC-03 | **Confiabilidad de las alertas:** una lectura aislada o duplicada podría producir una alerta incorrecta. | Definir las reglas de evaluación, la prevención de duplicados y el registro del motivo de cada alerta. |
| ARC-04 | **Protección de la información:** los usuarios no deben acceder a datos de otras estancias o realizar acciones fuera de sus permisos. | Definir controles de acceso por estancia y rol, junto con el registro de las consultas y modificaciones sensibles. |
| ARC-05 | **Coherencia del historial:** las observaciones, alertas y decisiones veterinarias deben asociarse con el bovino correcto. | Definir identificadores y relaciones que permitan conservar los eventos en su secuencia temporal, incluso si se sincronizan posteriormente. |
| ARC-06 | **Estado de los dispositivos:** la ausencia de lecturas recientes puede confundirse con la ausencia de problemas en el animal. | Mostrar la última transmisión y la antigüedad de los datos, diferenciando el estado del dispositivo del estado del bovino. |

Estas preocupaciones deberán considerarse en las iteraciones ADD, especialmente al diseñar la estructura general del sistema, la sincronización de datos, el procesamiento de alertas y la seguridad.

## 4.3 ADD Iterations
### 4.3.1 Iteration 1: Establishing Overall Architectural Structure and Container Decomposition
#### 4.3.2.2 Architectural Design Backlog 1

El backlog inicial de diseño arquitectónico reúne las historias de usuario primarias, restricciones de proyecto y preocupaciones clave que condicionan la estructura global de ICHU:
•	Historias de Usuario Primarias (Primary User Stories):
•	US-01: Registrar cuenta de unidad productiva ganadera.
•	US-06: Registrar un animal dentro del hato ganadero.
•	US-13: Consultar telemetría biométrica y de ubicación reciente de un animal.
•	US-16: Recibir alerta automática por anomalía de salud (temperatura/actividad).
•	TS-01: Capturar biometría y ubicación GPS en la banda/collar inteligente.
•	TS-04: Recibir telemetría en la pasarela de borde (Portable Edge Gateway).
•	TS-07: Validar y persistir telemetría en la API RESTful central de la nube.
•	Restricciones de Arquitectura (Constraints):
•	CON-01: Operación en zonas ganaderas rurales con conectividad celular intermitente o nula (Sierras de Apurímac, Cusco y Puno).
•	CON-02: Despliegue distribuido físicamente entre dispositivos en predio (Borde) y servicios centralizados (Nube).
•	CON-03: Equipo de desarrollo reducido (6 integrantes) con un ciclo de entrega acotado.
•	Preocupaciones Arquitectónicas (Architectural Concerns):
•	CRN-01: Aplicar el enfoque Domain-Driven Design (DDD) para delimitar las fronteras de dominio mediante Contextos Acotados (Bounded Contexts).

#### 4.3.3.3 Establish Iteration Goal by Selecting Drivers
El objetivo de la Iteración 1 es establecer la estructura arquitectónica de alto nivel y la descomposición en contenedores del sistema ICHU para garantizar la comunicación fluida entre clientes móviles/web,
dispositivos IoT de campo y el backend central.
Drivers seleccionados: US-01, US-06, US-16, TS-01, TS-04, CON-01, CON-02, CON-03.
C4 falta
#### 4.3.4.3 Choose One or More Elements of the System to Refine
Se selecciona el sistema completo ICHU Software System como elemento global a descomponer en contenedores y subsistemas.

#### 4.3.5.5 Choose One or More Design Concepts That Satisfy the Selected Drivers
• Estilo Arquitectónico General: Arquitectura distribuida basada en Edge Computing + Cloud Computing, organizada en capas para separar la adquisición y procesamiento local de telemetría de los servicios centralizados en la nube.

• Patrón de Backend Central: Arquitectura de Microservicios. El backend estará compuesto por servicios independientes organizados de acuerdo con las principales capacidades del dominio de ICHU. Cada microservicio tendrá una responsabilidad específica y podrá evolucionar, desplegarse y escalarse de manera independiente. La comunicación entre los servicios se realizará mediante APIs REST sobre HTTPS y mecanismos de mensajería cuando sea necesario.

• Patrón de Clientes: Aplicación móvil multiplataforma con enfoque Offline-First y Aplicación Web Administrativa. La aplicación móvil permitirá a los operarios y veterinarios consultar y registrar información incluso ante una conectividad limitada, sincronizando posteriormente los datos con los servicios de la nube.

• Patrón de comunicación Edge–Cloud: Sincronización asíncrona de datos entre el Portable Edge Gateway y los servicios de la nube. El Edge Gateway almacenará temporalmente la telemetría cuando no exista conectividad y realizará la sincronización cuando se restablezca la comunicación.

• Persistencia: Cada microservicio será responsable de la persistencia de los datos correspondientes a su contexto de dominio, siguiendo el principio de Database per Service para reducir el acoplamiento entre servicios.

#### 4.3.6.6 Instantiate Architectural Elements, Allocate Responsibilities, and Define Interfaces

Se instancian los siguientes contenedores principales dentro de la arquitectura de ICHU:
•	1. Cattle Band Embedded Application (ESP32 / C++): Captura continua de temperatura corporal, acelerometría de actividad y posición GPS. Transmite datos localmente mediante Bluetooth Low Energy (BLE) o Wi-Fi local.
•	2. Portable Edge Gateway (Python / Flask / SQLite): Servicio desplegado en la pasarela portátil del predio; almacena lecturas locales, evalúa reglas críticas sin conexión y sincroniza lotes hacia la nube cuando detecta conectividad.
•	3. ICHU Modular Monolith (ASP.NET Core / .NET 8): Backend central en la nube que alberga los servicios de negocio agrupados en módulos independientes expuestos mediante RESTful API sobre HTTPS/JSON.
•	4. Mobile Application (Flutter / Dart): Aplicación móvil para operarios y veterinarios que permite visualización de mapas, registro de ganado y gestión de alertas locales/remotas.
•	5. Web Application (Angular / TypeScript): Panel web administrativo para la gestión integral de hatos, configuración de geocercas, analítica avanzada y reportes ejecutivos.
•	6. ICHU Cloud Database (PostgreSQL 16): Base de datos relacional central con esquemas aislados por cada contexto acotado.

| Driver                            | Decisión arquitectónica                         | Justificación                                                                                         |
| --------------------------------- | ----------------------------------------------- | ----------------------------------------------------------------------------------------------------- |
| CON-01: Conectividad intermitente | Edge Computing + almacenamiento local           | Permite continuar capturando y procesando datos sin conexión                                          |
| CON-02: Distribución física       | Edge + Cloud                                    | Separa procesamiento local de servicios centralizados                                                 |
| CON-03: Equipo de desarrollo      | Microservicios con límites de dominio definidos | Permite distribuir responsabilidades entre los integrantes y evolucionar servicios independientemente |
| TS-01: Captura de telemetría      | Cattle Band + Edge Gateway                      | Permite capturar y recibir datos localmente                                                           |
| TS-04: Recepción de telemetría    | Edge Gateway                                    | Centraliza la recepción de datos de los dispositivos                                                  |
| TS-07: Persistencia en Cloud      | Microservicio de Telemetría                     | Valida y persiste los datos recibidos desde Edge                                                      |
| US-16: Alertas                    | Health/Alert Microservices                      | Permite procesar anomalías y generar alertas                                                          |


#### 4.3.7.7 Sketch Views (C4 & UML) and Record Design Decisions
• C4 System Context Diagram: Define las fronteras entre los actores (Administrador, Operario, Veterinario), el sistema ICHU y los servicios externos (Firebase, Pasarela de Pagos, Google Maps).
• C4 Container Diagram: Detalla los 9 contenedores del sistema y sus protocolos de comunicación (REST/HTTPS, BLE, Wi-Fi local, TCP/IP).

![Diagrama C4 de ICHU](./images/diagrams/c4/c4-container.png)
![Diagrama C4 de ICHU](./images/diagrams/c4/c4-container-key.png)


#### 4.3.8.8 Analysis of Current Design and Review Iteration Goal (Kanban Board)
Análisis de Cobertura: La descomposición en contenedores satisface las restricciones de conectividad rural (CON-01) y la capacidad operativa del equipo (CON-03) mediante el uso de la pasarela de borde y el backend modular.

Estado en Tablero Kanban:

•	[DONE]: Definición de Contenedores C4, Selección de Stack (.NET 8, Flutter, Angular, Python, PostgreSQL).  
•	[IN PROGRESS]: Diseño de canales de sincronización asíncrona entre el Borde y la Nube.  
•	[TO DO]: Refinamiento de atributos de calidad de latencia y disponibilidad en el Borde.

