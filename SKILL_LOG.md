# SKILL_LOG — AulaClaw × API de estudiante de 4Geeks (actividad 06)

Entorno: OpenClaw 2026.9.7 en el VPS del curso, modelo `litellm/online/openrouter/deepseek/deepseek-v4-flash`. Fecha: 10-nov-2026 (America/Mexico_City). Transcripciones íntegras y redactadas en `docs/evidencias/06-*.md`.

## Token (seguridad)
- El token de estudiante está en el **almacén de secretos de OpenClaw** (`openclaw secrets store set FOURGEEKS_TOKEN --kind secret`; se lista como write-only).
- Cada skill `4geeks-*` declara `metadata.openclaw.primaryEnv: FOURGEEKS_TOKEN`, y en `openclaw.json` (fuera del repo) `skills.entries.<skill>.apiKey = {source: "store", provider: "default", id: "FOURGEEKS_TOKEN"}`. OpenClaw lo inyecta como variable solo durante el turno.
- Ningún SKILL.md contiene el valor: los scripts usan `$FOURGEEKS_TOKEN` / `os.environ`. El escaneo de valores exactos sobre el repo da 0 coincidencias.

## Conversación de descubrimiento
**Prompt:** «Actividad 06: quiero que me ayudes a conectarte a la API de estudiante de 4Geeks (BreatheCode) usando mi token, sin que yo escriba código… ¿Cómo propones hacerlo, qué información necesitas de mí y qué skills crearías?»

**Qué sugirió OpenClaw:** comprobó que la variable no existía en su entorno de ejecución y pidió dónde estaba el token. Propuso una sola skill integrada `4geeks-api` que cubriera los cuatro endpoints.

**Decisión:** se guardó el token en el secret store, enlazado por skill. Se pidieron seis skills atómicas (una responsabilidad cada una), porque la rúbrica prohíbe skills amplias.

## Hallazgos reales de la API (GET autenticados)
- `/v1/admissions/user/me` no trae `profile_academy`; la academia está en `roles[].academy` (id 7, slug `online`).
- `/v1/admissions/academy/cohort/me` sin cabecera devuelve 403 («Missing academy_id … or 'Academy' header»). Con `Academy: 7` solo devuelve 2 cohortes de la academia, sin role ni educational_status.
- `/v1/activity/me` con `Academy: 7` devuelve 403 «You (user: …) don't have this capability: read_activity for academy 7». No está disponible para alumnos.
- Primera ronda de pruebas: varias skills fallaron con 401 porque el agente escribió `Token ***` literal en lugar de la variable. En la siguiente conversación se corrigió y se repitieron las pruebas.

---

## 1. `4geeks-autenticar`
- **Prompt:** «Crea la primera: skills/4geeks-autenticar/SKILL.md. Debe llamar GET /v1/admissions/user/me y responder si la sesión es válida (código HTTP), el nombre de pila, el correo enmascarado y las academias vinculadas…» Después se corrigió por chat para leer las academias de `roles`.
- **Endpoint:** `GET /v1/admissions/user/me`
- **Lógica:** HTTP 200 significa sesión válida; 401 o 403, «token inválido o caducado». Muestra el nombre de pila, el correo enmascarado y `roles[].academy`.
- **Prueba:** `/4geeks-autenticar Ejecuta la skill ahora: ¿mi sesión de 4Geeks está activa?`
- **Resultado:** VÁLIDA (HTTP 200) · correo m***@g***.com · 1 academia: 4Geeks Latam (/online), rol student.
- **Limitaciones:** no comprueba la expiración del token; solo hace la llamada.

## 2. `4geeks-proyectos`
- **Prompt:** «Siguiente skill: skills/4geeks-proyectos/SKILL.md. Debe listar mis proyectos asignados con su estado actual: GET /v1/assignment/user/me/task?task_type=PROJECT&limit=200 … título, task_status y revision_status, y al final el total…»
- **Endpoint:** `GET /v1/assignment/user/me/task?task_type=PROJECT&limit=200` (con paginación)
- **Prueba:** `/4geeks-proyectos ¿qué proyectos tengo asignados y en qué estado están? Si son muchos, muestra los 10 primeros y el total.`
- **Resultado:** total 91 proyectos; 61 PENDING, 30 DONE (19 APPROVED). Coincide con el GET de control de las 20:44 (America/Mexico_City): 91 · DONE 30 · PENDING 61 · revision APPROVED 19 / PENDING 72.
- **Limitaciones:** el mismo proyecto puede aparecer en varias cohortes (por ejemplo, Postcard en Pre Work y en AI Engineering Intro).

## 3. `4geeks-pendientes`
- **Prompt:** «Siguiente skill: skills/4geeks-pendientes/SKILL.md. Debe decirme qué me falta entregar: GET …task_type=PROJECT&task_status=PENDING&limit=200 … título de cada proyecto pendiente y el total…»
- **Endpoint:** `GET /v1/assignment/user/me/task?task_type=PROJECT&task_status=PENDING&limit=200`
- **Prueba:** `/4geeks-pendientes ¿qué proyectos me faltan por entregar? Muestra el total y los 10 primeros.`
- **Resultado:** 61 pendientes. El GET de control con el mismo filtro da 61.
- **Limitaciones:** «pendiente» significa task_status=PENDING (no entregado); no incluye los entregados que esperan revisión.

## 4. `4geeks-progreso`
- **Prompt:** «Siguiente skill: skills/4geeks-progreso/SKILL.md … agregar conteos por task_status y por revision_status, más el total y el porcentaje de proyectos entregados y aprobados. Aclara que es un conteo de proyectos asignados, no el porcentaje oficial del programa.»
- **Endpoint:** `GET /v1/assignment/user/me/task?task_type=PROJECT&limit=200` (agregado)
- **Prueba:** `/4geeks-progreso dame el resumen de cuánto he avanzado.`
- **Resultado:** 91 proyectos · DONE 30 (33.0 %) · PENDING 61 (67.0 %) · APPROVED 19 (20.9 %) · REJECTED 0 · con la nota «conteo de proyectos asignados, no el porcentaje oficial del programa».
- **Limitaciones:** no usa el syllabus; mide sobre proyectos asignados.

## 5. `4geeks-cohortes` (ampliada; elegida por el alumno)
- **Por qué:** saber en qué cohortes estoy inscrito y en qué estado.
- **Prompt inicial:** «…skills/4geeks-cohortes/SKILL.md. Debe llamar GET /v1/admissions/academy/cohort/me…» Tras el hallazgo del 403 o de los datos incompletos: «Reescribe 4geeks-cohortes con una sola responsabilidad, "mis inscripciones a cohortes": usa el campo cohorts de /v1/admissions/user/me…»
- **Endpoint:** `GET /v1/admissions/user/me` → campo `cohorts`. Se documentó por qué no se usa `academy/cohort/me`.
- **Prueba:** `/4geeks-cohortes ¿en qué cohortes estoy inscrito y con qué estado?`
- **Resultado:** 34 inscripciones · ACTIVE 26 · GRADUATED 6 · POSTPONED 2, incluida `latam-aie-pt-6` (ACTIVE). Coincide con el GET de control.
- **Limitaciones:** en un resumen el modelo listó una cohorte graduada entre las «destacadas» activas; la salida del script es la fuente fiable.

## 6. `4geeks-eventos` (ampliada; alternativa justificada a `4geeks-actividad`)
- **Por qué:** se intentó primero `4geeks-actividad` (`GET /v1/activity/me`). La API responde 403 *read_activity capability* para alumnos, así que es inviable. La alternativa útil y documentada en la referencia es conocer los próximos eventos para planear la semana.
- **Prompt:** «Ejecuta tú mismo GET /v1/activity/me… Si es 403 por la capacidad read_activity, crea skills/4geeks-eventos/SKILL.md: GET /v1/events/all?upcoming=true&limit=20 … total, título, starting_at en America/Mexico_City y event_type.name. Borra la carpeta skills/4geeks-actividad.»
- **Endpoint:** `GET /v1/events/all?upcoming=true&limit=20`
- **Prueba:** ejecución del script de la skill en el mismo turno de creación, más la verificación literal posterior.
- **Resultado:** 4 eventos próximos (17, 18, 19 y 29-nov-2026), todos de tipo «Coding with AI».
- **Limitaciones:** la lista es de la academia, no inscripciones personales.

---

## Verificación independiente de los scripts
Cada bloque `## Implementación` se ejecutó literalmente fuera del agente (`docs/evidencias/06-verificacion-scripts.md`).

| Skill | Script literal (02:54 UTC = 20:54 America/Mexico_City) | GET de control (02:55 UTC) | ¿Coincide? |
|---|---|---|---|
| autenticar | HTTP 200, 1 academia (online, student) | user/me 200; roles academia 7 `online` | Sí |
| proyectos | 91 proyectos | 91 | Sí |
| pendientes | 60 | PENDING = 60 | Sí |
| progreso | PENDING 60 · DONE 31 · APPROVED 19 (34.1 % / 20.9 %) | DONE 31 · PENDING 60 · APPROVED 19 | Sí |
| cohortes | 34 · ACTIVE 26 · GRADUATED 6 · POSTPONED 2 | 34 inscripciones (mismo desglose) | Sí |
| eventos | 4 próximos | events/all?upcoming=true → 4 | Sí |

Nota: los conteos de tareas cambiaron durante la sesión (DONE 27 → 30 → 31) porque se entregaron tareas en el LMS en paralelo. Las pruebas por chat de las 20:40 (America/Mexico_City) mostraron 61/30, que coincidían con el GET de control de ese momento.

**Correcciones del operador, mínimas y transparentes:** la interfaz de OpenClaw enmascara cadenas tipo `Token $VAR` cuando el agente lee y escribe archivos. En `4geeks-cohortes` quedó escrito `TOKEN="***"` y `Token ***}`. El operador lo restituyó por `${FOURGEEKS_TOKEN}`/`${TOKEN}` con `sed`, y corrigió la errata `len(cohortes)` → `len(cohorts)` que el propio agente señaló. Todo lo demás lo escribió el agente por conversación.
