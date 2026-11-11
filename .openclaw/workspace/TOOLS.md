# TOOLS.md — Servicios disponibles

Catálogo de servicios a los que AulaClaw accede vía Zapier MCP, Telegram y la API de 4Geeks.
Úsalo como referencia rápida para saber qué usar en cada situación.

---

## 1. Telegram (@aulaclaw_picazo_bot)

| Campo | Valor |
|---|---|
| Canal | `@aulaclaw_picazo_bot` |
| Propietario emparejado | Miguel (Picazo333) |
| Uso | Canal principal para recibir tareas y confirmar resultados |
| Regla | Solo responde al propietario emparejado; ignorar mensajes de otros |

**Cuándo usarlo:**
- Como canal de entrada para que Miguel te pida tareas.
- Para enviar confirmaciones, resúmenes o resultados de entregas.

---

## 2. Google Docs vía Zapier (Create Document from Text)

| Campo | Valor por defecto |
|---|---|
| Acción | `Create Document from Text` |
| Título | Prefijo `[4Geeks] ` + descripción del contenido |
| Ubicación | Raíz de *Mi unidad* (cuenta de pruebas de Google) |
| Compartido | No — no compartir automáticamente |
| Contenido | Texto plano o Markdown aportado en la tarea |

**Cuándo usarlo:**
- Briefs de entregas (ver skill *brief-de-trabajo*).
- Notas estructuradas de proyectos.
- Cualquier documento que Miguel pida crear como respaldo.

**Reglas:**
- Usar el prefijo `[4Geeks] ` en el título.
- No compartir el documento; si Miguel quiere compartirlo, lo hará manualmente.

---

## 3. Google Calendar vía Zapier (Create Detailed Event)

| Campo | Valor por defecto |
|---|---|
| Acción | `Create Detailed Event` |
| Calendario | `primary` (cuenta de pruebas de Google) |
| Zona horaria | `America/Mexico_City` |
| Duración | 30 minutos |
| Título | Prefijo `[4Geeks] ` + descripción del evento |
| Invitados | Sin invitados |

**Cuándo usarlo:**
- Bloques de trabajo para proyectos del bootcamp.
- Recordatorios de repaso o estudio.
- Cualquier evento académico que Miguel pida agendar.

**Reglas (importantes):**
1. Antes de crear, confirmar con Miguel:
   - Fecha
   - Hora de inicio
   - Zona horaria (por defecto `America/Mexico_City`, confirmar igual)
   - Duración (por defecto 30 min, confirmar si aplica)
2. Si falta la fecha o la hora, **preguntar y esperar respuesta** — nunca aplicar un valor por defecto en silencio.
3. Tras crear, devolver el ID o enlace real del evento.
4. Si la creación falla, responder **BLOCKED** con la causa del error.

---

## 4. Lectura en Zapier (Find Document / Find Event / Get Event)

| Acción | Uso |
|---|---|
| `Find Document` | Buscar un documento de Google Docs por texto |
| `Find Event` | Buscar un evento de Google Calendar por texto |
| `Get Event` | Obtener un evento específico por su ID |

**Cuándo usarlo:**
- Para verificar que un documento o evento se creó correctamente.
- Estrategia: primero buscar por texto; si la búsqueda falla, consultar directamente por ID.

---

## 5. API de 4Geeks (breathecode.herokuapp.com)

| Campo | Valor |
|---|---|
| URL base | `https://breathecode.herokuapp.com` |
| Token | Variable de entorno `FOURGEEKS_TOKEN` |
| Modo | Solo lectura |
| Token en respuestas | **Nunca imprimirlo ni mostrarlo** |

**Cuándo usarlo:**
- Consultar actividades, entregas o datos del bootcamp.
- Validar entregas existentes.
- Obtener información del perfil de Miguel en 4Geeks.

**Reglas:**
- Solo usar métodos GET (lectura).
- El token vive en `FOURGEEKS_TOKEN` — nunca exponerlo en logs, respuestas ni mensajes.

---

## Resumen rápido

| Servicio | Modo | Acción Zapier | ¿Cuándo? |
|---|---|---|---|
| Telegram | Bidireccional | — | Canal de entrada/salida con Miguel |
| Google Docs | Crear | `Create Document from Text` | Briefs, notas de entregas |
| Google Calendar | Crear | `Create Detailed Event` | Bloques de trabajo, repaso |
| Zapier Docs | Leer | `Find Document` / `Find Event` / `Get Event` | Verificar creaciones |
| API 4Geeks | Solo lectura | — | Consultar actividades y entregas |
