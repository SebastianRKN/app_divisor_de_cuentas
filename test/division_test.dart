import 'package:flutter_test/flutter_test.dart';
import 'package:app_divisor_de_cuentas/data/redondeo_exacto.dart';
import 'package:app_divisor_de_cuentas/data/redondeo_hacia_arriba.dart';
import 'package:app_divisor_de_cuentas/domain/calcular_division.dart';
import 'package:app_divisor_de_cuentas/domain/cuenta.dart';
import 'package:app_divisor_de_cuentas/domain/estrategia_redondeo.dart';
import 'package:app_divisor_de_cuentas/domain/validar_entrada.dart';

import 'casos_de_prueba.dart';

void main() {
  final estrategias = <String, EstrategiaRedondeo>{
    'exacto': RedondeoExacto(),
    'arriba': RedondeoHaciaArriba(),
  };
  final validar = ValidarEntrada();
  final calcular = CalcularDivision();
  for (final caso in casos) {
    test(caso.nombre, () {
      final cuenta = Cuenta(
        monto: caso.monto,
        personas: caso.personas,
        propina: caso.propina,
      );
      final error = validar.ejecutar(cuenta);
      if (caso.errorEsperado != null) {
        expect(error, caso.errorEsperado);
        return; // No se invoca el cálculo ante una entrada inválida.
      }
      expect(error, isNull);
      final resultado = calcular.ejecutar(cuenta, estrategias[caso.modo]!);
      expect(resultado.porPersona, closeTo(caso.esperado!, 0.001));
    });
  }
  test('LSP: el mismo cálculo acepta ambas estrategias', () {
    const cuenta = Cuenta(monto: 10, personas: 3, propina: 0);
    final variantes = <(EstrategiaRedondeo, double)>[
      (RedondeoExacto(), 3.33),
      (RedondeoHaciaArriba(), 4.00),
    ];
    for (final (estrategia, esperado) in variantes) {
      expect(
        calcular.ejecutar(cuenta, estrategia).porPersona,
        closeTo(esperado, 0.001),
      );
    }
  });
  test('Rechaza una propina del 150%', () {
    const cuenta = Cuenta(monto: 100, personas: 4, propina: 150);
    expect(validar.ejecutar(cuenta), 'La propina no puede superar el 100%');
  });
  test('Permite una propina exactamente del 100%', () {
    const cuenta = Cuenta(monto: 100, personas: 4, propina: 100);
    expect(validar.ejecutar(cuenta), isNull);
  });
}
