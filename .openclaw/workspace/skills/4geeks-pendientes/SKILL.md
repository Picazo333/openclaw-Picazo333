---
name: 4geeks-pendientes
description: Muestra los proyectos PENDING del estudiante en 4Geeks con título y total; dice claramente si no hay pendientes.
metadata:
  openclaw:
    primaryEnv: FOURGEEKS_TOKEN
    requires:
      env: ["FOURGEEKS_TOKEN"]
      bins: ["curl", "python3"]
---

# 4geeks-pendientes

Lista solo los proyectos con estado `PENDING` de la API de BreatheCode, con paginación.

## Endpoint

`GET https://breathecode.herokuapp.com/v1/assignment/user/me/task?task_type=PROJECT&task_status=PENDING&limit=200`

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
- Por cada proyecto pendiente imprime su `title`.
- Si no hay proyectos pendientes muestra: «No tienes proyectos pendientes.»
- Al final muestra el total de pendientes.
- **No mezcla otros estados** — solo filtra `PENDING`.
- Si HTTP 401 o 403: respuesta única → `token inválido o caducado`
- Otro código: responder con el código HTTP y el cuerpo reducido (primeros 200 caracteres)

## Implementación

```bash
#!/bin/sh
# 4geeks-pendientes - Lista proyectos pendientes

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
next_url = BASE + "/v1/assignment/user/me/task?task_type=PROJECT&task_status=PENDING&limit=200"
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

if not tasks:
    print("No tienes proyectos pendientes.")
    raise SystemExit(0)

print("Proyectos pendientes: " + str(len(tasks)))
print()
for t in tasks:
    title = t.get("title") or t.get("name", "—")
    print("  • " + str(title))
print()
print("Total: {} pendientes".format(len(tasks)))
PY
```
