# Revisión del Deber 3 contra la rúbrica

## 1. Ciclo TDD rojo → verde (2.5 puntos)

- La base sdd, c61881b, tenía 16 pruebas correctas (parte1_verde.txt y PNG).
- 7d4e28b agrega exactamente dos pruebas en test/division_test.dart y no cambia lib/.
- Con 150% se obtuvo Expected: 'La propina no puede superar el 100%' y Actual: <null>. El rojo terminó con 17 pruebas correctas y una fallida; está visible en parte2_rojo.png.
- La prueba del 100% pasa desde el principio, como exige el límite permitido. No se forzó su fallo: el nuevo requisito solo cambia propinas mayores al 100%.
- 4cbf3c1 añade únicamente tres líneas de validación en lib/domain/validar_entrada.dart. Las 18 pruebas pasan; test/ permanece idéntico al commit rojo.
- Orden histórico: rojo, verde, refactor y documentación. Sin reescritura del historial.

**Resultado:** cumplimiento técnico comprobado. Salvedad documental: PNG posterior del registro, no terminal capturada durante el rojo original.

## 2. Linter y code smells (2.5 puntos)

- flutter analyze finaliza con No issues found!.
- parte4_analyze.png muestra los avisos reales unused_local_variable y avoid_print. Se introdujeron temporalmente porque el análisis inicial estaba limpio; luego se retiraron.
- parte5_code_smells.md identifica archivo, línea anterior al refactor y explicación: el 100 repetido de lib/data/redondeo_exacto.dart:7 representa centavos por unidad sin un nombre que exprese su significado.
- respuestas.md explica por qué las reglas configuradas del linter no identificaron ese problema de legibilidad.

**Resultado:** criterios técnicos y explicación presentes; misma salvedad sobre la captura posterior.

## 3. Refactorización segura (2.5 puntos)

- Se refactorizó únicamente el número mágico de centavos.
- La constante privada _centavosPorUnidad sustituye dos literales de 100, sin cambiar el orden de operaciones ni el resultado.
- dca80ab es el commit propio: un archivo de lib/, cuatro líneas añadidas y una retirada.
- Las mismas 18 pruebas pasan antes y después. No cambió test/.
- parte6_refactor.png permite leer juntos el diff original y la salida original de las pruebas.

**Resultado:** cumplimiento comprobado; cambio pequeño, acotado y con commit propio.

## 4. Evidencias y respuestas (2.5 puntos)

- Están los siete PNG con los nombres solicitados, sus archivos fuente originales, la tabla de cobertura por archivo y las cuatro respuestas específicas del proyecto.
- Cobertura: 92/93 líneas (98.92%); main.dart 11/12 (91.67%), el menor de los archivos instrumentados. La interfaz sin líneas instrumentadas no se presenta como 0%.
- La rama deber3 está publicada. Las respuestas se fundamentan en los resultados observados; el estudiante debe revisar que reflejen su comprensión antes de presentarlas como propias.

**Resultado:** materiales presentes. La aceptación de capturas del visor tomadas después, en lugar de capturas contemporáneas de terminal, corresponde al docente. No se promete 10/10.

## Integridad

Los PNG provienen de una captura real de ventana. No se inventaron salidas, no se cambiaron las pruebas para aprobarlas, no se retocó el contenido de las imágenes y no se reescribieron los commits TDD. No se modificó código de producción durante esta revisión.
