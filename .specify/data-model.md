# Modelo de datos
## Cuenta
Datos inmutables: monto (double), personas (int), propina (double).
Sin identidad persistente ni base de datos. El controller convierte la propina vacía
a cero antes de crear Cuenta.
ValidarEntrada comprueba finitud, no negatividad, personas >= 1 y rango numérico.
Texto no parseable se representa como entrada inválida; nunca llega al cálculo.

## Resultado
porPersona (double): pago después del redondeo, sin texto ni símbolo monetario.
Exacto devuelve centavos; arriba devuelve entero expresado numéricamente.

## Estado de pantalla
Inicial: sin pago ni error. Al calcular: éxito con Resultado o fallo con mensaje.
Resultado/error son mutuamente excluyentes. Recalcular con error borra el pago previo.
Ningún dato se persiste.
