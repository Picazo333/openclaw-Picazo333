---
name: 4geeks-proyectos
description: Lista proyectos asignados en 4Geeks con título, task_status y revision_status (GET /v1/assignment/user/me/task?task_type=PROJECT).
metadata:
  openclaw:
    primaryEnv: FOURGEEKS_TOKEN
    requires:
      env: ["FOURGEEKS_TOKEN"]
      bins: ["curl", "python3"]
---

# 4geeks-proyectos

Lista proyectos asignados con su estado actual desde la API de BreatheCode, con paginación.

## Endpoint

`GET https://breathecode.herokuapp.com/v1/assignment/user/me/task?task_type=PROJECT&limit=200`

## Cabecera

```
Authorization: Token $FOURGEEKS_TOKEN
```

## Comportamiento

- La respuesta puede ser:
  - **Lista plana:** array directo de objetos `task`.
  - **Objeto paginado:** con clave `results` (array) y `next` (string o null).
- Maneja ambos formatos automáticamente.
- Si `next` no es `null`, continúa solicitando la siguiente página hasta agotar la paginación.
- Por cada proyecto imprime: `título`, `task_status`, `revision_status`.
- Al final muestra el total de proyectos listados.
- Si HTTP 401 o 403: respuesta única → `token inválido o caducado`
- Otro código: responder con el código HTTP y el cuerpo reducido (primeros 200 caracteres)

## Implementación

```bash
#!/bin/sh
# 4geeks-proyectos - Lista proyectos asignados

python3 - <<'PY'
import json
import os
import urllib.error
import urllib.request

token = os.environ.get("FOURGEEKS_TOKEN")
if not token:
    print("ERROR: FOURGEEKS_TOKEN no está definido")
    raise SystemExit(1)

BASE = "https://breathecode.herokuapp.com"
next_url = BASE + "/v1/assignment/user/me/task?task_type=PROJECT&limit=200"
tasks = []

while next_url:
    req = urllib.request.Request(next_url, headers={"Authorization": "Token " + token})
    try:
        with urllib.request.urlopen(req) as resp:
            data = json.loads(resp.read().decode("utf-8"))
    except urllib.error.HTTPError as e:
        if e.code in (401, 403):
            print("token inválido o caducado")
            raise SystemExit(1)
        print("HTTP " + str(e.code))
        print(e.read().decode("utf-8", errors="replace")[:200])
        raise SystemExit(1)
    except urllib.error.URLError as e:
        print("ERROR: " + str(e))
        raise SystemExit(1)

    if isinstance(data, list):
        results = data
        next_url = None
    elif isinstance(data, dict):
        results = data.get("results", data.get("items", []))
        next_url = data.get("next")
    else:
        results = []
        next_url = None

    tasks.extend(results)

print("Proyectos asignados: " + str(len(tasks)))
print()
for t in tasks:
    title = t.get("title") or t.get("name", "—")
    status = t.get("task_status", "—")
    revision = t.get("revision_status", "—")
    print("  [{}] [{}] {}".format(status, revision, title))
print()
print("Total: {} proyectos".format(len(tasks)))
PY
```
