# Conclusiones

## Conclusiones y recomendaciones

### 1. Resultado frente al Problem Statement

El Problem Statement de ICHU plantea que la gestión extensiva del ganado depende de inspecciones visuales, identificación física y registros dispersos en cuadernos o hojas de cálculo. Esa situación dificulta conocer la evolución de cada animal, detectar anomalías a tiempo y actuar cuando la conectividad es irregular. La solución propuesta combina collares inteligentes, una API RESTful central, servicios de borde y aplicaciones web y móvil para centralizar la información, generar alertas y mantener la continuidad de las faenas.

La investigación realizada en el Capítulo II brinda evidencia preliminar a favor de este problema. Se realizaron seis entrevistas, tres a representantes del segmento de medianos y grandes ganaderos y tres a zootecnistas y médicos veterinarios. En el cuestionario del primer segmento, el 50 % indicó utilizar hojas de cálculo y el 50 % cuadernos o registros manuales; el 100 % calificó como muy útil una plataforma que centralice historial, ubicación y alertas. Además, el 100 % reportó conectividad regular en las zonas de pastoreo, pérdidas del 5 % al 10 % del valor del hato y preferencia por una suscripción anual con tarifa fija.

En el segundo segmento, el 66.7 % calificó los registros manuales como moderadamente confiables y el 100 % indicó que necesita conocer continuamente variables que no puede medir de forma manual, como rumia, actividad, temperatura y frecuencias cardíaca y respiratoria. Estos resultados sostienen la relevancia de una historia clínica digital, telemetría continua, alertas configurables, acceso móvil y operación sin conexión. Sin embargo, esta evidencia valida principalmente la existencia y relevancia del problema; todavía no demuestra que el producto implementado logre los resultados de negocio previstos.

### 2. Assumptions frente al comportamiento observado

Los hallazgos respaldan de manera inicial algunos supuestos del Lean UX Process. La preferencia por el pago anual con tarifa fija, la necesidad de una ficha centralizada por animal, la operación en zonas con conectividad intermitente y la demanda de alertas sanitarias y reproductivas son consistentes con las respuestas y entrevistas documentadas. También se confirma que el veterinario necesita combinar trabajo de campo y oficina, por lo que la solución debe mantener la información sincronizada entre las aplicaciones móvil y web.

Todavía no se pueden confirmar los supuestos que requieren resultados longitudinales o pruebas técnicas. Permanecen abiertos la reducción del 15 % de la mortalidad, las 150 suscripciones activas durante el primer año, la renovación superior al 92 %, la tasa de fallas inferior al 2 %, la reducción del CAC, la autonomía de tres años del collar, la precisión de los sensores, el tiempo de entrega de las notificaciones y la tasa de sincronización offline. Cada uno debe validarse mediante un piloto instrumentado, pruebas de laboratorio y campo, métricas de uso y entrevistas posteriores.

### 3. Hypothesis Statements y criterios de éxito

Las cuatro hipótesis definidas en el Capítulo I mantienen trazabilidad con las características priorizadas en los Capítulos II, III y IV:

| Hipótesis | Característica relacionada | Estado de la evidencia en AV1 |
|---|---|---|
| Biometric and GPS Tracking | Collar inteligente de bajo consumo con temperatura, actividad y posición | El problema y la necesidad fueron respaldados por entrevistas; la precisión, autonomía y utilidad aún no fueron probadas con un prototipo funcional. |
| Real-Time Alerts | Motor de alertas móviles y por mensaje de texto | La demanda de alertas fue recurrente en ambos segmentos; aún no se midieron tiempo de entrega, falsos positivos ni reducción de mortalidad. |
| Analytics Dashboard | Panel de indicadores, tendencias e historial biométrico | Se identificó la necesidad de reportes comparativos y datos continuos; aún no existe validación de tareas sobre un panel implementado. |
| Offline Operation | Almacenamiento local y sincronización al recuperar la señal | La conectividad irregular fue confirmada; aún faltan pruebas de campo sobre registros offline, conflictos y sincronizaciones exitosas. |

Por tanto, los criterios de éxito iniciales - uso frecuente de la aplicación, respuesta oportuna ante alertas críticas y reducción de pérdidas del ganado - deben considerarse objetivos de validación y no resultados alcanzados. AV1 entrega la especificación del problema, los requisitos y el diseño; no contiene todavía evidencia suficiente para declarar aceptadas o rechazadas las hipótesis.

### 4. Recomendaciones y roadmap

Para la siguiente etapa se recomienda:

1. Consolidar la evidencia documental disponible del informe: capturas de EventStorming, Journey Maps, Impact Map, Product Backlog y actividad colaborativa, junto con los enlaces públicos correspondientes.
2. Desarrollar el primer incremento siguiendo el alcance comprometido del Product Backlog: Landing Page con internacionalización y accesibilidad, acceso a la plataforma y ficha inicial del animal.
3. Implementar después el flujo de telemetría de extremo a extremo, incluyendo collar, Edge API, API central, alertas y sincronización offline con control de duplicados y conflictos.
4. Continuar con analítica del hato, planificación sanitaria, atención veterinaria, suscripciones y el controlador del abrevadero, manteniendo la trazabilidad con los Business Goals.
5. Ejecutar un piloto con unidades productivas de los dos segmentos. Antes de iniciar, definir la línea base de mortalidad, tiempo de respuesta, registros completos, frecuencia de uso, disponibilidad de dispositivos y resultados de sincronización.
6. Mantener como roadmap posterior las integraciones con laboratorios, nutrición y meteorología, el seguimiento clínico avanzado y el mantenimiento ampliado del inventario.

La arquitectura modular, los siete Bounded Contexts y el Product Backlog de 71 historias proporcionan una base adecuada para evolucionar ICHU sin perder trazabilidad. La siguiente iteración debe convertir los supuestos de alto riesgo en experimentos medibles y actualizar las decisiones del dominio con la evidencia obtenida.

## Video About-the-Team

### Propósito y contenido requerido

El video presenta la startup, el problema investigado, los artefactos de requisitos y diseño, la organización del trabajo colaborativo y las conclusiones del equipo.

### Pauta de secuencias

| Secuencia | Inicio sugerido | Contenido |
|---|---:|---|
| Presentación del equipo | 00:00:00 | Startup, producto ICHU, integrantes y roles |
| Proceso de investigación | 00:01:00 | Entrevistas, cuestionarios, Needfinding y hallazgos |
| Requisitos y diseño | 00:03:00 | User Stories, Impact Mapping, Bounded Contexts y arquitectura |
| Trabajo colaborativo | 00:05:00 | GitFlow, revisión de artefactos y organización del repositorio |
| Testimonios individuales | 00:07:00 | Actividades, Student Outcome y competencias de cada integrante |
| Cierre y próximos pasos | 00:13:00 | Roadmap, validaciones y aprendizajes del equipo |

# Bibliografía

Referencias utilizadas en el informe, conservando la numeración empleada por las citas del Capítulo I y aplicando el formato APA 7.ª edición:

[1] Instituto Nacional de Estadística e Informática. (2023). *Encuesta Nacional Agropecuaria 2023*. INEI. https://proyectos.inei.gob.pe/iinei/srienaho/Descarga/DocumentosMetodologicos/2023-62/05_PUBLICACION_ENA_2023.pdf

[2] Ministerio de Desarrollo Agrario y Riego. (s. f.). *Sistema Integrado de Estadística Agraria (SIEA)*. MIDAGRI. https://siea.midagri.gob.pe/

[3] Organismo Supervisor de Inversión Privada en Telecomunicaciones. (s. f.). *Estadísticas y reportes de servicios de telecomunicaciones*. OSIPTEL. https://repositorio.osiptel.gob.pe/handle/20.500.12630/4

[4] Servicio Nacional de Sanidad Agraria. (s. f.). *Campañas de vacunación y prevención sanitaria para la ganadería*. SENASA. https://www.senasa.gob.pe/

[5] Brown, S. (2023). *The C4 model for visualising software architecture*. https://c4model.com/

[6] Evans, E. (2003). *Domain-driven design: Tackling complexity in the heart of software*. Addison-Wesley.

[7] Gothelf, J., & Seiden, J. (2021). *Lean UX: Creating great products with agile teams* (3.ª ed.). O'Reilly Media.

# Anexos

## Anexo A. Organización del entregable

Este documento reúne las conclusiones y recomendaciones del proyecto, la pauta del Video About-the-Team, la bibliografía consultada y las evidencias externas que complementan los capítulos del informe.

- Las conclusiones relacionan el problema, los hallazgos de investigación, las hipótesis y el roadmap.
- La bibliografía reúne las fuentes utilizadas para fundamentar el análisis y el diseño.
- Los anexos organizan los enlaces de entrevistas, herramientas colaborativas, encuestas, repositorio y fuentes de diagramas.

## Anexo B. Evidencia documental

**Solution Profile y Lean UX Process**<br>
https://github.com/SmartFarm-8733/Report-SmartFarm/blob/feature/conclusions/chapter01.md

**Requirements Elicitation & Analysis**<br>
https://github.com/SmartFarm-8733/Report-SmartFarm/blob/feature/conclusions/chapter02.md

**Requirements Specification**<br>
https://github.com/SmartFarm-8733/Report-SmartFarm/blob/feature/conclusions/chapter03.md

**Solution Software Design**<br>
https://github.com/SmartFarm-8733/Report-SmartFarm/blob/feature/conclusions/chapter04.md

**Student Outcome y colaboración**<br>
https://github.com/SmartFarm-8733/Report-SmartFarm/blob/feature/conclusions/README.md

## Anexo C. Videos y entrevistas

Este anexo reúne las evidencias audiovisuales proporcionadas por el equipo. Los enlaces se conservan como recursos externos y se muestran completos para facilitar su consulta.

**Entrevistas completas**<br>
Carpeta con los videos completos de las entrevistas de los dos segmentos objetivo.<br>
https://drive.google.com/drive/folders/1Lx-SoAs_OQUHSQWLl1PhLo1HGMW5-NvT?usp=sharing

**Entrevistas editadas**<br>
Video consolidado de las entrevistas para la evidencia del informe.<br>
https://upcedupe-my.sharepoint.com/:v:/g/personal/u202323243_upc_edu_pe/IQCWBM7VmG-wQpKSMg4lQ3R4ARyUf9668Ua8FlogmvsDBS0?nav=eyJyZWZlcnJhbEluZm8iOnsicmVmZXJyYWxBcHAiOiJPbmVEcml2ZUZvckJ1c2luZXNzIiwicmVmZXJyYWxBcHBQbGF0Zm9ybSI6IldlYiIsInJlZmVycmFsVmlldyI6Ik15RmlsZXNMaW5rQ29weSJ9fQ&e=pKyJVK

**Video de exposición AV1 — Primera exposición**<br>
Exposición inicial del informe.<br>
https://upcedupe-my.sharepoint.com/:f:/g/personal/u202323243_upc_edu_pe/IgCUSf6VBMS2RpDCw5IECY7KAeH3mMYiKRCK6R4jruEgR7M?e=E6tBZt

## Anexo D. Herramientas colaborativas y artefactos de modelado

**Figma / FigJam**<br>
Big Picture EventStorming, Bounded Context Canvases y Domain Message Flows.<br>
https://www.figma.com/board/weAhLf9otmp9sh32i7ke4i/SmartFarm-%E2%80%94-2.4-Big-Picture-EventStorming.jam?node-id=0-1&t=4gtnxsvBNUxUdR76-1

**Miro**<br>
Design-Level EventStorming y Candidate Context Discovery.<br>
https://miro.com/welcomeonboard/ekNIeWVQcC9hcG1mM292c2E0RkcwblUxUSttUDFCSmpZMjBTQldxOENSNVdtbTNiWEZQSXRaQWg1UWk4bmpDYjVzNnNHanMrV3J5RDZZc2RaeXNBSDQ4ZWRzaFRaNi9qbXJsUlBtblZobDFOeS9aTGFyK1BJWDNUVGozSUVYSHhhWWluRVAxeXRuUUgwWDl3Mk1qRGVRPT0hdjE=?share_link_id=680912547552

**UXPressia**<br>
User Personas, User Journey Maps, Empathy Maps, As-Is e Impact Mapping.<br>
https://uxpressia.com/w/v8FzI/t/AIZ5N

## Anexo E. Encuestas y material de investigación

**Ganadero**<br>
Encuesta extensa del segmento de ganaderos.<br>
https://drive.google.com/file/d/1WZdTKVgyGmAlKlI4ZXnRhkK2MJL7fO8D/view?usp=sharing

**Zootecnista / veterinario**<br>
Encuesta extensa del segmento profesional.<br>
https://drive.google.com/file/d/15h2MLOWtvMBic0O97VnSMJxAeW9ZpUy2/view?usp=drive_link

Estas evidencias complementan los resúmenes, análisis de entrevistas, User Personas y mapas incluidos en el Capítulo II.

## Anexo F. Repositorio y organización del proyecto

**Repositorio del informe**<br>
Fuente versionada del Project Report y sus artefactos.<br>
https://github.com/SmartFarm-8733/Report-SmartFarm

**Organización**<br>
Organización pública de GitHub de SmartFarm-8733.<br>
https://github.com/SmartFarm-8733

**README del repositorio**<br>
Registro de versiones, colaboración, Student Outcome y navegación del informe.<br>
https://github.com/SmartFarm-8733/Report-SmartFarm/blob/feature/conclusions/README.md

**Informe completo**<br>
Capítulos I-IV, conclusiones, bibliografía y anexos.<br>
https://github.com/SmartFarm-8733/Report-SmartFarm/tree/feature/conclusions

## Anexo G. Fuentes de diagramas y artefactos versionados

**C4 Model — Workspace Structurizr DSL**<br>
https://github.com/SmartFarm-8733/Report-SmartFarm/blob/feature/conclusions/diagrams/structurizr/workspace-ichu-c4.dsl

**C4 Model — imágenes exportadas**<br>
System Landscape, Context, Container, Deployment y Components.<br>
https://github.com/SmartFarm-8733/Report-SmartFarm/tree/feature/conclusions/images/diagrams/c4

**UML y diseño de base de datos — fuentes PlantUML**<br>
Clases, context maps y bases de datos.<br>
https://github.com/SmartFarm-8733/Report-SmartFarm/tree/feature/conclusions/diagrams/puml

**UML y diseño de base de datos — imágenes renderizadas**<br>
Clases, context maps y esquemas.<br>
https://github.com/SmartFarm-8733/Report-SmartFarm/tree/feature/conclusions/images/diagrams

Los enlaces de este anexo apuntan a contenido versionado dentro del mismo repositorio. Los enlaces de Figma, Miro, UXPressia, Drive y SharePoint apuntan a los espacios externos donde se elaboraron o almacenan los artefactos originales.
