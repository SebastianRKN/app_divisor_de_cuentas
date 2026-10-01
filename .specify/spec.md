# Feature Specification: Dividir una cuenta

**Feature Branch**: sdd-interactivo
**Created**: 2026-10-01
**Status**: Lista para planificación; clarificación de propina resuelta
**Input**: Alcance confirmado por el estudiante: una pantalla con monto, personas,
propina, redondeo exacto/hacia arriba y resultado con dos decimales, sin conexión.

## User Scenarios & Testing

### User Story 1 - Conocer el pago por persona (Priority: P1)
Como comensal quiero ingresar la cuenta, el número de personas y la propina,
elegir un modo de redondeo y tocar Calcular para saber cuánto paga cada persona.

**Why this priority**: es la función central y única de la aplicación.
**Independent Test**: ingresar cada fila y verificar el resultado después de tocar Calcular.

**Acceptance Scenarios**:

| Caso | Monto | Personas | Propina (%) | Modo | Salida esperada |
|---|---|---|---|---|---|
| 1 | 100.00 | 4 | 10 | exacto | 27.50 por persona |
| 2 | 90.00 | 3 | 0 | exacto | 30.00 por persona |
| 3 | 50.00 | 0 | 0 | exacto | Debe haber al menos una persona; sin resultado |
| 4 | abc | 4 | 0 | exacto | Monto inválido; sin resultado |
| 5 | 10.00 | 3 | 0 | exacto | 3.33 por persona |
| 6 | 10.00 | 3 | 0 | arriba | 4.00 por persona |

### Edge Cases
- Un error de entrada retira cualquier resultado anterior.
- Personas debe ser un entero positivo; texto, fracciones, vacío y valores menores que uno
  muestran "Debe haber al menos una persona".
- Monto vacío, negativo, no numérico o no finito muestra "Monto inválido".
- Propina vacía (también si contiene solo espacios) equivale a 0%.
- Propina no vacía negativa, no numérica o no finita muestra "Propina inválida".
- Monto cero y propina cero son válidos.
- Si los datos exceden la capacidad de cálculo, mostrar "Monto inválido", sin pago.

## Requirements

### Functional Requirements
- **FR-001**: Una sola pantalla permite ingresar monto total, personas y porcentaje de propina.
- **FR-002**: El usuario elige Exacto o Hacia arriba y toca Calcular.
- **FR-003**: El pago se obtiene de (monto + monto × propina / 100) / personas.
- **FR-004**: Exacto redondea a centavos; Hacia arriba al entero superior.
  Ambos muestran dos decimales.
- **FR-005**: Las entradas inválidas muestran el mensaje correspondiente sin resultado de pago.
- **FR-006**: Funciona completamente offline, sin red ni base de datos.
- **FR-007**: No incluye login, historial, reparto desigual ni funciones adicionales.
- **FR-008**: Al calcular, la propina vacía se interpreta como 0%, sin mostrar error.

### Key Entities
- **Cuenta**: monto total, número de personas y porcentaje de propina.
- **Resultado**: pago por persona después de aplicar el redondeo elegido.

## Success Criteria

### Measurable Outcomes
- **SC-001**: Cumplir los seis escenarios de aceptación.
- **SC-002**: Todo pago válido se presenta con dos decimales.
- **SC-003**: Ninguna entrada inválida deja visible un resultado anterior al recalcular.
- **SC-004**: Completar todos los escenarios sin conexión y desde una sola pantalla.

## Assumptions
Estas decisiones menores son propuestas del agente para revisar en clarify, no respuestas
atribuidas al estudiante:
- Modo inicial Exacto; propina inicialmente 0.
- Aceptar punto y coma como separador decimal, sin separadores de miles.
- No se distribuye la diferencia de centavos entre personas ni se promete que la suma
  redondeada coincida exactamente con el total.
- Las reglas técnicas de arquitectura limpia se encuentran en la constitución;
  esta especificación describe el comportamiento.

## Clarifications

### Session 2026-10-01
- Q: Si el usuario deja vacía la propina, ¿qué debe pasar?
  → A: "interpretala como 0". La entrada vacía se interpreta como 0%.
- Comprobación adicional: monto 100, 4 personas, propina vacía y modo exacto
  debe mostrar 25.00 por persona, sin error. Esta comprobación complementa
  los seis escenarios originales sin reemplazarlos.