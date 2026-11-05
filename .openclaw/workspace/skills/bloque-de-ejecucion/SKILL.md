---
name: bloque-de-ejecucion
description: Programa un bloque académico de 4Geeks en Google Calendar de pruebas usando Zapier MCP; pregunta por fecha u hora faltantes y comprueba el evento creado.
user-invocable: true
---

# Bloque de ejecución — 4Geeks

## Uso
Cuando el estudiante pida reservar tiempo para completar o revisar una actividad de 4Geeks.

## Entradas
Actividad, fecha, hora, zona horaria y duración. Preguntar si falta un dato imprescindible; nunca asumir una fecha relativa si no está disponible la fecha actual verificable. Confirmar `America/Mexico_City` antes de crear.

## Proceso
1. Respetar `IDENTITY.md`, `SOUL.md`, `AGENTS.md`, `USER.md` y `TOOLS.md`.
2. Proponer título `[4Geeks] <actividad>`, descripción con objetivo y criterio de terminado. Sin invitados por defecto.
3. Confirmar que la fecha y hora son futuras, zona horaria, duración, calendario de pruebas y petición de creación.
4. Descubrir la herramienta **real** de Google Calendar `Create Event` que expone Zapier MCP e inspeccionar su esquema. No inventar nombres, parámetros, IDs ni URL.
5. Crear evento solo si el usuario lo solicitó y la integración funciona. Verificar ID/link de respuesta y, cuando se pueda, consultar Calendar para confirmar.
6. Si no está conectado, devolver propuesta y `BLOCKED`, sin simular evento.
7. Confirmar por Telegram si ese fue el canal de solicitud. No enviar invitaciones ni mensajes a terceros.

## Respuesta
**Bloque:** [título]
**Cuándo:** [fecha, hora, zona y duración]
**Estado:** [CREADO / PROPUESTA / BLOCKED]
**Evento:** [URL/ID real / No creado]

## Prueba
Primero pedir «Agenda un bloque para revisar OpenClaw» y comprobar que pregunta cuándo. Después indicar «mañana a las 18:00 durante 30 minutos, zona America/Mexico_City, en mi calendario de pruebas» y verificar evento real en Google Calendar.
