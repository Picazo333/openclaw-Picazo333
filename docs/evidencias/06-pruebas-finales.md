# Evidencia 06-pruebas-finales — transcripción real (openclaw agent en el VPS, redactada)

### 2026-11-11T02:39:47+00:00 — sesión `aulaclaw-06-pruebas-finales`

**Miguel → AulaClaw:**

```text
/4geeks-autenticar Ejecuta la skill ahora: ¿mi sesión de 4Geeks está activa?
```

**AulaClaw (rc=0):**

```text
Tu sesión de 4Geeks está **activa y válida** ✅

- **Nombre:** MIGUEL ANGEL
- **Correo:** m***@g***.com
- **Academia:** 4Geeks Latam (/online) — rol: **student**

Todo en orden para seguir cerrando entregas.
```

### 2026-11-11T02:40:33+00:00 — sesión `aulaclaw-06-pruebas-finales`

**Miguel → AulaClaw:**

```text
/4geeks-proyectos Ejecuta la skill ahora (no reutilices resultados anteriores): ¿qué proyectos tengo asignados y en qué estado están? Si son muchos, muestra los 10 primeros y el total.
```

**AulaClaw (rc=0):**

```text
Aquí están tus proyectos desde la API de 4Geeks (fresh call):

**Total: 91 proyectos**

**Primeros 10 (ordenados: PENDING primero):**

| # | Estado | Revisión | Cohorte | Proyecto |
|---|--------|----------|---------|----------|
| 1 | PENDING | PENDING | Pre Work | Build a Digital Postcard with HTML/CSS |
| 2 | PENDING | PENDING | Pre Work | Simple Instagram Photo Feed with HTML/CSS |
| 3 | PENDING | PENDING | AI Engineering Intro | Build a Digital Postcard with HTML/CSS |
| 4 | PENDING | PENDING | Pre Work | Code an Excuse Generator in Javascript |
| 5 | PENDING | PENDING | AI Engineering Intro | Code an Excuse Generator in JavaScript |
| 6 | PENDING | PENDING | AI Engineering Intro | Milestone 0 — Choose Your Company |
| 7 | PENDING | PENDING | Advanced OpenClaw | My Agent, My Way |
| 8 | PENDING | PENDING | Advanced OpenClaw | My 4Geeks Assistant |
| 9 | PENDING | PENDING | Data Pipelines | Milestone — Data Pipeline (Part 1) |
| 10 | PENDING | PENDING | Error Handling | Error Handling |

... y 81 más

**Resumen:**
- **61 PENDING** — por entregar
- **30 DONE**
  - **19 APPROVED** — completamente cerrados
  - **11 pendientes de revisión** — entregados, esperando revisión del instructor
```

### 2026-11-11T02:41:51+00:00 — sesión `aulaclaw-06-pruebas-finales`

**Miguel → AulaClaw:**

```text
/4geeks-pendientes Ejecuta la skill ahora: ¿qué proyectos me faltan por entregar? Muestra el total y los 10 primeros.
```

**AulaClaw (rc=0):**

```text
**61 proyectos pendientes** — esto es consistente con lo que vimos en el resumen anterior.

**Primeros 10:**

1. [Pre Work] Build a Digital Postcard with HTML/CSS
2. [Pre Work] Simple Instagram Photo Feed with HTML/CSS
3. [AI Engineering Intro] Build a Digital Postcard with HTML/CSS
4. [Pre Work] Code an Excuse Generator in Javascript
5. [AI Engineering Intro] Code an Excuse Generator in JavaScript with Prompts
6. [AI Engineering Intro] Milestone 0 — Choose Your Company
7. [Advanced OpenClaw] My Agent, My Way
8. [Advanced OpenClaw] My 4Geeks Assistant
9. [Data Pipelines] Milestone — Data Pipeline (Part 1)
10. [Error Handling] Error Handling

... y 51 más

**Total: 61 pendientes**

Nota: varios de estos son duplicados entre cohortes (ej. Postcard aparece en Pre Work y AI Engineering Intro). Si quieres, puedo mostrarlos agrupados por cohorte o filtrar los que realmente requieren acción ahora.
```

### 2026-11-11T02:42:39+00:00 — sesión `aulaclaw-06-pruebas-finales`

**Miguel → AulaClaw:**

```text
/4geeks-progreso Ejecuta la skill ahora: dame el resumen de cuánto he avanzado.
```

**AulaClaw (rc=0):**

```text
**Resumen de avance — 4Geeks** 🛠️

| Métrica | Cantidad | % |
|---------|----------|---|
| **Total proyectos** | 91 | 100% |
| **PENDING** (sin entregar) | 61 | 67.0% |
| **DONE** (entregados) | 30 | 33.0% |
| **APPROVED** (aprobados) | 19 | 20.9% |
| **REJECTED** | 0 | — |

**Entregaste el 33%** de tus proyectos asignados, y **el 20.9% ya está aprobado**. Los restantes 11 DONE están pendientes de revisión del instructor.

*(conteo de proyectos asignados — no es el porcentaje oficial del programa)*
```

### 2026-11-11T02:43:29+00:00 — sesión `aulaclaw-06-pruebas-finales`

**Miguel → AulaClaw:**

```text
/4geeks-cohortes Ejecuta la skill ahora: ¿en qué cohortes estoy inscrito y con qué estado?
```

**AulaClaw (rc=0):**

```text
Aquí tienes tus cohortes en 4Geeks:

**Total: 34 inscripciones**

### Por estado:
- **ACTIVE: 26** — cohortes en curso
- **GRADUATED: 6** — cohortes completadas
- **POSTPONED: 2** — cohortes pospuestas

### Cohortes activas (26) — destacadas:
  - **latam-aie-pt-6** — tu cohorte principal del bootcamp
  - **Ai Engineering Project Delivery** — proyecto final
  - **Advanced personal assistants with Openclaw**
  - **Backend development with Coding Agents**
  - **Frontend development with Coding Agents**
  - **Agentic Engineering**
  - **Models training & RAG**
  - **Real-Time Communication**
  - **Authentication in web applications**
  - ... y 17 más (Docker, Python, TypeScript, FastAPI, etc.)

### Completadas (6):
  - Command line - Git & Github
  - Web UI Fundamentals with Tailwind CSS
  - Frontend development with Coding Agents
  - Working with AI coding agents
  - Automatizaciones No-Code
  - AI Engineering Fundamentals

### Pospuestas (2):
  - latam-pt-70, latam-pt-73

Tienes **26 cohortes activas** simultáneamente — el avance en proyectos (33% entregado) refleja el volumen de trabajo activo.
```

### 2026-11-11T02:44:10+00:00 — sesión `aulaclaw-06-pruebas-finales`

**Miguel → AulaClaw:**

```text
/4geeks-eventos Ejecuta la skill ahora: ¿qué eventos próximos hay en 4Geeks?
```

**AulaClaw (rc=0):**

```text
No encontré una skill llamada `4geeks-eventos` en las skills disponibles. Las skills instaladas con "4geeks" son:

- `4geeks-autenticar`
- `4geeks-cohortes`
- `4geeks-pendientes`
- `4geeks-progreso`
- `4geeks-proyectos`
- `4geeks-actividad`

¿Quieres que revise tu actividad reciente en 4Geeks con la skill `4geeks-actividad`? Esa te muestra las últimas actividades registradas (entregas, revisiones, etc.). O si te refieres a eventos/calendario de 4Geeks, tendría que buscar en otra fuente.
```

### 2026-11-11T02:50:12+00:00 — sesión `aulaclaw-06-pruebas-finales2`

**Miguel → AulaClaw:**

```text
/4geeks-cohortes Ejecuta el script de la skill tal como está en su SKILL.md (no reutilices resultados anteriores) y dime el total y el conteo por educational_status.
```

**AulaClaw (rc=0):**

```text
Resultado (ejecución fresca del script de la skill contra la API, sin reutilizar resultados):

**Inscripciones a cohortes: 34**

**Conteo por educational_status:**
- ACTIVE: 26
- GRADUATED: 6
- POSTPONED: 2

Evidencia: HTTP 200 de `GET /v1/admissions/user/me` con las 34 inscripciones, incluyendo tu cohorte `latam-aie-pt-6` (ACTIVE) y las 25 restantes activas listadas arriba.

Nota: el script de la SKILL.md trae dos erratas de plantilla que impidieron ejecutarlo al pie de la letra — cabecera con `Token ***}` (enmascarado, debía ser `$TOKEN`) y `len(cohortes)` (typo, debía ser `len(cohorts)`). Las corregí mínimo para que corrieran; la lógica y el endpoint son exactamente los de la skill. Si quieres, actualizo el SKILL.md con esas correcciones para que corra directo.
```

