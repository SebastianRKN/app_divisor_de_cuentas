# Bitácora de la reconstrucción interactiva
Esta tabla distingue la rama vibe conservada de sdd-interactivo.
La implementación anterior de sdd sigue disponible como respaldo; no se reescribió su historia.

| Métrica | vibe | sdd-interactivo |
|---|---|---|
| Iteraciones adicionales | No reproducible de forma fiel en esta ejecución automatizada. | No comparable como experimento independiente; hubo confirmaciones por etapa y una decisión funcional real |
| Casos de aceptación (0–6) | 6/6 en ejecución anterior documentada en main | 6/6 |
| Pruebas automatizadas que pasan | 6 (ejecución anterior) | 26 |
| Archivos Dart en lib/ | 1 | 11 |
| Líneas Dart en lib/ | 145 | 320 |
| ¿domain depende de Flutter? | No existe domain | No |
| ¿Separación presentation/domain/data? | No | Sí |
| ¿Funciones no pedidas? | Sin funciones adicionales; decisiones menores documentadas | Sin funciones adicionales; prueba OCP no añade un modo al producto |
| ¿Nueva estrategia sin editar cálculo? | No | Sí |

| Métrica secundaria | vibe | sdd-interactivo |
|---|---|---|
| Tiempo hasta cumplir seis escenarios | No registrado | No registrado |

Decisión del estudiante en clarify: "interpretala como 0", aplicada a propina vacía.
Se reutilizó código compatible del respaldo, con pruebas que primero detectaron cuatro
fallos y después pasaron tras corregir el controller. Detalle y límites en
.specify/verificacion.md. Mismo agente de la sesión, sin delegación; no se inventa
identificador exacto de modelo ni nivel de razonamiento.
