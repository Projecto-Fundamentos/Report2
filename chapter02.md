# Capítulo II: Requirements Elicitation & Analysis
## 2.1. Competidores.
### 2.1.1. Análisis competitivo.
<style>
    * { box-sizing: border-box; }
    body {
        margin: 0;
        padding: 24px;
        background: #fff;
        font-family: Arial, Helvetica, sans-serif;
        color: #000;
    }
    .container {
        width: 100%;
        max-width: 1200px;
        margin: 0 auto;
    }
    h1 {
        font-size: 22px;
        margin: 0 0 12px 0;
        font-weight: 700;
    }
    .landscape {
        width: 100%;
        border-collapse: collapse;
        table-layout: fixed;
        font-size: 12px;
    }
    .landscape th,
    .landscape td {
        border: 1px solid #000;
        padding: 8px;
        vertical-align: top;
        line-height: 1.3;
    }
    .landscape th {
        text-align: center;
        font-weight: 700;
        background: #fff;
    }
    .analysis-question {
        text-align: left !important;
        font-weight: 400 !important;
    }
    .section {
        width: 8%;
        text-align: center;
        vertical-align: middle !important;
        font-weight: 700;
        writing-mode: vertical-rl;
        transform: rotate(180deg);
    }
    .criterion {
        width: 15%;
        font-weight: 700;
        vertical-align: middle !important;
    }
    .company {
        width: 19.25%;
        text-align: center;
        vertical-align: middle !important;
        font-weight: 700;
    }
    .logo-cell {
        text-align: center;
        vertical-align: middle !important;
        height: 75px;
    }
    .logo-placeholder {
        border: 1px dashed #777;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        width: 125px;
        height: 48px;
        font-size: 11px;
        color: #555;
    }
    .overview { min-height: 120px; }
    .normal { font-weight: 400; }
    .swot-intro {
        font-weight: 400;
        text-align: left;
    }
    .swot-title {
        font-weight: 700;
    }
    @media print {
        body { padding: 0; }
        .container { max-width: none; }
        .landscape { font-size: 10px; }
        .landscape th, .landscape td { padding: 6px; }
    }
</style>
<div class="container">
    <table class="landscape">
        <colgroup>
            <col style="width:8%">
            <col style="width:15%">
            <col style="width:19.25%">
            <col style="width:19.25%">
            <col style="width:19.25%">
            <col style="width:19.25%">
        </colgroup>
        <tr>
            <th colspan="6" style="font-size:15px; text-align:left;">Competitive Analysis Landscape</th>
        </tr>
        <tr>
            <th colspan="2">¿Por qué llevar a cabo este análisis?</th>
            <td colspan="4" class="analysis-question">
                Comparar BoviTrack IoT con sus principales competidores para identificar fortalezas,
                debilidades, oportunidades y amenazas, y determinar una ventaja competitiva clara
                y sostenible en el mercado de monitoreo inteligente de ganado.
            </td>
        </tr>
        <tr>
            <th colspan="2">(En la cabecera colocar por cada competidor nombre y logo)</th>
            <th class="company">Su startup<br><br>ICHU IoT</th>
            <th class="company">Competidor 1<br><br>Allflex SenseHub</th>
            <th class="company">Competidor 2<br><br>Digitanimal</th>
            <th class="company">Competidor 3<br><br>Moocall</th>
        </tr>
        <tr>
            <td rowspan="2" class="section">Perfil</td>
            <td class="criterion">Overview</td>
            <td class="overview">
                Solución digital basada en collares y aretes inteligentes IoT con conectividad
                LoRaWAN y celular híbrida, integrada a una plataforma web y móvil nativa para el
                monitoreo biométrico y localización en tiempo real de ganado en pastoreo extensivo.
            </td>
            <td class="overview">
                Líder global en identificación animal y monitoreo inteligente de ganado lechero y
                de carne, perteneciente al grupo MSD Animal Health, con infraestructura propietaria robusta.
            </td>
            <td class="overview">
                Empresa de base tecnológica española que ofrece collares GPS y sensores para el
                monitoreo de la ubicación, temperatura y comportamiento de animales en pastoreo extensivo.
            </td>
            <td class="overview">
                Compañía irlandesa especializada en dispositivos IoT acoplados a la cola del animal
                para la detección temprana del parto y collares para el monitoreo de celo.
            </td>
        </tr>
        <tr>
            <td class="criterion">Ventaja competitiva<br><span class="normal">¿Qué valor ofrece a los clientes?</span></td>
            <td>
                Conectividad híbrida adaptable (LoRaWAN/Red Celular) con modo offline para
                sincronización retrasada; algoritmos locales de bajo consumo; costo accesible sin
                necesidad de costosas antenas propietarias locales en cada rancho ganadero.
            </td>
            <td>
                Monitoreo biométrico de altísima precisión (rumia, estrés por calor, celo) respaldado
                por décadas de investigación veterinaria y validación clínica a nivel industrial.
            </td>
            <td>
                Alta durabilidad y resistencia del dispositivo GPS, geocofencing de gran precisión
                geográfica y mapeo visual avanzado de rutas de pastoreo sin antenas locales intermedias.
            </td>
            <td>
                Especialización extrema y 100% enfocada en el parto y celo con alertas directas por
                SMS independientes de red local, con alta tasa de éxito preventivo en ganado gestante.
            </td>
        </tr>
        <tr>
            <td rowspan="2" class="section">Perfil de Marketing</td>
            <td class="criterion">Mercado objetivo</td>
            <td>
                Medianos y grandes productores ganaderos en América Latina con ganado de carne y
                doble propósito bajo esquemas de pastoreo extensivo o semi-intensivo.
            </td>
            <td>
                Megaproductores de ganado lechero e industrial de alta producción bajo confinamiento
                o pastoreo intensivo que pueden costear alta infraestructura.
            </td>
            <td>
                Ganaderos de montaña o pastoreo extensivo en Europa y América Latina que sufren
                pérdidas frecuentes por extravío o depredadores.
            </td>
            <td>
                Criadores de ganado vacuno enfocados en la reproducción y mejora genética, con
                rodeos medianos que requieren monitoreo crítico en época de parición.
            </td>
        </tr>
        <tr>
            <td class="criterion">Estrategias de marketing</td>
            <td>
                Demostraciones prácticas en asociaciones ganaderas locales, marketing digital enfocado
                en el ahorro de mano de obra y reducción de tasas de mortalidad animal, alianzas con
                veterinarias locales.
            </td>
            <td>
                Venta consultiva directa corporativa, presencia imponente en ferias internacionales
                agropecuarias, marketing científico con publicaciones respaldadas por veterinarios.
            </td>
            <td>
                Marketing de contenidos enfocado en la prevención del robo de ganado (abigeato),
                campañas digitales basadas en casos de éxito de recuperación de animales extraviados.
            </td>
            <td>
                Publicidad de nicho en revistas y foros especializados en inseminación y cría,
                demostraciones de "antes y después" del parto, y distribución mediante veterinarias aliadas.
            </td>
        </tr>
        <tr>
            <td rowspan="3" class="section">Perfil de Producto</td>
            <td class="criterion">Productos &amp; Servicios</td>
            <td>
                Arete y collar inteligente con acelerómetro y sensor de temperatura; aplicación móvil
                nativa (Android/iOS); plataforma web de gestión analítica; API RESTful para servicios veterinarios.
            </td>
            <td>
                Collares y aretes inteligentes SenseHub, antenas receptoras propietarias fijas de largo
                alcance, software SaaS de escritorio y aplicación móvil de alertas en tiempo real.
            </td>
            <td>
                Collares de localización GPS con sensores de temperatura, plataforma web de visualización
                cartográfica, y aplicaciones para dispositivos móviles de rastreo y geocofencing.
            </td>
            <td>
                Sensor Moocall Calving (acoplado a la cola), collar Moocall HEAT, servicio SaaS de envío
                de alertas por mensajes de texto integrados y aplicación para teléfonos inteligentes.
            </td>
        </tr>
        <tr>
            <td class="criterion">Precios &amp; Costos</td>
            <td>
                Dispositivos de bajo costo de adquisición única; plan de suscripción mensual flexible por
                escala de ganado (Premium y Básico) adaptado al volumen real del ganadero.
            </td>
            <td>
                Costo de adquisición de hardware muy elevado; tarifas de instalación de antenas propietarias
                muy costosas; contrato de licenciamiento SaaS anual rígido y de alto valor.
            </td>
            <td>
                Costo moderado por dispositivo collar; suscripción anual obligatoria por la conectividad
                Sigfox/celular integrada en cada collar de forma independiente.
            </td>
            <td>
                Costo único por el sensor de parto; cuota de servicio anual fija obligatoria para cubrir
                el costo de las alertas de telefonía celular global por SMS.
            </td>
        </tr>
        <tr>
            <td class="criterion">Canales de distribución<br>(Web y/o Móvil)</td>
            <td>
                Plataforma web (Landing Page) con e-commerce integrado; distribuidores regionales de
                insumos agropecuarios; y tiendas oficiales de aplicaciones móviles nativas.
            </td>
            <td>
                Red global de distribuidores autorizados exclusivos de MSD Animal Health y representantes
                de ventas técnicas directas en zonas ganaderas industriales.
            </td>
            <td>
                Sitio web con tienda en línea directa; envíos internacionales; alianzas de distribución
                con redes de telecomunicaciones IoT (como Sigfox y Telefónica).
            </td>
            <td>
                Tienda en línea oficial, marketplaces especializados (Amazon, agro-tiendas), y cooperativas
                ganaderas autorizadas con presencia física internacional.
            </td>
        </tr>
        <tr>
            <td rowspan="5" class="section">Análisis SWOT</td>
            <td colspan="5" class="swot-intro">
                <span class="swot-title">Realice esto para su startup y sus competidores.</span>
                Sus fortalezas deberían apoyar sus oportunidades y contribuir a lo que ustedes definen
                como su posible ventaja competitiva.
            </td>
        </tr>
        <tr>
            <td class="criterion">Fortalezas</td>
            <td>
                Conectividad híbrida LoRaWAN/celular de bajo consumo, soporte nativo de modo sin conexión
                (offline) para guardado local en zonas remotas, arquitectura de software basada en
                microservicios ágiles que facilita la integración rápida mediante API RESTful con laboratorios
                y veterinarias.
            </td>
            <td>
                Respaldo de una multinacional farmacéutica veterinaria, algoritmos de rumia probados
                científicamente a nivel mundial, red de soporte técnico in situ de alta presencia.
            </td>
            <td>
                Dispositivos muy resistentes con excelente diseño industrial hermético, fuerte presencia
                de marca en el mercado ganadero de habla hispana.
            </td>
            <td>
                Solución sumamente específica y validada para la reducción de mortalidad de terneros durante
                el parto, sin necesidad de configuraciones de red complejas por parte del usuario.
            </td>
        </tr>
        <tr>
            <td class="criterion">Debilidades</td>
            <td>
                Marca nueva en el mercado sin posicionamiento previo, presupuesto de marketing inicialmente
                limitado, dependencia de la capacidad de ensamblaje inicial para los lotes de collares y aretes físicos.
            </td>
            <td>
                Costo de inversión restrictivo para productores pequeños y medianos, obligatoriedad de instalar
                antenas fijas receptoras en el terreno (inviable para grandes pastizales extensivos sin energía eléctrica).
            </td>
            <td>
                Elevado consumo de batería debido al uso intensivo de GPS directo por collar, falta de integración
                directa y amigable con servicios locales de atención de salud animal del sector.
            </td>
            <td>
                Alcance funcional muy limitado (no sirve para geolocalización, control de pastoreo diario,
                ni detección generalizada de enfermedades comunes del ganado).
            </td>
        </tr>
        <tr>
            <td class="criterion">Oportunidades</td>
            <td>
                Creciente necesidad de digitalización en el sector ganadero latinoamericano para mitigar el
                robo de ganado (abigeato); alta disponibilidad de redes de comunicación IoT abiertas de largo alcance (LoRaWAN).
            </td>
            <td>
                Migración de medianos ganaderos hacia ganaderías intensivas de alta eficiencia donde el
                retorno de inversión se percibe más rápido.
            </td>
            <td>
                Expansión de redes de conectividad celular de banda estrecha (NB-IoT) en América Latina
                que podrían reducir el consumo de sus baterías.
            </td>
            <td>
                Alianzas con proveedores de semen y genética bovina para empaquetar el dispositivo en
                programas de reproducción bovina de alta gama.
            </td>
        </tr>
        <tr>
            <td class="criterion">Amenazas</td>
            <td>
                Fluctuación de precios de los componentes electrónicos para la fabricación de los collares;
                posibilidad de ingreso rápido de competidores chinos de bajo costo con hardware genérico sin valor analítico.
            </td>
            <td>
                Desintermediación del mercado por soluciones de software de código abierto e integraciones
                de sensores genéricos.
            </td>
            <td>
                Lanzamiento de collares inteligentes de bajo costo por parte de startups locales latinoamericanas
                con mejor soporte al cliente y tarifas flexibles.
            </td>
            <td>
                Obsolescencia del dispositivo de cola si los collares biométricos de la competencia logran
                predecir el parto con la misma o mayor precisión a menor costo general.
            </td>
        </tr>
    </table>
</div>

### 2.1.2. Estrategias y tácticas frente a competidores.

Para posicionar a ICHU IoT con éxito, nuestra startup implementará un conjunto de estrategias y tácticas comerciales y de ingeniería de software orientadas a contrarrestar las fortalezas de los competidores establecidos y capitalizar sus debilidades en el contexto ganadero latinoamericano:

**Estrategia 1:** Reducción de Barreras Económicas y Tecnológicas de Infraestructura
Táctica Comercial: Eliminar la necesidad de costosas antenas fijas propietarias en el rancho ganadero (la gran debilidad de Allflex). El ganadero podrá optar por aretes inteligentes que transmiten de forma local a un único collar maestro (que actúa como dispositivo gateway en el animal líder de la manada), reduciendo a una fracción los costos de instalación física.
Táctica de Ingeniería: Diseñar el collar inteligente con conectividad híbrida que almacene la telemetría en memoria flash local cuando el ganado se encuentre en "zonas ciegas" sin señal. Una vez que el ganado retorne a áreas de cobertura o se aproxime al corral principal, los datos se sincronizarán de forma transparente y asíncrona hacia nuestro Edge API.

**Estrategia 2:** Optimización Energética de los Dispositivos Físicos
Táctica Comercial: Promocionar una vida útil de la batería de los aretes y collares de hasta 3 años, reduciendo drásticamente las horas de mano de obra asociadas al cambio de baterías y manipulación estresante del ganado (superando la debilidad de Digitanimal).
Táctica de Ingeniería: Implementar en los dispositivos embebidos un algoritmo inteligente de transmisión dinámica. Si el ganado se encuentra en reposo (determinado por el acelerómetro local), el módulo GPS/transmisor entra en modo de ultra bajo consumo (Deep Sleep), transmitiendo únicamente cuando se detecten patrones de actividad inusual, geocofencing cruzado o anomalías térmicas en el animal.

**Estrategia 3:** Flexibilidad de Suscripción y Monetización Adaptativa
Táctica Comercial: Ofrecer un modelo de negocio SaaS con planes escalables basados en el tamaño real de la unidad ganadera (por cabeza de ganado), permitiendo a los medianos productores adoptar la tecnología de forma incremental. Esto contrasta directamente con los planes de pago anuales rígidos e inaccesibles de Allflex y Digitanimal.
Táctica de Ingeniería: Implementar en nuestro backend de servicios web un módulo dinámico de suscripciones y facturación asimilado por el microservicio correspondiente, permitiendo habilitar o deshabilitar de forma automática características del software (como reportes avanzados o alertas SMS críticas) basándose en el plan activo del usuario.

**Estrategia 4:** Integración del Ecosistema de Salud mediante API RESTful de Desarrollo Interno
Táctica Comercial: Posicionar a ICHU IoT no solo como un rastreador o un sensor aislado, sino como una plataforma abierta que conecta al ganadero con su médico veterinario de confianza. El veterinario podrá visualizar análisis clínicos e históricos de salud de manera remota para prescribir tratamientos oportunos, reduciendo las visitas físicas improductivas.
Táctica de Ingeniería: Diseñar y documentar rigurosamente los endpoints de nuestro RESTful API con OpenAPI/Swagger, permitiendo que sistemas externos de laboratorios o software de gestión de terceros se integren de forma segura mediante protocolos estandarizados, expandiendo el valor del ecosistema sin comprometer la seguridad de la información.

## 2.2. Entrevistas.
### 2.2.1. Diseño de entrevistas.
A continuación, se presenta la relación de preguntas principales y complementarias estructuradas para cada uno de los tres segmentos objetivo identificados. El cuestionario recopila tanto la información demográfica y de perfil requerida para construir los User Personas (arquetipos) como la información operativa y de dolor para mapear los requisitos de software del sistema.

**Segmento 1:** Medianos y Grandes Ganaderos (Propietarios y Administradores de Estancias)
Este segmento representa al comprador principal (Buyer Persona) y tomador de decisiones financieras de la estancia. El objetivo es identificar la viabilidad de la plataforma web administrativa, el modelo de suscripción SaaS y los indicadores clave (KPIs) de productividad que desean ver en pantalla .

**A. Datos Demográficos y de Perfil (Información Complementaria)**
1. ¿Cuál es su nombre, edad, nivel de instrucción y en qué distrito/región se encuentra su estancia ganadera?  
2. ¿Cuántas personas conforman su familia y de qué manera participan en el negocio ganadero?  
3. ¿Cuál es su ocupación o rol principal en el día a día del rancho ganadero?  
4. ¿Qué dispositivos digitales prefiere utilizar en su rutina diaria (computadora de escritorio, laptop, tablet, teléfono inteligente)?  
5. ¿Qué canales digitales y redes sociales utiliza con mayor frecuencia para comunicarse o informarse sobre temas ganaderos?  
6. ¿Cuáles son sus marcas e influencias tecnológicas preferidas (ej. marcas de celulares, herramientas de gestión)?  
**B. Preguntas de Comportamiento e Infraestructura**  
7. ¿Cuántas cabezas de ganado maneja actualmente en su unidad productiva y bajo qué régimen (pastoreo extensivo, estabulado o semi-intensivo)?  
8. ¿Qué herramientas o sistemas de software utiliza actualmente para llevar el control del inventario de animales, partos, muertes e historial médico?  
9. ¿Cómo es el estado de la conectividad a internet (red celular 3G/4G/5G, internet satelital, etc.) en la casa del rancho y en las zonas de pastoreo?  
**C. Preguntas sobre Dolores y Frustraciones**  
10. ¿Cuál ha sido la pérdida económica más significativa que ha tenido en el último año debido a enfermedades no detectadas a tiempo o muerte súbita de animales?  
11. ¿Cómo le afecta el robo de ganado (abigeato) o el extravío de animales en términos de costos de búsqueda y pérdida patrimonial?  
12. Al contratar consultorías veterinarias externas, ¿cuáles son los principales problemas de comunicación o falta de datos históricos que experimenta?  
**D. Validación de la Propuesta de Software (ICHU)**
13. Si existiera una plataforma web que centralizara el historial de salud, ubicación y alertas térmicas de cada animal sin que usted tenga que estar físicamente en el corral, ¿cómo cambiaría su proceso de toma de decisiones?  
14. ¿Qué información cuantitativa (gráficos de temperatura, horas de actividad, alertas de celo) consideraría indispensable visualizar en un tablero de control ejecutivo?  
15. ¿Bajo qué condiciones o modelo de suscripción (ej. un pago mensual por cabeza de ganado monitoreada) consideraría rentable implementar esta solución de software en su negocio?   

**Segmento 2:** Capataces y Operarios Ganaderos de Campo  
Este segmento representa al usuario operativo directo que interactuará con la aplicación móvil nativa en el terreno. El objetivo es validar la usabilidad móvil bajo condiciones climáticas adversas, el alfabetismo digital y la relevancia del sistema de alertas push/SMS en tiempo real.

**A. Datos Demográficos y de Perfil (Información Complementaria)**
1. ¿Cuál es su nombre, edad, nivel de instrucción y dónde reside actualmente?  
2. ¿Cuánto tiempo lleva trabajando en el cuidado de ganado en campo abierto y cuál es su experiencia en estas tareas?  
3. ¿Qué tipo de teléfono celular utiliza actualmente para su trabajo diario y de qué marca es?  
4. ¿Qué aplicaciones utiliza todos los días (ej. WhatsApp, redes sociales, herramientas de clima) y qué tan cómodo se siente aprendiendo a usar nuevas aplicaciones?  
5. ¿Prefiere interactuar con interfaces visuales (iconos, mapas, colores) o prefiere la lectura de textos detallados?  
**B. Preguntas de Comportamiento y Dolores en el Campo**  
5. ¿Cómo realiza el recorrido diario de pastoreo para verificar que todos los animales estén completos y sanos?  
7. ¿Qué hace cuando nota que un animal no se encuentra con el grupo o se ha apartado en una zona de difícil acceso? Describa el esfuerzo físico y de tiempo que le toma encontrarlo.  
8. ¿Cuál es su procedimiento cuando identifica visualmente que un bovino muestra signos de decaimiento o fiebre?  
9. ¿Cómo lo registra y a quién se lo reporta?  
10. ¿Qué dificultades experimenta cuando el teléfono celular pierde la cobertura de red mientras realiza labores en las zonas más alejadas del pastizal?  
**C. Validación de la Usabilidad de la Aplicación Móvil (ICHU Mobile)**  
11. Si la aplicación móvil de ICHU le permitiera ver en un mapa digital interactivo la última posición registrada de un animal extraviado, ¿cómo facilitaría esto su labor diaria de búsqueda?  
12. En una zona sin señal celular, ¿qué valor tendría para usted que la aplicación móvil guarde de forma local en su teléfono las alertas y datos ingresados, para luego sincronizarlos automáticamente cuando recupere la señal?  
13. Para la gestión de alertas en campo, ¿qué tipo de aviso prefiere recibir (un mensaje de texto SMS automático, una notificación push con sonido fuerte, o una alerta visual de color rojo en pantalla)?  
14. ¿Qué tan simple e intuitiva debe ser la interfaz de la aplicación para que pueda registrar un evento de salud en menos de tres toques, considerando que suele estar expuesto al sol o usando guantes?  

**Segmento 3:** Médicos Veterinarios y Consultores de Salud Animal  
Este segmento proporciona el sustento técnico-científico del dominio de salud. El objetivo es validar qué variables cuantitativas de telemetría biométrica (temperatura, acelerometría) requiere el veterinario para predecir anomalías de salud y cómo la API RESTful de ICHU debe estructurar los historiales clínicos para consumo de sistemas externos .

**A. Datos Demográficos y de Perfil (Información Complementaria)**< 
1. ¿Cuál es su nombre, especialidad médica veterinaria, años de ejercicio profesional y ámbito geográfico de atención?  
2. ¿A cuántos establos o estancias ganaderas brinda consultoría o servicio médico clínico actualmente? 
3. ¿Qué dispositivos informáticos y sistemas de gestión veterinaria utiliza habitualmente para registrar el  historial de tratamientos y diagnósticos?  
4. ¿Cuáles son sus principales fuentes de actualización profesional y canales de comunicación digital preferidos con sus clientes?  
**B. Preguntas de Comportamiento y dolores de Diagnóstico**
5. ¿Cuáles son los principales retos clínicos que enfrenta al diagnosticar enfermedades infecciosas comunes (ej. neumonía bovina, mastitis o problemas reproductivos) bajo esquemas de pastoreo extensivo?  
6. ¿Qué tan común es que los ganaderos lo llamen para atender una emergencia médica cuando el animal ya se encuentra en una etapa clínica crítica o irreversible? ¿Cómo impacta esto en la tasa de mortalidad?  
7. Al realizar un diagnóstico, ¿qué parámetros cuantitativos continuos (ej. cambios en la temperatura rectal, niveles de actividad física diaria, ciclos de rumia) desearía conocer del animal pero que actualmente le es imposible medir de forma manual?
8. ¿Cómo gestiona hoy en día los historiales de vacunación, inseminación y aplicación de medicamentos de los establos que asesora? ¿Qué tan confiables son esos registros manuales?
**C. Validación de la Plataforma Analítica y APIs (ICHU Web/Services)**
9. Si pudiera acceder de forma remota a una plataforma web con el historial de temperatura y patrones de comportamiento de las últimas 2 semanas de un bovino reportado con alertas de decaimiento, ¿cómo optimizaría esto su diagnóstico y la prescripción de tratamientos?
10. ¿Qué gráficos cuantitativos históricos consideraría indispensables que nuestro sistema de software genere para facilitar su análisis epidemiológico a nivel de todo el lote de ganado?  
11. Dado que trabajamos bajo un enfoque de ingeniería de software estructurado, ¿qué tan importante es para usted que la información recopilada por ICHU se pueda exportar en formatos estándar o integrar mediante servicios web seguros (APIs) con laboratorios clínicos o sistemas de registro oficial del Estado?  

### 2.2.2. Registro de entrevistas.
### 2.2.3. Análisis de entrevistas.
## 2.3. Needfinding.
En esta sección se consolidan y sintetizan los hallazgos cualitativos y cuantitativos obtenidos durante la fase de investigación de campo, entrevistas en profundidad y análisis competitivo. El proceso de Needfinding nos permite transformar los datos brutos recolectados de los actores del sector ganadero en artefactos visuales y estructurados de diseño de experiencia de usuario (UX), garantizando que el desarrollo del ecosistema de software ICHU responda de manera directa a las necesidades reales, dolores operativos y metas estratégicas de cada perfil de usuario.


### 2.3.1. User Personas.

Introducción y Metodología
Para la construcción de los arquetipos de usuario (User Personas), el equipo procesó la información recolectada en la fase de entrevistas y análisis del mercado ganadero. Se identificaron tres patrones de comportamiento distintivos que representan fielmente a los tres segmentos objetivo definidos para el ecosistema de software ICHU:

**Segmento 1:** Propietarios y Administradores Ganaderos, enfocados en la rentabilidad, reducción de pérdidas por mortalidad/abigeato y la toma de decisiones estratégicas basadas en indicadores clave expresados en la ICHU Web Application.
**Segmento 2:** Capataces y Operarios de Campo, centrados en la usabilidad en terreno, la rápida localización de los animales y el registro ágil de eventos mediante la ICHU Mobile Application con soporte para modo sin conexión (offline).
**Segmento 3:** Médicos Veterinarios y Consultores, orientados al monitoreo biométrico continuo, diagnóstico clínico temprano y la revisión de historiales de salud consolidados a través de vistas especializadas y la integración con la API RESTful de desarrollo interno.  

Cada ficha de User Persona ha sido especificada considerando todos los atributos recomendados para arquetipos UX (datos demográficos, biografía, personalidad, objetivos, frustraciones, tecnología de preferencia, marcas/influencias y necesidades específicas de software), habiendo sido modeladas estructuralmente en la herramienta UXPressia.


### 2.3.2. User Task Matrix.
### 2.3.3. User Journey Mapping.
### 2.3.4. Empathy Mapping.
## 2.4. Big Picture EventStorming.
## 2.5. Ubiquitous Language.