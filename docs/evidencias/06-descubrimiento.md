# Evidencia 06-descubrimiento — transcripción real (openclaw agent en el VPS, redactada)

### 2026-11-11T02:24:55+00:00 — sesión `aulaclaw-06`

**Miguel → AulaClaw:**

```text
Actividad 06: quiero que me ayudes a conectarte a la API de estudiante de 4Geeks (BreatheCode) usando mi token, sin que yo escriba código. El token ya está guardado en tu entorno como FOURGEEKS_TOKEN (no lo imprimas nunca). La referencia oficial dice: base https://breathecode.herokuapp.com, cabecera "Authorization: Token <token>", endpoints /v1/admissions/user/me, /v1/assignment/user/me/task (filtros task_status, task_type, limit, offset), /v1/admissions/academy/cohort/me y /v1/activity/me. ¿Cómo propones hacerlo, qué información necesitas de mí y qué skills crearías? Comprueba primero, sin mostrar su valor, si la variable FOURGEEKS_TOKEN existe en tu entorno de ejecución.
```

**AulaClaw (rc=0):**

```text
La variable `FOURGEEKS_TOKEN` **no está definida** en este entorno de ejecución (ni `env` ni `set` la muestran). Es un dato necesario para seguir.

---

## Diagnóstico

| Elemento | Estado |
|---|---|
| `FOURGEEKS_TOKEN` en entorno | ❌ No existe |
| Actividades previas en workspace | Sin verificar |
| Skills existentes para API 4Geeks | Revisando |

---

## Lo que necesito de ti, Miguel

1. **El token de 4Geeks** — ¿dónde está guardado? ¿En algún archivo local, en el VPS, o lo tienes disponible para pasármelo?
   - Si está en un archivo `.env` o similar en el workspace, dime la ruta exacta y lo leo sin exponerlo.
   - Si lo tienes en mente, dímelo aquí y lo asignaré al entorno sin imprimirlo.

2. **¿Qué quieres que haga primero con la API?** Por ejemplo:
   - `/v1/admissions/user/me` → ver tu perfil
   - `/v1/assignment/user/me/task` → listar tareas pendientes
   - `/v1/activity/me` → actividad reciente
   - Combinación: mostrar resumen completo

3. **¿Quieres que cree un skill reusable** (ej. `skills/4geeks-api/SKILL.md`) para que en futuras sesiones pueda consultar la API sin repetir setup?

---

## Propuesta de Skills

Basado en la referencia que diste y los endpoints documentados, propongo crear **un skill integrado**:

### `4geeks-api`
- **Endpoints cubiertos:** `/v1/admissions/user/me`, `/v1/assignment/user/me/task`, `/v1/admissions/academy/cohort/me`, `/v1/activity/me`
- **Funcionalidad:** consultar perfil, listar tareas (con filtros `task_status`, `task_type`, `limit`, `offset`), cohorte activa, actividad reciente
- **Salida limpia:** respuestas formateadas sin exponer el token
- **Validación:** verifica que el token exista antes de cada consulta

¿Te parece bien? Dame el token (o dónde está) y te digo qué prefieres ver primero.
```

