# Deber 3 — Respuestas

## 1. Rojo antes de verde
Flutter test mostró `Expected: 'La propina no puede superar el 100%'` y `Actual: <null>`; también indicó `Which: not an <Instance of 'String'>`. Pasaron 17 pruebas y falló la nueva de 150%. Era necesario comprobar ese fallo para demostrar que faltaba la regla antes de implementarla y que la prueba realmente la exigía. La prueba del límite de 100% sí pasó.

## 2. Linter vs. IA
El análisis inicial no tenía avisos. Al introducir los ejemplos temporales aparecieron `unused_local_variable` (la variable local no se usaba) y `avoid_print` por `print('hola');`. Después los retiré y el análisis quedó limpio. La IA identificó el 100 repetido en `lib/data/redondeo_exacto.dart`, línea 7 antes del refactor: representa centavos por unidad sin nombrar esa intención. El linter no lo señaló porque sus reglas configuradas no evalúan si un número necesita un nombre para aclarar su significado.

## 3. Refactorización
Elegí el número mágico del redondeo. Declaré la constante privada `_centavosPorUnidad = 100` y reemplacé las dos apariciones del 100 en la misma fórmula. No cambié las pruebas ni añadí funcionalidad. Las 18 pruebas pasaron antes y después; el diff confirma que solo cambió ese archivo y que las operaciones conservan el mismo orden y valor. Esto respalda la conservación de los casos comprobados, sin afirmar que las pruebas cubren cualquier entrada posible.

## 4. Coverage
`lib/main.dart` tuvo la menor cobertura entre los archivos instrumentados: 11 de 12 líneas, es decir, 91.67%. La cobertura total fue 92 de 93 líneas (98.92%). La interfaz `estrategia_redondeo.dart` no aparece instrumentada y no corresponde asignarle 0%. Una línea sin ejecutar no demuestra un error: las pruebas crean la aplicación con `crearAplicacion()` y no ejecutan la línea de arranque `main()`. La cobertura mide ejecución de líneas, no demuestra corrección ni cobertura de todas las ramas.

La tabla completa está en `evidencias/cobertura.md` y las salidas originales en `evidencias/`. La procedencia y las limitaciones de las capturas se detallan en `evidencias/README.md`.
