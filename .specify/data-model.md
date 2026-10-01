# Modelo de datos
Cuenta: monto double, personas int, propina double; inmutable.
Resultado: porPersona double; inmutable.
Validación: monto/propina finitos no negativos, personas >= 1; rechazar desbordamiento.
Estado de presentación: resultado nullable y error nullable mutuamente excluyentes.
Cada cálculo borra el estado anterior; un error nunca conserva un resultado válido previo.
EstrategiaRedondeo.redondear recibe pago finito no negativo y devuelve pago redondeado.
