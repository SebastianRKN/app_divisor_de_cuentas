import '../domain/calcular_division.dart';
import '../domain/cuenta.dart';
import '../domain/estrategia_redondeo.dart';
import '../domain/resultado.dart';
import '../domain/validar_entrada.dart';

class DivisorController {
  DivisorController({
    required this.validador,
    required this.calculador,
    required Map<String, EstrategiaRedondeo> estrategias,
  }) : _estrategias = Map.unmodifiable(estrategias);

  final ValidadorEntrada validador;
  final CalculadorDivision calculador;
  final Map<String, EstrategiaRedondeo> _estrategias;

  /// Expone las opciones registradas sin conocer sus implementaciones.
  List<String> get modos => _estrategias.keys.toList(growable: false);

  /// Coordina texto -> datos -> validación -> cálculo.
  /// Devuelve resultado o error (nunca ambos); no lanza por entradas del usuario.
  ({Resultado? resultado, String? error}) calcular({
    required String monto,
    required String personas,
    required String propina,
    required String modo,
  }) {
    final cuenta = Cuenta(
      monto: double.tryParse(monto.trim().replaceAll(',', '.')) ?? double.nan,
      personas: int.tryParse(personas.trim()) ?? 0,
      propina: propina.trim().isEmpty
          ? 0
          : double.tryParse(propina.trim().replaceAll(',', '.')) ?? double.nan,
    );
    final error = validador.ejecutar(cuenta);
    if (error != null) return (resultado: null, error: error);
    final estrategia = _estrategias[modo];
    if (estrategia == null) {
      return (resultado: null, error: 'Modo inválido');
    }
    return (resultado: calculador.ejecutar(cuenta, estrategia), error: null);
  }
}
