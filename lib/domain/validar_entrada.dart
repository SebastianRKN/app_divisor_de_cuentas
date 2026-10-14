import 'cuenta.dart';

abstract interface class ValidadorEntrada {
  String? ejecutar(Cuenta cuenta);
}

class ValidarEntrada implements ValidadorEntrada {
  /// Evita cálculos indefinidos. Recibe los datos ya parseados y devuelve
  /// el primer mensaje de error o null si son válidos; no lanza excepciones.
  @override
  String? ejecutar(Cuenta cuenta) {
    if (!cuenta.monto.isFinite || cuenta.monto < 0) {
      return 'Monto inválido';
    }
    if (cuenta.personas < 1) {
      return 'Debe haber al menos una persona';
    }
    if (!cuenta.propina.isFinite || cuenta.propina < 0) {
      return 'Propina inválida';
    }
    if (cuenta.propina > 100) {
      return 'La propina no puede superar el 100%';
    }
    // Garantiza que tampoco desborden el total y el redondeo a centavos.
    final total = cuenta.monto * (1 + cuenta.propina / 100);
    if (!total.isFinite || !(total / cuenta.personas * 100).isFinite) {
      return 'Monto inválido';
    }
    return null;
  }
}
