import '../domain/estrategia_redondeo.dart';

class RedondeoHaciaArriba implements EstrategiaRedondeo {
  /// Recibe un pago validado y devuelve el entero superior.
  /// Implementa el modo arriba; no produce errores con entradas válidas.
  @override
  double redondear(double cantidad) => cantidad.ceilToDouble();
}
