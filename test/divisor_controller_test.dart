import 'package:flutter_test/flutter_test.dart';
import 'package:app_divisor_de_cuentas/domain/cuenta.dart';
import 'package:app_divisor_de_cuentas/domain/resultado.dart';
import 'package:app_divisor_de_cuentas/domain/calcular_division.dart';
import 'package:app_divisor_de_cuentas/domain/estrategia_redondeo.dart';
import 'package:app_divisor_de_cuentas/domain/validar_entrada.dart';
import 'package:app_divisor_de_cuentas/data/redondeo_exacto.dart';
import 'package:app_divisor_de_cuentas/presentation/divisor_controller.dart';

class CalculoEspia implements CalculadorDivision {
  int llamadas = 0;
  @override
  Resultado ejecutar(Cuenta cuenta, EstrategiaRedondeo estrategia) {
    llamadas++;
    return CalcularDivision().ejecutar(cuenta, estrategia);
  }
}

void main() {
  for (final propina in ['', '   ']) {
    test('Controller interpreta propina "$propina" como cero', () {
      final espia = CalculoEspia();
      final controller = DivisorController(
        validador: ValidarEntrada(),
        calculador: espia,
        estrategias: {'Exacto': RedondeoExacto()},
      );
      final respuesta = controller.calcular(
        monto: '100',
        personas: '4',
        propina: propina,
        modo: 'Exacto',
      );
      expect(respuesta.error, isNull);
      expect(respuesta.resultado!.porPersona, 25);
      expect(espia.llamadas, 1);
    });
  }
  test('Controller acepta coma decimal', () {
    final controller = DivisorController(
      validador: ValidarEntrada(),
      calculador: CalcularDivision(),
      estrategias: {'Exacto': RedondeoExacto()},
    );
    final respuesta = controller.calcular(
      monto: '100,00',
      personas: '4',
      propina: '10,0',
      modo: 'Exacto',
    );
    expect(respuesta.error, isNull);
    expect(respuesta.resultado!.porPersona, 27.50);
  });
  for (final caso in [
    ('abc', '4', '0', 'Monto inválido'),
    ('100', '1.5', '0', 'Debe haber al menos una persona'),
    ('100', '-1', '0', 'Debe haber al menos una persona'),
    ('100', '', '0', 'Debe haber al menos una persona'),
    ('100', '4', 'abc', 'Propina inválida'),
  ]) {
    test('Controller no calcula entradas inválidas: $caso', () {
      final espia = CalculoEspia();
      final controller = DivisorController(
        validador: ValidarEntrada(),
        calculador: espia,
        estrategias: {'Exacto': RedondeoExacto()},
      );
      final respuesta = controller.calcular(
        monto: caso.$1,
        personas: caso.$2,
        propina: caso.$3,
        modo: 'Exacto',
      );
      expect(respuesta.error, caso.$4);
      expect(respuesta.resultado, isNull);
      expect(espia.llamadas, 0);
    });
  }
}
