# 06 — Token en el secret store de OpenClaw

```text
$ openclaw secrets store list
FOURGEEKS_TOKEN [secret] (write-only); allowed hosts: none
OPENCLAW_GATEWAY_TOKEN [secret] (write-only); allowed hosts: none
$ openclaw skills list | grep 4geeks
│ ✓ ready       │ 4geeks-autenticar        │ Verifica la sesión en la API de 4Geeks BreatheCode   │ openclaw-workspace │
│ ✓ ready       │ 4geeks-breathecode-api   │ Patrón y rubric para crear o auditar skills 4geeks-  │ openclaw-workshop  │
│ ✓ ready       │ 4geeks-cohortes          │ Lista las cohortes activas e inscripciones del       │ openclaw-workspace │
│ ✓ ready       │ 4geeks-eventos           │ Muestra los próximos eventos de 4Geeks con fecha en  │ openclaw-workspace │
│ ✓ ready       │ 4geeks-pendientes        │ Muestra los proyectos PENDING del estudiante en      │ openclaw-workspace │
│ ✓ ready       │ 4geeks-progreso          │ Agrega proyectos asignados por task_status y         │ openclaw-workspace │
│ ✓ ready       │ 4geeks-proyectos         │ Lista proyectos asignados en 4Geeks con título,      │ openclaw-workspace │
```
