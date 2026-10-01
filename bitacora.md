# Bitácora de métricas

| Métrica | rama vibe | rama sdd |
|---|---|---|
| Iteraciones adicionales | No reproducible de forma fiel en esta ejecución automatizada. | No reproducible de forma fiel en esta ejecución automatizada. |
| Casos de aceptación que cumple (0–6) | 6/6 mediante pruebas de interfaz | 6/6 en dominio e interfaz |
| Pruebas automatizadas que pasan | 6 propias; suite SDD incompatible | 16 |
| Archivos Dart en lib/ | 1 | 11 |
| Líneas de código Dart en lib/ | 145 | 319 |
| ¿domain/ depende de Flutter? | No existe domain/; cálculo acoplado al widget Flutter | No |
| ¿Existe separación presentation/domain/data? | No | Sí |
| ¿El agente agregó algo que nadie pidió? | Decisiones menores: coma decimal y validación de límites; sin nuevas funciones de producto | Mismas decisiones menores, documentadas; pruebas adicionales justificadas |
| ¿Se puede agregar otra estrategia sin modificar el cálculo existente? | No: se modifica _calcular | Sí: implementar EstrategiaRedondeo y registrarla en main |

| Métrica secundaria | rama vibe | rama sdd |
|---|---:|---:|
| Tiempo aproximado hasta cumplir los seis escenarios | No registrado | No registrado |


Base común: 660c5b9336d24239e455aff48c87906b8376b5da.
Caso Git A: proyecto Flutter existente sin repositorio.
Codex; sin cambios voluntarios de modelo ni subagentes. Modelo exacto y nivel de razonamiento no verificables.
Métricas de lib/ incluyen comentarios y líneas vacías.
Vibe: dd87a4e; SDD: 92fc101. Análisis sin issues en ambas implementaciones.
SDD: APK debug compilado; 16 pruebas en verde en verificación final.
La suite SDD importada en vibe no compiló por falta de lib/data/redondeo_exacto.dart.
Pruebas propias de vibe restauradas: seis en verde.
Evidencia completa en evidencia/ y explicación metodológica en respuestas.md.