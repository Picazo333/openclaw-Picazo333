---
name: 4geeks-progreso
description: Agrega proyectos asignados por task_status y revision_status, con total y porcentaje de entregados y aprobados (DONE/total, APPROVED/total).
metadata:
  openclaw:
    primaryEnv: FOURGEEKS_TOKEN
    requires:
      env: ["FOURGEEKS_TOKEN"]
      bins: ["curl", "python3"]
---

# 4geeks-progreso

Resumen de avance: conteo de proyectos asignados por estado y revisión, con porcentajes indicativos.

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
- Agrega conteos agrupados por:
  - `task_status`: PENDING, DONE, otros (agrupados como OTROS)
  - `revision_status`: PENDING, APPROVED, REJECTED, IGNORED, otros (agrupados como OTROS)
- Calcula:
  - **% entregados** = (DONE / total) × 100
  - **% aprobados** = (APPROVED / total) × 100
- Aclara en la salida: «(conteo de proyectos asignados — no es el porcentaje oficial del programa)»
- Si HTTP 401 o 403: respuesta única → `token inválido o caducado`
- Otro código: responder con el código HTTP y el cuerpo reducido (primeros 200 caracteres)

## Implementación

```bash
#!/bin/sh
# 4geeks-progreso - Resumen de avance de proyectos

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

total = len(tasks)

if total == 0:
    print("No hay proyectos asignados.")
    raise SystemExit(0)

# Conteos por task_status
ts_pending = sum(1 for t in tasks if t.get("task_status") == "PENDING")
ts_done = sum(1 for t in tasks if t.get("task_status") == "DONE")
ts_other = total - ts_pending - ts_done

# Conteos por revision_status
rs_pending = sum(1 for t in tasks if t.get("revision_status") == "PENDING")
rs_approved = sum(1 for t in tasks if t.get("revision_status") == "APPROVED")
rs_rejected = sum(1 for t in tasks if t.get("revision_status") == "REJECTED")
rs_ignored = sum(1 for t in tasks if t.get("revision_status") == "IGNORED")
rs_other = total - rs_pending - rs_approved - rs_rejected - rs_ignored

pct_done = (ts_done / total) * 100
pct_approved = (rs_approved / total) * 100

print("Resumen de avance — 4Geeks")
print("=" * 40)
print("Total proyectos asignados:  " + str(total))
print()
print("Por estado (task_status):")
print("  PENDING    " + str(ts_pending))
print("  DONE       " + str(ts_done))
if ts_other > 0:
    print("  OTROS      " + str(ts_other))
print()
print("Por revisión (revision_status):")
print("  PENDING    " + str(rs_pending))
print("  APPROVED   " + str(rs_approved))
print("  REJECTED   " + str(rs_rejected))
print("  IGNORED    " + str(rs_ignored))
if rs_other > 0:
    print("  OTROS      " + str(rs_other))
print()
print("  % entregados (DONE / total):       {:.1f}%".format(pct_done))
print("  % aprobados (APPROVED / total):    {:.1f}%".format(pct_approved))
print()
print("(conteo de proyectos asignados — no es el porcentaje oficial del programa)")
PY
```
