# Matriz mínima de evidencia y estado

| Rúbrica | Archivo/paso | Estado verificado |
|---|---|---|
| Setup: Name, Emoji, Greeting | `.openclaw/workspace/IDENTITY.md` | PREPARADO en GitHub; personalización por chat NO VERIFICADA |
| Setup: chat funcional | Captura y prueba del runtime | NO VERIFICADO |
| Setup: VPS SSH + LiteLLM | Configuración real | NO VERIFICADO; Windows local no satisface literalmente |
| Setup: workspace en GitHub | Este repositorio | VERIFICADO: archivos en GitHub; push SSH desde VPS NO VERIFICADO |
| Connection: Telegram | Captura de conversación | NO VERIFICADO |
| Connection: Zapier MCP | Captura de herramientas | NO VERIFICADO |
| Connection: Docs + Calendar y respuesta Telegram | Capturas, enlaces e IDs | NO VERIFICADO |
| Skills: cinco archivos específicos | `.openclaw/workspace/*.md` | VERIFICADO en repositorio; carga en agente NO VERIFICADA |
| Skills: diseño antes de implementación | [Commit de diseño](https://github.com/Picazo333/openclaw-Picazo333/commit/f87948611503a785d9b717bc947d5e1051fd1f25) | VERIFICADO: anterior a la implementación |
| Skills: dos skills OpenClaw | [Commit de implementación](https://github.com/Picazo333/openclaw-Picazo333/commit/8998694eea1849a37145cbded8d1bb010690e6df) | VERIFICADO: ambos SKILL.md publicados; carga y ejecución NO VERIFICADAS |
| Skills: `openclaw doctor` sin errores | Salida de runtime | NO VERIFICADO |
| Skills: servicio conectado | Doc/Calendar real | NO VERIFICADO |

## Cierre académico

La publicación de archivos no prueba que el agente, Telegram, Zapier MCP, Google Docs o Calendar estén conectados. Para Connection y Skills se requieren pruebas y capturas reales. Setup exige literalmente VPS, SSH y LiteLLM; una instalación local requiere excepción aceptada por el instructor o cubrir esos criterios en ese entorno.

**No declarar READY_TO_SUBMIT mientras falte evidencia de requisitos obligatorios.**
