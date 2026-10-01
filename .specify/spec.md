# Feature Specification: Divisor de cuenta

**Feature Branch**: sdd
**Created**: 2026-10-01
**Status**: Especificada
**Input**: Una pantalla para dividir una cuenta de restaurante entre varias personas.

## User Scenarios & Testing

### User Story 1 - Calcular reparto (Priority: P1)
Como comensal quiero ingresar monto, personas y propina, elegir el redondeo y tocar Calcular
para ver el pago por persona con dos decimales.
**Why this priority**: es la única función de la app.
**Independent Test**: ingresar los datos de cada fila y comprobar el texto visible.

| Caso | Monto | Personas | Propina % | Modo | Resultado esperado |
|---|---|---|---|---|---|
| 1 | 100.00 | 4 | 10 | exacto | 27.50 |
| 2 | 90.00 | 3 | 0 | exacto | 30.00 |
| 3 | 50.00 | 0 | 0 | exacto | Debe haber al menos una persona; sin resultado |
| 4 | abc | 4 | 0 | exacto | Monto inválido |
| 5 | 10.00 | 3 | 0 | exacto | 3.33 |
| 6 | 10.00 | 3 | 0 | arriba | 4.00 |

### Edge Cases
Cero personas y texto no numérico generan los mensajes anteriores.
Un error retira cualquier resultado anterior. Cero de monto o propina es válido.

## Requirements

### Functional Requirements
- FR-001: Una pantalla con monto, personas, propina, selector, botón Calcular y resultado/error.
- FR-002: Repartir monto más propina entre personas.
- FR-003: Exacto expresa centavos; arriba devuelve el entero superior, ambos con dos decimales.
- FR-004: No calcular ni mostrar pago para entradas inválidas.
- FR-005: Funcionar offline sin red ni base de datos.
- FR-006: Sin login, historial, ni funciones ajenas al reparto.

### Key Entities
- Cuenta: monto, número de personas y porcentaje de propina.
- Resultado: cantidad a pagar por persona.

## Success Criteria

### Measurable Outcomes
- SC-001: Cumplir los seis escenarios de aceptación.
- SC-002: Mostrar dos decimales en todos los resultados válidos.
- SC-003: Ningún error de entrada conserva un pago visible.
- SC-004: Completar el reparto sin conexión ni almacenamiento de datos.

## Assumptions
Decisiones menores del agente: aceptar coma decimal además de punto; rechazar negativos,
NaN e infinito; propina inválida muestra "Propina inválida". Personas requiere entero positivo.
Valores iniciales: 2 personas y 0% de propina. Exacto redondea a centavos, no distribuye
diferencias de centavos entre personas. No hay requisito de contabilidad exacta por individuo.
