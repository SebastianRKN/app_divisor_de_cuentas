import 'package:flutter_test/flutter_test.dart';
import 'package:app_divisor_de_cuentas/domain/cuenta.dart';
import 'package:app_divisor_de_cuentas/domain/calcular_division.dart';
import 'package:app_divisor_de_cuentas/domain/estrategia_redondeo.dart';
import 'package:app_divisor_de_cuentas/domain/validar_entrada.dart';

class RedondeoMultiploCinco implements EstrategiaRedondeo {
  @override
  double redondear(double cantidad) => (cantidad / 5).roundToDouble() * 5;
}

void main() {
  test('Validación rechaza límites inválidos y acepta cero', () {
    final validar = ValidarEntrada();
    for (final monto in [-1.0, double.nan, double.infinity, double.maxFinite]) {
      expect(
        validar.ejecutar(Cuenta(monto: monto, personas: 2, propina: 10)),
        'Monto inválido',
      );
    }
    for (final propina in [-1.0, double.nan, double.infinity]) {
      expect(
        validar.ejecutar(Cuenta(monto: 10, personas: 2, propina: propina)),
        'Propina inválida',
      );
    }
    expect(
      validar.ejecutar(const Cuenta(monto: 0, personas: 1, propina: 0)),
      isNull,
    );
  });
  test('OCP: tercera estrategia sin cambiar CalcularDivision', () {
    expect(
      CalcularDivision()
          .ejecutar(
            const Cuenta(monto: 28, personas: 2, propina: 0),
            RedondeoMultiploCinco(),
          )
          .porPersona,
      15,
    );
  });
}
