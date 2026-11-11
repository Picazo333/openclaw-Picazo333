# Notes — Conexión OpenClaw (AulaClaw) · resultados reales del 10-nov-2026 (America/Mexico_City)

1. Telegram: bot `@aulaclaw_picazo_bot` creado con BotFather; canal en modo polling, emparejado por código y con allowlist solo del propietario.
2. Zapier MCP: servidor `zapier` (streamable-http) en `mcp.servers`; `openclaw mcp probe` expone 17 herramientas. El token va en una cabecera fuera del repositorio.
3. Fallo observado: Telegram no veía las herramientas de Zapier porque el gateway arrancó antes de añadir el token y el servicio no heredaba la variable; se resolvió con la cabecera en la configuración y reiniciando el gateway.
4. Google Docs y Calendar se conectaron con la cuenta de pruebas desde el propio chat (`manage_zapier_connections`). El primer intento de crear devolvió «No default connection», y AulaClaw fijó la conexión por defecto.
5. E2E Docs: desde Telegram se pidió «Prueba AulaClaw». Se creó el Doc (ID 16ovG4K3…) con «Conexión OpenClaw + Zapier funcionando».
6. E2E Calendar: a «Agéndame una reunión de repaso», sin fecha, AulaClaw preguntó título, fecha, hora y duración. Con la respuesta creó «Repaso de entregas 4Geeks», jue 12-nov-2026 10:00–10:30 America/Mexico_City (ID 03ou0nse…), y lo confirmó por Telegram.
7. Verificación posterior, solo lectura vía Zapier: el Doc y el evento existen (status confirmed). La búsqueda del evento por texto falló; la consulta por ID lo encontró.
8. Observación: AulaClaw ofreció un valor por defecto si no se contestaba; para cumplir la rúbrica debe esperar la respuesta.
