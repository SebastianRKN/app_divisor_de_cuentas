# Evidencias y límites de captura

Las salidas TXT son registros originales de comandos ejecutados durante cada etapa. No son capturas ni se han convertido en imágenes que simulen una terminal.

Se intentó abrir una consola PowerShell y capturar su ventana mediante GetConsoleWindow, GetWindowRect y System.Drawing.CopyFromScreen en la parte 1. El entorno devolvió: `La consola no dispone de una ventana capturable.` No se obtuvo ningún PNG verificable; por tanto, no se fabricaron imágenes para las etapas posteriores.

| PNG requerido (pendiente) | Evidencia textual disponible |
|---|---|
| parte1_verde.png | parte1_verde.txt: dependencias y 16 pruebas correctas en sdd |
| parte2_rojo.png | parte2_rojo.txt: 17 correctas, 1 fallo real; salida 1 |
| parte3_verde.png | parte3_verde.txt: 18 correctas; salida 0 |
| parte4_analyze.png | parte4_analyze.txt: unused_local_variable y avoid_print |
| parte6_refactor.png | parte6_refactor.txt y parte6_refactor.diff |
| parte7_coverage.png | parte7_coverage.txt y cobertura.md |
| parte8_log.png | parte8_log.txt: historial rojo, verde y refactor |

Las siete capturas siguen pendientes si la rúbrica exige PNG. Los registros permiten revisar el trabajo, pero no sustituyen formalmente ese requisito. Para capturar estados antiguos habría que reproducirlos desde sus commits en otro checkout; no se debe presentar una ejecución final como si fuese el rojo original.

## Verificación y trazabilidad

- Base sdd: c61881b. Rojo: 7d4e28b. Verde: 4cbf3c1. Refactor: dca80ab.
- El primer intento de flutter analyze se interrumpió tras una espera prolongada. La repetición con --no-pub y diagnóstico verbose finalizó con salida 0 y No issues found!; se conserva analyze_diagnostico.txt. --no-pub usa las dependencias resueltas en la parte 1.
- parte4_temporal.diff registra las dos líneas introducidas solo para demostrar los avisos; no permanecen en lib/. No correspondía un commit vacío de linter.
- Antes del refactor, lib/ y test/ estaban sin cambios respecto al commit verde; las evidencias estaban guardadas en disco y pendientes del commit documental final.
- verificacion_flujo.dart.txt conserva el código de una comprobación adicional de interfaz, ejecutada desde .dart_tool/verificacion_flujo_test.dart. No altera los archivos de test/ ni la cobertura medida por la suite habitual. Se conserva su salida por separado.
- coverage/lcov.info se mantiene solo localmente y está ignorado por Git. cobertura.md fue calculado contando los registros DA y sus hits; los archivos sin registros no reciben un porcentaje ficticio.
