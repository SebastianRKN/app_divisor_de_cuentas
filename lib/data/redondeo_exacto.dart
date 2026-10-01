import '../domain/estrategia_redondeo.dart';

class RedondeoExacto implements EstrategiaRedondeo {
  /// Recibe un pago validado y devuelve los centavos más cercanos.
  /// Implementa el modo exacto; no formatea ni produce errores con entradas válidas.
  @override
  double redondear(double cantidad) => (cantidad * 100).roundToDouble() / 100;
}
