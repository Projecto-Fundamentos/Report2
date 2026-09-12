# Capítulo III: Requirements Specification
## 3.1. To-Be Scenario Mapping

El To-Be Scenario Mapping representa el recorrido futuro que ICHU habilitará para cada segmento prioritario. Se modeló en UXPressia con las capas **Doing**, **Thinking** y **Feeling**, de modo que las decisiones de producto mantengan relación con el contexto operativo de cada perfil.

### 3.1.1. Propietario o administrador ganadero

![To-Be Scenario Mapping del propietario o administrador, configurado en UXPressia](images/CHAPTER03/To-Be%20Scenario%20Mapping/To-BeScenarioPorpietario.jpeg)

*Figura 3.1. Recorrido futuro del propietario o administrador: revisión, priorización y seguimiento de alertas.*

### 3.1.2. Capataz u operario de campo

![To-Be Scenario Mapping del capataz u operario, configurado en UXPressia](images/CHAPTER03/To-Be%20Scenario%20Mapping/To-BeScenarioCapataz.jpeg)

*Figura 3.2. Recorrido futuro del capataz u operario: atención de incidencias y registro de evidencia en campo.*

### 3.1.3. Médico veterinario o consultor

![To-Be Scenario Mapping del médico veterinario, configurado en UXPressia](images/CHAPTER03/To-Be%20Scenario%20Mapping/To-BeScenarioVeterinario.jpeg)

*Figura 3.3. Recorrido futuro del médico veterinario: evaluación clínica, indicación y seguimiento de tratamiento.*

**Resultado esperado.** El escenario futuro integra información IoT, atención humana y trazabilidad: una alerta se detecta, se prioriza, se atiende en campo, se sustenta clínicamente cuando corresponde y queda disponible para seguimiento y decisiones posteriores.

## 3.2. User Stories.

Las siguientes historias de usuario se derivan de los Impact Maps de la sección 3.3. Cada una conserva un identificador único para asegurar su trazabilidad con el Product Backlog, los criterios de aceptación y los incrementos de desarrollo.

#### 3.2.1. Historias del propietario o administrador

| ID | Historia de usuario | Criterio de aceptación |
|---|---|---|
| ICHU-US-01 | Como **propietario**, quiero visualizar el estado del hato, alertas activas e indicadores principales para conocer la situación de la estancia al iniciar el día. | **Dado** que tengo acceso a una estancia, **cuando** abro el dashboard, **entonces** visualizo inventario, alertas activas por severidad y métricas del periodo seleccionado. |
| ICHU-US-02 | Como **propietario**, quiero revisar y asignar alertas críticas para asegurar que cada incidencia tenga un responsable. | **Dado** que existe una alerta activa, **cuando** la consulto, **entonces** puedo reconocerla, asignar un responsable y consultar su estado de atención. |
| ICHU-US-03 | Como **propietario**, quiero consultar la ficha de un bovino para conocer su identificación, último estado y eventos recientes. | **Dado** que el bovino está registrado, **cuando** abro su ficha, **entonces** veo sus datos, dispositivo asociado, última ubicación y eventos cronológicos. |
| ICHU-US-04 | Como **propietario**, quiero definir geocercas por lote para recibir una alerta cuando un animal salga de la zona esperada. | **Dado** que gestiono un lote, **cuando** creo o edito una geocerca, **entonces** puedo asociarla al lote y dejarla activa para evaluación. |
| ICHU-US-05 | Como **propietario**, quiero ver la última ubicación y recorrido de un bovino para coordinar su búsqueda. | **Dado** que el bovino tiene telemetría válida, **cuando** lo selecciono en el mapa, **entonces** veo la última posición con fecha y los puntos de recorrido disponibles. |
| ICHU-US-06 | Como **propietario**, quiero generar reportes por lote, animal y periodo para analizar incidencias y tendencias. | **Dado** que existen datos en el periodo elegido, **cuando** aplico filtros, **entonces** obtengo un reporte reutilizable y exportable. |
| ICHU-US-07 | Como **propietario**, quiero registrar bovinos y organizarlos por lotes para mantener el inventario operativo actualizado. | **Dado** que tengo permiso de administración, **cuando** registro o actualizo un bovino o lote, **entonces** el cambio queda disponible sin eliminar el historial previo. |
| ICHU-US-20 | Como **administrador**, quiero asociar un dispositivo IoT a un bovino y verificar su última transmisión para confiar en los datos recibidos. | **Dado** que el dispositivo y el bovino están disponibles, **cuando** realizo la asociación, **entonces** el sistema evita asociaciones activas duplicadas y muestra su última transmisión. |
| ICHU-US-21 | Como **administrador**, quiero configurar los criterios de severidad para que las alertas reflejen el riesgo operativo de mi estancia. | **Dado** que cuento con autorización, **cuando** defino una regla, **entonces** el sistema conserva sus condiciones y el motivo de cada alerta originada. |
| ICHU-US-22 | Como **propietario**, quiero que una alerta crítica sin atender se escale para reducir el riesgo de que quede olvidada. | **Dado** que una alerta crítica permanece sin atender, **cuando** vence el tiempo de escalamiento definido, **entonces** el sistema registra y emite la notificación de escalamiento. |

#### 3.2.2. Historias del capataz u operario de campo

| ID | Historia de usuario | Criterio de aceptación |
|---|---|---|
| ICHU-US-08 | Como **capataz**, quiero ver las alertas ordenadas por severidad para atender primero el caso más urgente. | **Dado** que tengo alertas asignadas o visibles, **cuando** abro la aplicación móvil, **entonces** se muestran severidad, animal, motivo, hora y estado de atención. |
| ICHU-US-09 | Como **capataz**, quiero recibir un aviso visible y audible ante una alerta crítica para no pasarla por alto durante el trabajo de campo. | **Dado** que se genera una alerta crítica, **cuando** el dispositivo puede recibir notificaciones, **entonces** recibo un aviso que me lleva a la ficha de la incidencia. |
| ICHU-US-10 | Como **capataz**, quiero consultar la última ubicación conocida sin señal para dirigirme al punto de búsqueda. | **Dado** que el mapa fue sincronizado previamente, **cuando** no tengo conectividad, **entonces** puedo consultar la última información disponible y su antigüedad. |
| ICHU-US-11 | Como **capataz**, quiero registrar una observación de campo en pocos pasos para dejar evidencia de lo encontrado. | **Dado** que identifico un bovino o incidencia, **cuando** completo el registro, **entonces** puedo guardar animal, tipo de observación, hora, comentario y evidencia opcional. |
| ICHU-US-12 | Como **capataz**, quiero guardar una incidencia sin conectividad para no perder la información levantada en campo. | **Dado** que no hay conexión, **cuando** guardo el evento, **entonces** queda en una cola local con estado pendiente de sincronización. |
| ICHU-US-13 | Como **capataz**, quiero saber cuándo mis registros pendientes se sincronizaron para evitar duplicarlos. | **Dado** que recupero conectividad, **cuando** la aplicación sincroniza, **entonces** veo el resultado, la hora de sincronización y cualquier conflicto que requiera atención. |

#### 3.2.3. Historias del médico veterinario o consultor

| ID | Historia de usuario | Criterio de aceptación |
|---|---|---|
| ICHU-US-14 | Como **veterinario**, quiero revisar tendencias de temperatura y actividad para evaluar una anomalía con contexto. | **Dado** que un bovino tiene telemetría, **cuando** consulto la vista clínica, **entonces** veo las series temporales, línea base disponible, intervalo seleccionado y última lectura. |
| ICHU-US-15 | Como **veterinario**, quiero consultar el historial de observaciones y tratamientos para sustentar mi decisión clínica. | **Dado** que existen eventos del bovino, **cuando** abro su historial, **entonces** puedo revisarlos en orden cronológico y filtrarlos por tipo o estado. |
| ICHU-US-16 | Como **veterinario**, quiero registrar un diagnóstico e indicación para comunicar una acción sanitaria trazable. | **Dado** que evalúo una incidencia, **cuando** registro mi indicación, **entonces** se guardan diagnóstico, recomendación, responsable y fecha de control sin modificar registros anteriores. |
| ICHU-US-17 | Como **veterinario**, quiero confirmar la aplicación y evolución de un tratamiento para decidir si cierro o escalo el caso. | **Dado** que existe un tratamiento indicado, **cuando** reviso el seguimiento, **entonces** visualizo la confirmación de campo y puedo registrar la evolución y el estado del incidente. |
| ICHU-US-18 | Como **veterinario**, quiero comparar alertas y tendencias entre lotes para identificar posibles patrones de riesgo. | **Dado** que hay telemetría y alertas disponibles, **cuando** selecciono lotes y periodo, **entonces** puedo comparar sus conteos y tendencias. |
| ICHU-US-19 | Como **veterinario**, quiero acceder o exportar datos autorizados para integrarlos con herramientas clínicas externas. | **Dado** que cuento con la autorización requerida, **cuando** solicito datos mediante exportación o API, **entonces** recibo únicamente la información permitida y queda trazabilidad del acceso. |

#### 3.2.4. Consideraciones de calidad

Todas las historias que involucren datos de campo deben preservar la marca de tiempo original de captura. Las funciones de telemetría y alertas no sustituyen el diagnóstico veterinario; solo aportan evidencia para priorizar y sustentar la intervención. Antes de incorporarse a un sprint, cada historia debe contar con diseño UX, reglas de negocio, permisos implicados y criterios de aceptación refinados por el equipo.

## 3.3. Impact Map.

El Impact Mapping vincula los resultados de negocio de ICHU con los comportamientos que se espera generar en cada actor, los entregables de software que los habilitan y las historias de usuario que los implementan. Se utiliza como criterio de trazabilidad: una funcionalidad solo ingresa al backlog si contribuye a un impacto identificable.

![Impact Map de ICHU, configurado con la estructura de UXPressia](images/impact_map_ichu.png)

*Figura 3.4. Impact Map de ICHU: objetivo de negocio, actores, impactos, entregables e historias de usuario trazables.*

### 3.3.1. Impact Map - Propietario o administrador ganadero

**Objetivo de negocio:** reducir las pérdidas operativas asociadas a enfermedades detectadas tardíamente, extravío y abigeato, manteniendo visibilidad confiable de la estancia.

| Impacto esperado | Entregables | Historias de usuario relacionadas |
|---|---|---|
| Priorizar oportunamente los animales que requieren intervención | Dashboard ejecutivo, alertas con severidad y asignación de responsables | ICHU-US-01, ICHU-US-02, ICHU-US-03 |
| Coordinar la búsqueda de un animal fuera de la zona segura | Mapa con última ubicación, historial de recorrido y gestión de geocercas | ICHU-US-04, ICHU-US-05 |
| Tomar decisiones de operación sustentadas en evidencia | Reportes por animal/lote y gestión de inventario | ICHU-US-06, ICHU-US-07 |

### 3.3.2. Impact Map - Capataz u operario de campo

**Objetivo de negocio:** reducir el tiempo de respuesta ante incidencias en campo y asegurar el registro íntegro de los eventos, incluso en zonas sin conectividad.

| Impacto esperado | Entregables | Historias de usuario relacionadas |
|---|---|---|
| Reconocer la alerta correcta en condiciones de campo | Lista móvil con severidad, estado de atención y notificación audible/visual | ICHU-US-08, ICHU-US-09 |
| Llegar al último punto conocido del bovino con información disponible | Mapa móvil con ficha resumida y soporte offline | ICHU-US-10 |
| Registrar observaciones sin perderlas por falta de red | Formulario de evento, evidencia opcional, cola local y sincronización visible | ICHU-US-11, ICHU-US-12, ICHU-US-13 |

### 3.3.3. Impact Map - Médico veterinario o consultor

**Objetivo de negocio:** facilitar intervenciones clínicas tempranas y trazables mediante información biométrica e historial de salud consolidado.

| Impacto esperado | Entregables | Historias de usuario relacionadas |
|---|---|---|
| Determinar si una alerta amerita intervención clínica | Tendencias de temperatura y actividad, línea base e historial cronológico | ICHU-US-14, ICHU-US-15 |
| Comunicar, ejecutar y verificar una indicación clínica | Registro de diagnóstico, tratamiento, responsable y control posterior | ICHU-US-16, ICHU-US-17 |
| Detectar patrones de riesgo y colaborar con terceros autorizados | Análisis por lote, exportación y API REST con autorización | ICHU-US-18, ICHU-US-19 |

### 3.3.4. Criterio de priorización

Los entregables que previenen una pérdida o aseguran la continuidad del registro en campo se consideran **Must** para el MVP. Las capacidades analíticas avanzadas e integraciones externas se incorporan después de asegurar la captura, alerta, atención y trazabilidad de la incidencia.

## 3.4. Product Backlog.

El Product Backlog reúne las historias de usuario derivadas de los Impact Maps. La prioridad utiliza MoSCoW: **Must** (imprescindible para el MVP), **Should** (alto valor posterior al núcleo del MVP) y **Could** (deseable, sin bloquear la primera versión). Los criterios de aceptación resumidos permiten verificar el resultado esperado sin prescribir una solución técnica específica.

| N° | ID | Funcionalidad | Historia de usuario | Prioridad | Criterio de aceptación resumido |
|---:|---|---|---|---|---|
| 1 | ICHU-US-01 | Dashboard ejecutivo | Como propietario, quiero visualizar el estado del hato, alertas activas e indicadores principales para conocer la situación de la estancia al iniciar el día. | Must | Muestra inventario, alertas por severidad y métricas del periodo seleccionado. |
| 2 | ICHU-US-02 | Centro de alertas | Como propietario, quiero revisar y asignar alertas críticas para asegurar que cada incidencia tenga un responsable. | Must | Permite filtrar, reconocer, asignar y consultar el estado de una alerta. |
| 3 | ICHU-US-03 | Ficha del bovino | Como propietario, quiero consultar la ficha de un bovino para conocer su identificación, último estado y eventos recientes. | Must | Presenta datos del animal, dispositivo asociado, última ubicación y eventos cronológicos. |
| 4 | ICHU-US-04 | Gestión de geocercas | Como propietario, quiero definir geocercas por lote para recibir una alerta cuando un animal salga de la zona esperada. | Must | Permite crear, editar, activar y asociar una geocerca a un lote. |
| 5 | ICHU-US-05 | Mapa e historial de ubicación | Como propietario, quiero ver la última ubicación y recorrido de un bovino para coordinar su búsqueda. | Must | El mapa identifica al animal, muestra marca de tiempo y puntos de ubicación disponibles. |
| 6 | ICHU-US-06 | Reportes operativos | Como propietario, quiero generar reportes por lote, animal y periodo para analizar incidencias y tendencias. | Should | Permite aplicar filtros y exportar el resultado en un formato reutilizable. |
| 7 | ICHU-US-07 | Gestión de hato y lotes | Como propietario, quiero registrar bovinos y organizarlos por lotes para mantener el inventario operativo actualizado. | Must | Permite crear, editar, consultar y desactivar bovinos y lotes sin borrar su historial. |
| 8 | ICHU-US-08 | Alertas móviles | Como capataz, quiero ver las alertas ordenadas por severidad para atender primero el caso más urgente. | Must | Muestra severidad, animal, motivo, hora y estado de atención con lectura clara en móvil. |
| 9 | ICHU-US-09 | Notificación de incidencia | Como capataz, quiero recibir un aviso visible y audible ante una alerta crítica para no pasarla por alto durante el trabajo de campo. | Must | La alerta crítica genera una notificación configurable y enlaza a la ficha correspondiente. |
| 10 | ICHU-US-10 | Mapa móvil offline | Como capataz, quiero consultar la última ubicación conocida sin señal para dirigirme al punto de búsqueda. | Must | Conserva localmente el último mapa y datos sincronizados, indicando su antigüedad. |
| 11 | ICHU-US-11 | Registro de observación | Como capataz, quiero registrar una observación de campo en pocos pasos para dejar evidencia de lo encontrado. | Must | Registra animal, tipo de observación, hora, comentario y evidencia opcional. |
| 12 | ICHU-US-12 | Registro offline | Como capataz, quiero guardar una incidencia sin conectividad para no perder la información levantada en campo. | Must | Guarda el evento en una cola local e informa que está pendiente de sincronización. |
| 13 | ICHU-US-13 | Sincronización de eventos | Como capataz, quiero saber cuándo mis registros pendientes se sincronizaron para evitar duplicarlos. | Must | Sincroniza al recuperar conexión y muestra resultado, hora y posibles conflictos. |
| 14 | ICHU-US-14 | Vista clínica | Como veterinario, quiero revisar tendencias de temperatura y actividad para evaluar una anomalía con contexto. | Must | Presenta series temporales, línea base disponible, intervalo seleccionado y última lectura. |
| 15 | ICHU-US-15 | Historial clínico | Como veterinario, quiero consultar el historial de observaciones y tratamientos para sustentar mi decisión clínica. | Must | Ordena eventos por fecha y permite filtrar por tipo y estado. |
| 16 | ICHU-US-16 | Diagnóstico e indicación | Como veterinario, quiero registrar un diagnóstico e indicación para comunicar una acción sanitaria trazable. | Must | Registra diagnóstico, recomendación, responsable y fecha de control sin reemplazar registros previos. |
| 17 | ICHU-US-17 | Seguimiento de tratamiento | Como veterinario, quiero confirmar la aplicación y evolución de un tratamiento para decidir si cierro o escalo el caso. | Must | Muestra la confirmación de campo y permite registrar seguimiento y estado del incidente. |
| 18 | ICHU-US-18 | Analítica por lote | Como veterinario, quiero comparar alertas y tendencias entre lotes para identificar posibles patrones de riesgo. | Should | Agrupa datos por lote y periodo, mostrando conteos y tendencias comparables. |

<!-- PDF_PAGE_BREAK -->

| N° | ID | Funcionalidad | Historia de usuario | Prioridad | Criterio de aceptación resumido |
|---:|---|---|---|---|---|
| 19 | ICHU-US-19 | API y exportación autorizada | Como veterinario, quiero acceder o exportar datos autorizados para integrarlos con herramientas clínicas externas. | Could | Expone datos documentados con autenticación, autorización y trazabilidad de acceso. |
| 20 | ICHU-US-20 | Dispositivo y telemetría | Como administrador, quiero asociar un dispositivo IoT a un bovino y verificar su última transmisión para confiar en los datos recibidos. | Must | La asociación es única en el tiempo y muestra estado, batería si está disponible y última transmisión. |
| 21 | ICHU-US-21 | Reglas de alerta | Como administrador, quiero configurar los criterios de severidad para que las alertas reflejen el riesgo operativo de mi estancia. | Should | Permite definir reglas autorizadas y conserva el motivo que originó cada alerta. |
| 22 | ICHU-US-22 | Escalamiento de alerta | Como propietario, quiero que una alerta crítica sin atender se escale para reducir el riesgo de que quede olvidada. | Should | Escala según tiempo y severidad definidos, dejando registro de las notificaciones emitidas. |

**Orden de implementación sugerido.** El primer incremento debe incluir ICHU-US-01 a ICHU-US-05, ICHU-US-07 a ICHU-US-17 y ICHU-US-20, pues conforman el ciclo mínimo de monitoreo: identificar al bovino, recibir telemetría, detectar/atender una alerta, registrar la incidencia y conservar el historial. Las historias restantes se refinan después con estimación del equipo y criterios de negocio validados.
