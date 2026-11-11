# Evidencia 06-correccion — transcripción real (openclaw agent en el VPS, redactada)

### 2026-11-11T02:36:01+00:00 — sesión `aulaclaw-06`

**Miguel → AulaClaw:**

```text
Diagnóstico de las pruebas: el token NO está caducado. /4geeks-autenticar devolvió 200 en esta misma ronda, y una llamada directa a la API ahora mismo también devuelve 200. El fallo está en los archivos: en 4geeks-proyectos, 4geeks-progreso, 4geeks-cohortes y 4geeks-actividad escribiste literalmente TOKEN="***" y "Authorization: Token ***" en lugar de usar la variable. Corrígelos para que usen "$FOURGEEKS_TOKEN" igual que 4geeks-autenticar y 4geeks-pendientes (la variable, nunca su valor). Otro hallazgo real: /v1/admissions/user/me no trae profile_academy. Las academias están en el campo roles (roles[].academy con id, name y slug, y roles[].role); ajusta 4geeks-autenticar para mostrarlas desde ahí. Ejecuta /4geeks-autenticar para confirmar que el token funciona y dime qué archivos cambiaste.
```

**AulaClaw (rc=0):**

```text
La prueba se ejecutó correctamente. Aquí el resumen:

---

## Resultado de ejecución `/4geeks-autenticar`

```
Sesión:  VÁLIDA (HTTP 200)
Nombre:  MIGUEL ANGEL
Correo:  m***@g***.com
Academias vinculadas: 1
  • 4Geeks Latam (/online) — rol: student
```

✅ **Token funciona correctamente.** La sesión es válida, nombre visible, correo enmascarado, y las academias se leen desde `roles` (no `profile_academies`).

## Archivos modificados

| Archivo | Cambio |
|---|---|
| `skills/4geeks-autenticar/SKILL.md` | `profile_academies` → `roles[]` con `academy.name`, `academy.slug` y `role` |
| `skills/4geeks-proyectos/SKILL.md` | `"***"` y `"Token ***"` → `${FOURGEEKS_TOKEN}` y `"Token ${FOURGEEKS_TOKEN}"` |
| `skills/4geeks-progreso/SKILL.md` | ídem |
| `skills/4geeks-cohortes/SKILL.md` | ídem |
| `skills/4geeks-actividad/SKILL.md` | ídem + typo `breatchecode` → `breathecode` |

Las 6 skills quedan listas para probar en los próximos turnos cuando OpenClaw inyecte `FOURGEEKS_TOKEN` vía `primaryEnv`.
```

### 2026-11-11T02:38:26+00:00 — sesión `aulaclaw-06`

**Miguel → AulaClaw:**

```text
Hallazgo real sobre cohortes: GET /v1/admissions/academy/cohort/me sin cabecera devuelve 403 («Missing academy_id parameter... or 'Academy' header»). Con la cabecera "Academy: 7" (la academia de roles[0].academy.id) solo devuelve 2 cohortes de la academia, sin role ni educational_status. Mis inscripciones reales, con su educational_status y role, vienen en el campo cohorts de GET /v1/admissions/user/me. Reescribe 4geeks-cohortes con una sola responsabilidad, «mis inscripciones a cohortes»: usa ese campo cohorts y muestra el total, el conteo por educational_status (ACTIVE, GRADUATED, POSTPONED…) y la lista de slugs ACTIVE. En una sección «Notas de API» del SKILL.md explica por qué no usas cohort/me. Luego ejecútala una vez y muéstrame el resultado.
```

**AulaClaw (rc=0):**

```text
Ejecutado correctamente. Aquí el resultado:

```
Inscripciones a cohortes: 34

Por estado educativo:
  ACTIVE: 26
  GRADUATED: 6
  POSTPONED: 2

Cohortes activas (26):
  • Container applications with Docker (/latam-container-applications-with-docker)
  • AI Engineering Introduction (/latam-ai-engineering-introduction)
  • Coding Fundamentals with Python (/latam-coding-fundamentals-with-python)
  • Coding fundamentals with Typescript (/coding-fundamentals-with-typescript)
  • Working with AI coding agents (/working-with-ai-coding-agents)
  • Personal assistants with Openclaw (/personal-assitant-with-openclaw)
  • Advanced personal assitants with Openclaw (/advanced-personal-assitant-with-openclaw)
  • Intro to 4Geeks Method (/latam-intro-to-4geeks-method)
  • latam-aie-pt-6 (/latam-aie-pt-6)
  • … (17 más)
  • Backend development with Coding Agents (/backend-development-with-coding-agents)

Total: 34 inscripción(es)
```

**Archivo modificado:** `skills/4geeks-cohortes/SKILL.md`

Cambios:
- Usa `GET /v1/admissions/user/me` y extrae `cohorts` (no `cohort/me`)
- Muestra total, conteo por `educational_status` y slugs activas
- Incluye sección **Notas de API** explicando por qué `cohort/me` no funciona para este propósito
```

### 2026-11-11T02:39:20+00:00 — sesión `aulaclaw-06`

**Miguel → AulaClaw:**

```text
Ahora 4geeks-actividad: prueba GET /v1/activity/me?limit=50 con la cabecera "Academy: 7" y dime el código y el detalle exacto que devuelve.
Si devuelve 403 «don't have this capability: read_activity», esa API no está disponible para alumnos. En ese caso, reemplaza la skill por una alternativa justificada que sí me sirve: skills/4geeks-eventos/SKILL.md, «próximos eventos de 4Geeks», con GET /v1/events/all?upcoming=true&limit=20, mismas reglas de frontmatter y token. Debe mostrar el total y, por evento, el título, starting_at convertido a America/Mexico_City y event_type.name. Después borra la carpeta skills/4geeks-actividad, ejecuta la nueva skill una vez y muéstrame el resultado.
```

**AulaClaw (rc=0):**

```text
```python
import subprocess, json, sys, os

token = ***'FOURGEEKS_TOKEN')
if not token:
    ***'ERROR: FOURGEEKS_TOKEN no definido')
    sys.exit(1)

BASE = 'https://breathecode.herokuapp.com'
resp = subprocess.run(
    ['curl', '-s', '-w', '\n%{http_code}',
     '-H', f'Authorization: Token ***}',
     '-H', 'Academy: 7',
     f'{BASE}/v1/activity/me?limit=50'],
    capture_output=True, text=True, timeout=15
)

output = resp.stdout
parts = output.rsplit('\n', 1)
http_code = parts[-1].strip()
body = parts[0] if len(parts) > 1 else ''

print(f'HTTP {http_code}')
print(f'Longitud body: {len(body)}')
print()
try:
    data = json.loads(body)
    if isinstance(data, dict):
        print('Es un objeto JSON con claves:')
        for k in list(data.keys())[:10]:
            v = data[k]
            if isinstance(v, str):
                print(f'  {k}: "{v[:100]}"')
            elif isinstance(v, list):
                print(f'  {k}: lista ({len(v)} elementos)')
            elif isinstance(v, dict):
                print(f'  {k}: dict ({len(v)} claves)')
            else:
                print(f'  {k}: {v}')
    elif isinstance(data, list):
        print(f'Es una lista JSON con {len(data)} elementos')
        if data:
            print('Primer elemento:')
            d = data[0]
            for k, v in d.items():
                print(f'  {k}: {str(v)[:80]}')
    else:
        print(f'Tipo: {type(data).__name__}, valor: {str(data)[:200]}')
except json.JSONDecodeError:
    print('No es JSON válido:')
    print(body[:500])
```
```

### 2026-11-11T02:46:12+00:00 — sesión `aulaclaw-06-eventos`

**Miguel → AulaClaw:**

```text
Tu turno anterior sobre 4geeks-actividad terminó mostrando solo código, sin resultado. Hazlo así, en este orden:
1) Ejecuta tú mismo GET https://breathecode.herokuapp.com/v1/activity/me?limit=50 con las cabeceras "Authorization: Token $FOURGEEKS_TOKEN" (la variable, nunca su valor) y "Academy: 7". Dime el código HTTP y el campo detail.
2) Si es 403 por la capacidad read_activity, crea skills/4geeks-eventos/SKILL.md (próximos eventos de 4Geeks): GET /v1/events/all?upcoming=true&limit=20. Usa el mismo frontmatter que 4geeks-autenticar (metadata con primaryEnv FOURGEEKS_TOKEN y requires env y bins) y el token por variable. Debe mostrar el total y, de cada evento, el título, starting_at en America/Mexico_City y event_type.name.
3) Borra la carpeta skills/4geeks-actividad.
4) Ejecuta el script de la nueva skill una vez y muéstrame la salida real.
```

**AulaClaw (rc=0):**

```text
Listo. Aquí el resumen:

**1) GET /v1/activity/me** → HTTP **403**, `detail: "You (user: <user-id>) don't have this capability: read_activity for academy 7"`

**2) Creada** `skills/4geeks-eventos/SKILL.md` — misma estructura de frontmatter que `4geeks-autenticar`, endpoint `GET /v1/events/all?upcoming=true&limit=20`, muestra total + título, `starting_at` en CDMX y `event_type.name`.

**3) Eliminada** `skills/4geeks-actividad/`

**4) Salida real del script:**

```
Total de eventos próximos: 4

  • El Agente Caza-Ofertas: Automatiza tu Black Friday con IA en 3 días (DIA 1)
    Inicio (CDMX): 2026-11-17 12:30
    Tipo:          Coding with AI

  • El Agente Caza-Ofertas: Automatiza tu Black Friday con IA en 3 días (DÍA 2)
    Inicio (CDMX): 2026-11-18 12:30
    Tipo:          Coding with AI

  • El Agente Caza-Ofertas: Automatiza tu Black Friday con IA en 3 días (DÍA 3)
    Inicio (CDMX): 2026-11-19 12:30
    Tipo:          Coding with AI

  • Buscar empleo no es suerte, es método: Crea tu Tracker con IA
    Inicio (CDMX): 2026-11-29 12:00
    Tipo:          Coding with AI
```

Los 4 eventos son del tipo **Coding with AI**, arrancan el 17, 18, 19 y 29 de noviembre.
```

### 2026-11-11T02:52:11+00:00 — sesión `aulaclaw-06-fix4`

**Miguel → AulaClaw:**

```text
Verifiqué los scripts literalmente, tal como están en cada SKILL.md. 4geeks-autenticar, 4geeks-cohortes y 4geeks-eventos funcionan. 4geeks-proyectos, 4geeks-pendientes y 4geeks-progreso fallan con «SyntaxError: leading zeros in decimal integer literals», porque meten el JSON de la respuesta dentro del código Python con json.loads('...') vía interpolación del shell. Reescribe la sección «## Implementación» de esas tres skills como un único bloque ```bash que ejecute python3 - <<'PY' ... PY. Dentro, usa urllib.request con la cabecera Authorization construida desde os.environ["FOURGEEKS_TOKEN"], sigue la paginación (lista u objeto con results/next) y no interpoles el JSON en el código. Conserva la misma salida y la misma responsabilidad de cada skill. No cambies nada más. Al terminar, dime solo qué tres archivos cambiaste.
```

**AulaClaw (rc=0):**

```text
Cambié:
- `skills/4geeks-proyectos/SKILL.md`
- `skills/4geeks-pendientes/SKILL.md`
- `skills/4geeks-progreso/SKILL.md`
```

