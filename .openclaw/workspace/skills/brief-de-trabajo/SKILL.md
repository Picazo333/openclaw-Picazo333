---
name: brief-de-trabajo
description: Convierte notas académicas de 4Geeks en un brief y crea un Google Doc de prueba solo cuando el usuario lo solicita y Zapier MCP está conectado.
user-invocable: true
---

# Brief de trabajo — 4Geeks

## Uso
Cuando el estudiante solicite estructurar notas, instrucciones o tareas de 4Geeks y, opcionalmente, documentarlas en Google Docs.

## Entradas
Tema, objetivo, restricciones, entregables, criterios de aceptación y, opcionalmente, fecha. Si falta objetivo, preguntar. Si falta un dato accesorio, poner `NO DEFINIDO` sin inventar hechos. No pedir información personal ni de proyectos externos.

## Proceso
1. Respetar `IDENTITY.md`, `SOUL.md`, `AGENTS.md`, `USER.md` y `TOOLS.md` del workspace académico.
2. Convertir la nota en un brief con las secciones: `Objetivo`, `Alcance`, `Entregables`, `Criterios de aceptación`, `Riesgos/Bloqueantes`, `Siguiente acción`.
3. Comprobar que el contenido no incluye secretos ni datos ajenos al curso.
4. Si el usuario **pidió crear un Doc**, descubrir la herramienta **real** de Google Docs expuesta por Zapier MCP y sus parámetros. No inventar nombres de herramientas. Usar solo la cuenta de pruebas.
5. Si la integración falta, entregar borrador y decir `BLOCKED: Google Docs no conectado`. Si se ejecuta, verificar el resultado, ID o enlace real y, cuando sea posible, comprobar el contenido en Google Docs.
6. Responder por Telegram cuando la solicitud provino de ese canal; dar estado y enlace o causa concreta del bloqueo.

## Respuesta
**Brief:** [título]
**Estado:** [CREADO / PROPUESTA / BLOCKED]
**Doc:** [URL real / No creado]
**Pendiente:** [único paso necesario / Ninguno]

## Prueba
«Con estas notas de TypeScript genera un brief de 4Geeks y créalo en Google Docs de pruebas: revisar Cinema, no modificar archivos fuera del ejercicio, aceptación matriz 8x10 y cuatro escenarios». Comprobar que el documento existe realmente.
