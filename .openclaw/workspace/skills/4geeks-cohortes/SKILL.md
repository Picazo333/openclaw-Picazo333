---
name: 4geeks-cohortes
description: Lista las cohortes activas e inscripciones del estudiante en 4Geeks con nombre, slug, stage, role y educational_status.
metadata:
  openclaw:
    primaryEnv: FOURGEEKS_TOKEN
    requires:
      env: ["FOURGEEKS_TOKEN"]
      bins: ["curl", "python3"]
---

# 4geeks-cohortes

Muestra mis inscripciones a cohortes desde `GET /v1/admissions/user/me`, con total, conteo por `educational_status` y slugs de cohortes activas.

## Endpoint

`GET https://breathecode.herokuapp.com/v1/admissions/user/me`

## Cabecera

```
Authorization: Token $FOURGEEKS_TOKEN
```

## Comportamiento

- Extrae el campo `cohorts` de la respuesta de `/user/me`.
- Cada entrada contiene `cohort.name`, `cohort.slug`, `role`, `educational_status` y opcionalmente `finantial_status`.
- Muestra:
  1. Total de inscripciones.
  2. Conteo por `educational_status` (ACTIVE, GRADUATED, POSTPONED, etc.).
  3. Lista de slugs de cohortes con `educational_status = "ACTIVE"`.
- Si no hay inscripciones, lo dice claramente.
- Si HTTP 401 o 403: respuesta única → `token inválido o caducado`
- Otro código: responder con el código HTTP y el cuerpo reducido (primeros 200 caracteres)

## Notas de API

`GET /v1/admissions/academy/cohort/me` **no se usa** porque:

- Sin cabecera `Academy` devuelve `403 Missing academy_id`.
- Con `Academy: <id>` solo devuelve cohortes de una academia (2 registros), sin `role` ni `educational_status` por inscripción (es el detalle de la cohorte, no del usuario).
- En cambio, `/v1/admissions/user/me` trae todas las inscripciones del usuario en su campo `cohorts`, con `educational_status`, `role`, `cohort.slug` y `cohort.name` completos.

## Implementación

```sh
#!/bin/sh
# 4geeks-cohortes - Muestra mis inscripciones a cohortes

TOKEN="${FOURGEEKS_TOKEN}"
BASE="https://breathecode.herokuapp.com"

if [ -z "$TOKEN" ]; then
  echo "ERROR: FOURGEEKS_TOKEN no está definido"
  exit 1
fi

RESPONSE=$(curl -s -w "\n%{http_code}" \
  -H "Authorization: Token ${TOKEN}" \
  "$BASE/v1/admissions/user/me")

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
from collections import Counter

data = json.load(sys.stdin)
cohorts = data.get('cohorts', [])

if not cohorts:
    print('No hay inscripciones a cohortes.')
    exit(0)

print(f'Inscripciones a cohortes: {len(cohorts)}')
print()

# Conteo por educational_status
status_counts = Counter()
for c in cohorts:
    status_counts[c.get('educational_status', '—')] += 1

print('Por estado educativo:')
for status, count in sorted(status_counts.items(), key=lambda x: -x[1]):
    print(f'  {status}: {count}')
print()

# Slugs activas
activas = [c for c in cohorts if c.get('educational_status') == 'ACTIVE']
if activas:
    print(f'Cohortes activas ({len(activas)}):')
    for c in activas:
        cohort = c.get('cohort', {})
        slug = cohort.get('slug', '—')
        name = cohort.get('name', '—')
        print(f'  • {name} (/{slug})')

print()
print(f'Total: {len(cohorts)} inscripción(es)')
" <<< "$BODY"
```