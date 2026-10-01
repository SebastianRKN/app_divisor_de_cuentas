import 'cuenta.dart';
import 'estrategia_redondeo.dart';
import 'resultado.dart';

abstract interface class CalculadorDivision {
  Resultado ejecutar(Cuenta cuenta, EstrategiaRedondeo estrategia);
}

class CalcularDivision implements CalculadorDivision {
  /// Reparte cuenta más propina y aplica la estrategia recibida.
  /// Devuelve el pago numérico; exige una cuenta previamente validada.
  /// No produce errores para entradas que cumplen esa precondición.
  @override
  Resultado ejecutar(Cuenta cuenta, EstrategiaRedondeo estrategia) {
    final pago = cuenta.monto * (1 + cuenta.propina / 100) / cuenta.personas;
    return Resultado(estrategia.redondear(pago));
  }
}
