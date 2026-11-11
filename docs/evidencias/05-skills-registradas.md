# 05 — skills registradas en OpenClaw

```text
$ openclaw skills list (filtrado a skills del workspace)
Skills (22/57 ready)
│ ✓ ready       │ add-model-provider       │ Add and live-prove a model provider with non-        │ openclaw-custodian │
│ ✓ ready       │ bloque-de-ejecucion      │ Programa un bloque académico de 4Geeks en Google     │ openclaw-workspace │
│ ✓ ready       │ brief-de-trabajo         │ Convierte notas académicas de 4Geeks en un brief y   │ openclaw-workspace │
│ ✓ ready       │ browser-automation       │ Use when controlling web pages with the OpenClaw     │ openclaw-extra     │
│ ✓ ready       │ 🖼️ canvas                │ Present hosted widget documents on a connected       │ openclaw-extra     │
│ ✓ ready       │ clawhub                  │ Search ClawHub for skills when a requested           │ openclaw-bundled   │
│               │                          │ capability is not already available; install,        │                    │
│               │                          │ verify, update, uninstall, publish, or sync skills.  │                    │
│ ✓ ready       │ cloud-image-bake         │ Bake, select, prove, and safely retire a Cloud       │ openclaw-custodian │
│ ✓ ready       │ configure-channel        │ Configure and prove a chat channel with non-         │ openclaw-custodian │
│ ✓ ready       │ control-ui               │ Operate and troubleshoot the OpenClaw Control UI:    │ openclaw-bundled   │
│ ✓ ready       │ diagnose-gateway         │ Diagnose Gateway, config, secrets, channels, and     │ openclaw-custodian │
│ ✓ ready       │ 🧭 diagram-maker         │ Create SVG/HTML or Excalidraw diagrams for           │ openclaw-bundled   │
│               │                          │ skills, hooks, MCP, or Gemma routing.                │                    │
│ △ needs setup │ 🎮 gog                   │ Google Workspace CLI for Gmail, Calendar, Drive,     │ openclaw-bundled   │
│ ✓ ready       │ healthcheck              │ Audit/harden OpenClaw hosts: SSH, firewall,          │ openclaw-bundled   │
│ ✓ ready       │ 🖼️ meme-maker            │ Search meme templates, suggest formats, and          │ openclaw-bundled   │
│ ✓ ready       │ node-connect             │ Diagnose OpenClaw Control UI browser and native      │ openclaw-bundled   │
│ ✓ ready       │ 🪲 node-inspect-debugger │ Debug Node.js with node inspect, --inspect,          │ openclaw-bundled   │

$ openclaw skills info brief-de-trabajo
brief-de-trabajo ✓ Ready

Convierte notas académicas de 4Geeks en un brief y crea un Google Doc de prueba solo cuando el usuario lo solicita y Zapier MCP está conectado.

Details:
  Source: openclaw-workspace
  Path: ~/.openclaw/workspace/skills/brief-de-trabajo/SKILL.md
  Visible to model: yes
  Available as command: yes

Tip: use `openclaw skills search`, `openclaw skills install`, and `openclaw skills update` for ClawHub-backed skills.

$ openclaw skills info bloque-de-ejecucion
bloque-de-ejecucion ✓ Ready

Programa un bloque académico de 4Geeks en Google Calendar de pruebas usando Zapier MCP; pregunta por fecha u hora faltantes y comprueba el evento creado.

Details:
  Source: openclaw-workspace
  Path: ~/.openclaw/workspace/skills/bloque-de-ejecucion/SKILL.md
  Visible to model: yes
  Available as command: yes

Tip: use `openclaw skills search`, `openclaw skills install`, and `openclaw skills update` for ClawHub-backed skills.
```
