# Evidencias y procedencia de las capturas

Las siete imágenes PNG son capturas auténticas de la ventana de Bloc de notas en Windows, obtenidas con Windows.Graphics.Capture mediante computer-use después de la ejecución original. Se muestran los registros originales guardados durante cada etapa. No son capturas de la terminal en el instante de ejecución ni nuevas ejecuciones de esos estados. No se alteraron resultados, se dibujó una terminal ni se generaron imágenes artificiales.

El primer intento de captura directa de consola no encontró una ventana capturable. En la revisión de la rúbrica se resolvió la generación de imágenes capturando un visor real. Se conservó el registro del intento inicial como evidencia histórica; ya no significa que falten PNG.

Las capturas se guardaron en formato PNG mediante conversión de formato de la imagen proporcionada por la herramienta, sin recortar, retocar o modificar su contenido visual.

| Captura disponible | Fuente visible |
|---|---|
| parte1_verde.png | parte1_verde.txt: rama sdd, dependencias y 16 pruebas correctas |
| parte2_rojo.png | parte2_rojo.txt: error Expected/Actual, 17 correctas y 1 fallo real |
| parte3_verde.png | parte3_verde.txt: 18 correctas; salida 0 |
| parte4_analyze.png | parte4_analyze.txt: unused_local_variable y avoid_print |
| parte6_refactor.png | parte6_revision.txt: concatenación identificada del diff y la salida originales, sin cambiar su contenido |
| parte7_coverage.png | cobertura.md: tabla calculada desde LCOV |
| parte8_log.png | parte8_log.txt: historial original con rojo, verde y refactor |

Todas las fuentes de las imágenes están incluidas. La captura de cobertura muestra la tabla; la ejecución de flutter test --coverage está en parte7_coverage.txt. La salida limpia final del linter está en verificacion_final_analyze.txt y se repitió en auditoria_rubrica_analyze.txt.

**Límite académico:** si el docente exige capturas tomadas durante la ejecución original en terminal, estas capturas posteriores del visor no cumplen ese requisito temporal. No se garantiza una calificación ni se oculta esta diferencia.

## Verificación y trazabilidad

- Base sdd: c61881b. Rojo: 7d4e28b. Verde: 4cbf3c1. Refactor: dca80ab.
- El primer intento de flutter analyze se interrumpió tras una espera prolongada. La repetición con --no-pub y diagnóstico verbose finalizó con salida 0 y No issues found!; se conserva analyze_diagnostico.txt. --no-pub usa las dependencias resueltas en la parte 1.
- parte4_temporal.diff registra las dos líneas introducidas solo para demostrar los avisos; no permanecen en lib/. No correspondía un commit vacío de linter.
- Antes del refactor, lib/ y test/ estaban sin cambios respecto al commit verde; las evidencias estaban guardadas en disco y pendientes del commit documental final.
- verificacion_flujo.dart.txt conserva el código de una comprobación adicional de interfaz, ejecutada desde .dart_tool/verificacion_flujo_test.dart. No altera los archivos de test/ ni la cobertura medida por la suite habitual. Se conserva su salida por separado.
- coverage/lcov.info se mantiene solo localmente y está ignorado por Git. cobertura.md fue calculado contando los registros DA y sus hits; los archivos sin registros no reciben un porcentaje ficticio.
