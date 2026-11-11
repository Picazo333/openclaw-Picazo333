# Evidencia 05-skill-brief — transcripción real (openclaw agent en el VPS, redactada)

### 2026-11-11T02:19:52+00:00 — sesión `aulaclaw-05-brief`

**Miguel → AulaClaw:**

```text
/brief-de-trabajo Con estas notas de mi actividad 06 de 4Geeks genera un brief y créalo en Google Docs de pruebas: objetivo, que AulaClaw consulte mi progreso en la API de 4Geeks con seis skills (autenticar, proyectos, pendientes, progreso, cohortes, actividad); restricciones, el token solo en el entorno y nada de escribir en el LMS; entregable, SKILL_LOG.md con prompt, endpoint y prueba de cada skill; aceptación, las seis skills responden con datos reales y sin filtrar el token.
```

**AulaClaw (rc=0):**

```text
Documento creado exitosamente. Aquí tienes el resumen:

**Brief:** Actividad 06 — Skills API de 4Geeks
**Estado:** ✅ CREADO
**Doc:** https://docs.google.com/document/d/1F5sJ4O2…/edit?usp=drivesdk

**Secciones incluidas:**
- **Objetivo:** seis skills (autenticar, proyectos, pendientes, progreso, cohortes, actividad) que AulaClaw consulta contra la API de 4Geeks
- **Alcance:** skills autónomas documentadas en `SKILL_LOG.md` con prompt, endpoint y respuesta real
- **Restricciones:** token solo en entorno, solo GET al LMS, sin exponer datos personales
- **Entregables:** `SKILL_LOG.md` + skills instaladas
- **Aceptación:** seis skills responden con datos reales, sin filtrar el token
- **Riesgos:** token expirado, cambios de API, rate limiting
- **Siguiente acción:** verificar `FOURGEEKS_TOKEN`, probar auth, construir y documentar cada skill

**Pendiente:** ¿Arrancamos con la siguiente acción? Verificar el token y empezar a construir las skills.
```

