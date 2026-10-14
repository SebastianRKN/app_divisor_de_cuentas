# Parte 5: análisis de mantenibilidad

Inspección de los 11 archivos de lib/ en el commit 4cbf3c1, antes de refactorizar. Las líneas corresponden a ese commit.

| Archivo y línea | Code smell | Problema | Posible solución |
|---|---|---|---|
| lib/data/redondeo_exacto.dart:7 | Número mágico (seleccionado) | El 100 repetido representa centavos por unidad, pero la intención queda implícita. | Declarar una constante privada `_centavosPorUnidad = 100` y usarla en ambos lugares. |
| lib/presentation/divisor_controller.dart:30 y 33 | Código duplicado | Monto y propina repiten normalización, conversión decimal y valor de respaldo. | Extraer una función privada de conversión de texto. No se modifica en este deber. |
| lib/presentation/pantalla_divisor.dart:55-152 | Método largo | build concentra todo el árbol visual y dificulta localizar sus secciones. Es habitual en Flutter y de menor prioridad en esta pantalla pequeña. | Extraer widgets privados para campos y resultado si la pantalla crece. No se modifica. |

Se revisaron también main, cuenta, resultado, estrategia_redondeo, calcular_division, validar_entrada, redondeo_hacia_arriba y formateador_moneda. No se atribuyen nombres deficientes ni responsabilidades mezcladas sin evidencia: la arquitectura separa validación, cálculo, presentación y redondeo.

La única refactorización elegida es el número mágico de RedondeoExacto. No se modifica el 100 de porcentajes, que tiene otro significado, ni los otros candidatos. Las reglas actuales del linter no exigen nombres para estas constantes numéricas.
