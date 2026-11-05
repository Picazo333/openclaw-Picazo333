# AulaClaw — OpenClaw | 4Geeks AI Engineering

> Repositorio **académico público**, aislado del asistente personal. Los archivos de diseño están preparados; la ejecución, conexiones y capturas requieren pruebas reales.

## Objetivo

AulaClaw ayuda a completar actividades de 4Geeks mediante dos skills:

- `brief-de-trabajo`: transforma notas académicas en un brief de ejecución y puede crear un Google Doc si está conectada la herramienta correspondiente.
- `bloque-de-ejecucion`: programa un bloque académico en Google Calendar, preguntando por datos faltantes y verificando que se creó el evento.

Canal de conversación previsto: Telegram. Integraciones previstas: Zapier MCP con Google Docs y Google Calendar de pruebas. **No se afirma que ya estén conectadas.**

## Entregas

| Actividad | Trabajo incluido | Evidencia real pendiente |
|---|---|---|
| [03 — Setup](https://learn.4geeks.com/es/main-cohort/latam-aie-pt-6/syllabus/personal-assitant-with-openclaw/project/openclaw-setup?moduleId=1) | Identidad y cinco archivos de perfil | Chat real, personalización por conversación, verificación del servidor y Git |
| [04 — Connection](https://learn.4geeks.com/es/main-cohort/latam-aie-pt-6/syllabus/personal-assitant-with-openclaw/project/openclaw-connection?moduleId=2) | Guía, notas y esquema de capturas | Telegram → Docs y Calendar vía Zapier → confirmación |
| [05 — Skills](https://learn.4geeks.com/es/main-cohort/latam-aie-pt-6/syllabus/advanced-personal-assitant-with-openclaw/project/openclaw-skills?moduleId=1) | Diseño previo y dos SKILL.md | `openclaw doctor`, pruebas de ambas skills y resultado externo real |

## Orden y controles

1. Configurar un **agente/workspace separado** para 4Geeks; no reemplazar el perfil personal ni copiar secretos.
2. Pedirle al agente, **por chat**, establecer Name: AulaClaw, Emoji: 🛠️ y Greeting: «Hola, soy AulaClaw. ¿Qué entrega de 4Geeks cerramos hoy?». Verificar el `IDENTITY.md` real.
3. Conectar Telegram y Zapier MCP con herramientas de prueba para Docs y Calendar. Documentar resultados y capturas sin datos privados.
4. Mantener un commit de `SKILLS_DESIGN.md` **anterior** al commit de `SKILL.md` y probar las dos skills.
5. Verificar que no se publiquen `.env`, `openclaw.json`, tokens, sesiones, URLs privadas de MCP ni claves.

**Limitación académica:** la rúbrica literal de Setup exige VPS, conexión SSH, LiteLLM y push SSH desde VPS. Un runtime local Windows no demuestra esos criterios; su sustitución solo es válida si el instructor la acepta. Este repositorio no contiene evidencia inventada.

## Pruebas mínimas

- Desde Telegram: «Prepara un brief de 4Geeks para revisar el proyecto TypeScript Cinema y créalo en Google Docs». Confirmar documento y URL real.
- Desde Telegram: «Reserva un bloque de revisión del brief»; comprobar que pregunta fecha/hora; concretar 18:00 durante 30 minutos, zona America/Mexico_City, en Calendar de pruebas; confirmar evento y mensaje.

## Documentación

- `docs/CRITERIOS_Y_EVIDENCIAS.md`: requisitos frente a estado real.
- `openclaw-connection/README.md`: lista exacta de capturas.
- `scripts/verify_static.py`: validación determinística solo de archivos.
- [Rúbricas oficiales](https://github.com/4GeeksAcademy/ai-engineering-syllabus/tree/main/content/projects)
