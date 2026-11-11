---
name: 4geeks-eventos
description: Muestra los próximos eventos de 4Geeks con fecha en horario de la Ciudad de México (GET /v1/events/all?upcoming=true&limit=20).
metadata:
  openclaw:
    primaryEnv: FOURGEEKS_TOKEN
    requires:
      env: ["FOURGEEKS_TOKEN"]
      bins: ["curl", "python3"]
---

# 4geeks-eventos

Muestra los próximos eventos disponibles en 4Geeks (BreatheCode).

## Endpoint

`GET https://breathecode.herokuapp.com/v1/events/all?upcoming=true&limit=20`

## Cabecera

```
Authorization: Token $FOURGEEKS_TOKEN
```

## Comportamiento

- Si HTTP 200: extrae el arreglo `results` y muestra:
  - Número total de eventos próximos
  - Por cada evento: `title`, `starting_at` convertido a `America/Mexico_City` y `event_type.name`
- Si HTTP 401 o 403: responder `token inválido o caducado`
- Otro código: responder con el código HTTP y el cuerpo reducido (primeros 200 caracteres)

## Implementación

```sh
#!/bin/sh
# 4geeks-eventos - Próximos eventos de 4Geeks

TOKEN="${FOURGEEKS_TOKEN}"
BASE="https://breathecode.herokuapp.com"

if [ -z "$TOKEN" ]; then
  echo "ERROR: FOURGEEKS_TOKEN no está definido"
  exit 1
fi

RESPONSE=$(curl -s -w "\n%{http_code}" \
  -H "Authorization: Token ${TOKEN}" \
  "$BASE/v1/events/all?upcoming=true&limit=20")

HTTP_CODE=$(echo "$RESPONSE" | tail -1)
BODY=$(echo "$RESPONSE" | sed '$d')

if [ "$HTTP_CODE" = "401" ] || [ "$HTTP_CODE" = "403" ]; then
  echo "token inválido o caducado"
  exit 1
fi

if [ "$HTTP_CODE" != "200" ]; then
  echo "HTTP $HTTP_CODE"
  echo "$BODY" | head -c 200
  exit 1
fi

python3 -c "
import json, sys
from datetime import datetime, timezone, timedelta

data = json.load(sys.stdin)
if isinstance(data, dict):
    results = data.get('results', [])
else:
    results = data

print(f'Total de eventos próximos: {len(results)}')
print()

mexico_tz = timedelta(hours=-6)  # America/Mexico_City sin horario de verano

for ev in results:
    title = ev.get('title', '—')
    raw_start = ev.get('starting_at', '')
    event_type = ev.get('event_type', {}) or {}
    type_name = event_type.get('name', '—')

    if raw_start:
        try:
            dt = datetime.fromisoformat(raw_start.replace('Z', '+00:00'))
            dt_mex = dt.astimezone(timezone.utc) + mexico_tz
            fecha = dt_mex.strftime('%Y-%m-%d %H:%M')
        except:
            fecha = raw_start
    else:
        fecha = '—'

    print(f'  • {title}')
    print(f'    Inicio (CDMX): {fecha}')
    print(f'    Tipo:          {type_name}')
    print()
" <<< "$BODY"
```
