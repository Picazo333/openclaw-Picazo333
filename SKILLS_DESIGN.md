# SKILLS_DESIGN — 4Geeks OpenClaw

> Diseño previo a la implementación. El commit de este archivo debe ser cronológicamente **anterior** al que incorpora `skills/*/SKILL.md`.

## 1. `brief-de-trabajo`

**¿Por qué esta tarea?** Las actividades académicas llegan como instrucciones extensas o notas dictadas. Convertirlas en un brief verificable reduce ambigüedad, trabajo duplicado y entregas incompletas.

**¿Qué input acepta?** Tema, objetivo, restricciones, entregable y criterios de terminado en lenguaje natural. Si falta algo no esencial, escribir `NO DEFINIDO`; si falta el objetivo, preguntar.

**¿Qué output produce?** Un brief con título, objetivo, alcance, entregables, criterios de aceptación, riesgos/bloqueantes y siguiente acción. Si el estudiante solicita explícitamente crearlo en Google Docs y Zapier MCP está conectado, crear un documento en la cuenta de pruebas y devolver el enlace real. Si no está conectado, proporcionar texto en chat y estado BLOCKED; jamás afirmar que se creó.

**Prueba de aceptación:** solicitar brief a partir de notas de TypeScript con dos restricciones y pedir Doc; comprobar título, contenido, enlace en Google Docs y confirmación Telegram.

## 2. `bloque-de-ejecucion`

**¿Por qué esta tarea?** El alumno requiere reservar un tiempo concreto para cerrar actividades sin construir un sistema adicional de productividad.

**¿Qué input acepta?** Actividad, fecha, hora local, duración, zona horaria y objetivo opcional. Si fecha/hora es ambigua, preguntar. `America/Mexico_City` sólo cuando se confirme.

**¿Qué output produce?** Resumen del evento `[4Geeks] ...`, fecha, hora, duración y estado. Con petición explícita y Google Calendar de pruebas disponible mediante Zapier MCP: evento real con ID/link verificado y confirmación por Telegram.

**Prueba de aceptación:** pedir «Agenda revisar OpenClaw» sin hora; verificar pregunta; completar con «mañana a las 18:00 durante 30 minutos, hora de Ciudad de México», comprobar Calendar y respuesta Telegram.

## Contrato de arquitectura

Dos skills Markdown con frontmatter OpenClaw válido, en el workspace de un agente académico aislado. No requieren scripts, servicios o APIs nuevos. Solo usan las integraciones existentes de Connection. No editan proyectos ajenos, envían correo ni guardan secretos. El agente debe reflejar `IDENTITY.md`, `SOUL.md`, `AGENTS.md`, `USER.md` y `TOOLS.md`.
