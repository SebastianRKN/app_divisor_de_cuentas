abstract interface class EstrategiaRedondeo {
  /// Transforma un pago finito no negativo en su valor redondeado.
  /// Permite cambiar la regla sin cambiar el cálculo; no produce errores
  /// cuando recibe una cantidad validada.
  double redondear(double cantidad);
}
