---
name: 4geeks-autenticar
description: Verifica la sesión en la API de 4Geeks BreatheCode (GET /v1/admissions/user/me) y muestra nombre, correo enmascarado y academias vinculadas.
metadata:
  openclaw:
    primaryEnv: FOURGEEKS_TOKEN
    requires:
      env: ["FOURGEEKS_TOKEN"]
      bins: ["curl", "python3"]
---

# 4geeks-autenticar

Verifica credenciales contra la API de estudiante de 4Geeks (BreatheCode).

## Endpoint

`GET https://breathecode.herokuapp.com/v1/admissions/user/me`

## Cabecera

```
Authorization: Token $FOURGEEKS_TOKEN
```

## Comportamiento

- Si HTTP 200: sesión válida → extrae y muestra:
  - Nombre de pila (`first_name`)
  - Correo enmascarado: `m***@g***.com` (primera letra + `***` + `@` + primera letra del dominio + `***` + `.com`)
  - Academias vinculadas: iterar `roles`, mostrar `academy.name`, `academy.slug` y `role` de cada una
- Si HTTP 401 o 403: respuesta única → `token inválido o caducado`
- Otro código: responder con el código HTTP y el cuerpo reducido (primeros 200 caracteres)

## Implementación

```sh
#!/bin/sh
# 4geeks-autenticar - Verifica sesión en BreatheCode API

TOKEN="${FOURGEEKS_TOKEN}"
BASE="https://breathecode.herokuapp.com"

if [ -z "$TOKEN" ]; then
  echo "ERROR: FOURGEEKS_TOKEN no está definido"
  exit 1
fi

RESPONSE=$(curl -s -w "\n%{http_code}" \
  -H "Authorization: Token ${FOURGEEKS_TOKEN}" \
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

data = json.load(sys.stdin)

first_name = data.get('first_name', '—')
email = data.get('email', '')
academies = data.get('profile_academies', [])
roles = data.get('roles', [])

# Enmascarar correo
masked_email = email
if '@' in email:
    local, domain = email.split('@', 1)
    if local:
        masked_local = local[0] + '***'
    else:
        masked_local = ''
    if domain:
        domain_parts = domain.split('.')
        masked_domain = domain_parts[0][0] + '***.' + '.'.join(domain_parts[1:])
    else:
        masked_domain = ''
    masked_email = f'{masked_local}@{masked_domain}'

print(f'Sesión:  VÁLIDA (HTTP 200)')
print(f'Nombre:  {first_name}')
print(f'Correo:  {masked_email}')
print(f'Academias vinculadas: {len(roles)}')
for r in roles:
    academy = r.get('academy', {})
    aname = academy.get('name', '—')
    aslug = academy.get('slug', '—')
    arole = r.get('role', '—')
    print(f'  • {aname} (/{aslug}) — rol: {arole}')
" <<< "$BODY"
```
