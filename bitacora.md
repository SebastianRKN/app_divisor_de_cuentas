# Bitácora — Deber 2
Fecha local: 2026-10-09 (America/Guayaquil). Flutter de origen: sdd, 92fc101.

| Métrica | Flutter (laboratorio) | React (este deber) |
|---|---|---|
| Minutos hasta primera versión que compila | no registrado | no registrado con criterio académico; registro operativo 3.36 min |
| Minutos hasta seis casos aprobados | no registrado | no registrado con criterio académico; confirmación operativa 3.90 min |
| Iteraciones con el agente | no registrado | 1 mensaje posterior: «haz tu todo eso»; no es una corrección técnica |
| Líneas escritas manualmente por estudiante | no registrado | 0 observadas en esta sesión; código generado por agente |
| Enunciados modificados en spec | — | 0 |
| Enunciados modificados en Constitution | — | 6 de 16 reglas inventariadas |
| Enunciados/decisiones modificados en plan | — | 29 de 42; ver comparacion-plan.md |
| Líneas físicas modificadas en plan | — | ver evidencias/plan-lineas.txt; no confundir con enunciados |
| Casos de aceptación que pasan | 6/6 (suite completa 16) | 6/6 (suite completa 25) |

## Alcance y medición
La solicitud inicial agrupa planificación e implementación; no hubo prompt separado del
estudiante para iniciar speckit-plan. El instante exacto de envío inicial no se registró:
por eso los tiempos académicos quedan «no registrado». Se conserva como dato secundario
el marcador al iniciar setup-plan (2026-10-10T00:24:15.836Z), el primer build
(2026-10-10T00:27:37.290Z) y la confirmación con threads (2026-10-10T00:28:09.949Z).
El build no detuvo la medición. La corrida de dominio por forks también terminó aprobada,
pero el marcador final conservado corresponde a la confirmación threads, por lo que no se
presenta como instante exacto del primer verde. No se atribuye tiempo de herramientas a
iteraciones humanas. No se concluye superioridad de React por estos tiempos.

## Incidencias reales
- Artículos del laboratorio están en .specify/, no en specs/<feature>/. Copia intacta a React.
- Flutter sdd: pub get y 16 pruebas aprobadas; no hubo que cambiar su código.
- Fase roja inicial: Vitest no arrancó forks en 60 s; no prueba un fallo de implementación.
- Una corrida posterior forks terminó pasando; se fijó pool threads/maxWorkers 1 para
  una ejecución estable observada. No se cambiaron resultados esperados.
- speckit-converge está instalado. Ver informe del flujo y cobertura en evidencias/converge.md.
- Usuario autorizó al agente escribir casosDePrueba.js. No cumple la autoría manual pedida
  por el profesor; requiere revisión y trabajo personal antes de entregar.
- Spec permanece intacta. sdd-interactivo no se utilizó; su semántica de propina vacía difiere.

