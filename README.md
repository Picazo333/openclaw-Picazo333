# AulaClaw — OpenClaw | 4Geeks AI Engineering

Repositorio académico de Miguel (Picazo333). El workspace real de OpenClaw (`~/.openclaw/workspace`) del VPS del curso se publica en `.openclaw/workspace/`. Todos los push se hacen desde la terminal del VPS con una deploy key de este repo.

| Actividad | Dónde está la evidencia |
|---|---|
| 03 — Setup (999134) | `.openclaw/workspace/IDENTITY.md`, `docs/evidencias/03-servidor.md`, `docs/evidencias/03-personalizacion-chat.md` |
| 04 — Connection (999485) | `openclaw-connection/` (capturas saneadas, transcripciones y `notes.md`) |
| 05 — Skills (1001007) | Los cinco archivos de `.openclaw/workspace/`, `SKILLS_DESIGN.md` (commit f879486, anterior a las skills 8998694), `.openclaw/workspace/skills/brief-de-trabajo` y `bloque-de-ejecucion`, `docs/evidencias/05-*` |
| 06 — 4Geeks API (1001011) | `SKILL_LOG.md`, `.openclaw/workspace/skills/4geeks-*`, `docs/evidencias/06-*` |

Runtime: OpenClaw 2026.9.7 en Ubuntu 22.04, modelo `litellm/online/openrouter/deepseek/deepseek-v4-flash` vía LiteLLM de 4Geeks, canal Telegram `@aulaclaw_picazo_bot` y Zapier MCP (Google Docs y Calendar de pruebas).

Seguridad: sin `.env`, `openclaw.json`, sesiones ni tokens. El token de 4Geeks vive en el secret store de OpenClaw. Antes de cada commit se ejecuta un escaneo de valores exactos.

Nota de versión: en OpenClaw 2026.9.7, `TOOLS.md` ya no se carga en el arranque (`openclaw doctor` propone fusionarlo en `AGENTS.md`). Su contenido se copió por conversación a la sección `## Tools` de `AGENTS.md`, y `TOOLS.md` se conserva como referencia.
