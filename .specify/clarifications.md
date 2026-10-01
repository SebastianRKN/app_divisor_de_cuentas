# Clarificaciones de la reconstrucción interactiva
Fecha: 2026-10-01.

Pregunta real: Si el usuario deja vacía la propina, ¿qué debe pasar?
Opciones presentadas: interpretarla como 0% o mostrar "Propina inválida".
Respuesta del estudiante: "interpretala como 0".

Decisión: tratar el campo vacío como 0%, también cuando solo contiene espacios.
Texto no vacío que no sea un porcentaje válido sigue produciendo "Propina inválida".
La especificación refleja la decisión en FR-008, casos límite y Clarifications.
Verificación prevista: 100 / 4 con propina vacía y modo exacto devuelve 25.00.
No se implementó código en esta etapa.
