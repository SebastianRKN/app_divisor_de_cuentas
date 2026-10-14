import '../domain/estrategia_redondeo.dart';

class RedondeoExacto implements EstrategiaRedondeo {
  static const _centavosPorUnidad = 100;

  /// Recibe un pago validado y devuelve los centavos más cercanos.
  /// Implementa el modo exacto; no formatea ni produce errores con entradas válidas.
  @override
  double redondear(double cantidad) =>
      (cantidad * _centavosPorUnidad).roundToDouble() / _centavosPorUnidad;
}
