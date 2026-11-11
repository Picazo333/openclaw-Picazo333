# USER.md - User Model

Store stable user preferences and profile facts as directives that can guide future sessions.

Use one directive per entry:

```md
<!-- observed: YYYY-MM-DD | status: active -->

- Begin each directive with an imperative such as `Always`, `Never`, or `Prefer`.
```

- Begin each directive with an imperative such as `Always`, `Never`, or `Prefer`.
- Record the observation date and either `active` or `superseded` on the metadata line.
- When a preference changes, mark the old entry `superseded` and rewrite the active directive in place. Never append a contradictory active directive.
- Keep stable communication style, relationships, and active-project context here. Put durable non-profile facts and decisions in `MEMORY.md`.
- Save this file at the workspace root as `USER.md`. It loads every session with a separate 4,000-character budget.

## Directives

<!-- observed: 2026-11-10 | status: active -->

- Always reply in Spanish: Miguel es hablante nativo de español.

<!-- observed: 2026-11-10 | status: active -->

- Know the user profile: Miguel, GitHub Picazo333, estudiante de 4Geeks AI Engineering (cohorte latam-aie-pt-6), zona horaria America/Mexico_City.

<!-- observed: 2026-11-10 | status: active -->

- Keep replies breves y accionables: resultado, evidencia, pendiente.

<!-- observed: 2026-11-10 | status: active -->

- Provide pasos guiados (step-by-step) cuando Miguel deba ejecutar algo él mismo (setup, conexiones, despliegues).

<!-- observed: 2026-11-10 | status: active -->

- Never expose tokens, API keys ni datos personales en respuestas ni mensajes compartidos.

<!-- observed: 2026-11-10 | status: active -->

- Always cerrar entregas con evidencia real y verificable (logs, capturas, URLs, commits); omitir pasos opcionales salvo que se pidan.

<!-- observed: 2026-11-10 | status: active -->

- Track proyectos activos: actividades OpenClaw 03–06 (setup, connection, skills, integración con API de 4Geeks) y proyectos full-stack del bootcamp (TypeScript, Flask, React).

<!-- observed: 2026-11-10 | status: active -->

- Use el stack disponible: VS Code, GitHub, VPS con OpenClaw, Telegram, Google Docs y Calendar de pruebas vía Zapier.

## Related

- [Agent workspace](/concepts/agent-workspace)