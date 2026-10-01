import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_divisor_de_cuentas/main.dart';

void main() {
  final escenarios = [
    ('100', '4', '10', false, '27.50', false),
    ('90', '3', '0', false, '30.00', false),
    ('50', '0', '0', false, 'Debe haber al menos una persona', true),
    ('abc', '4', '0', false, 'Monto inválido', true),
    ('10', '3', '0', false, '3.33', false),
    ('10', '3', '0', true, '4.00', false),
  ];
  for (var i = 0; i < escenarios.length; i++) {
    final caso = escenarios[i];
    testWidgets('Aceptación vibe ${i + 1}', (tester) async {
      await tester.pumpWidget(const AplicacionDivisor());
      await tester.enterText(find.byKey(const Key('monto')), caso.$1);
      await tester.enterText(find.byKey(const Key('personas')), caso.$2);
      await tester.enterText(find.byKey(const Key('propina')), caso.$3);
      if (caso.$4) {
        await tester.tap(find.text('Exacto'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Hacia arriba').last);
        await tester.pumpAndSettle();
      }
      await tester.tap(find.text('Calcular'));
      await tester.pumpAndSettle();
      expect(find.text(caso.$5), findsOneWidget);
      expect(
        find.byKey(const Key('resultado')),
        caso.$6 ? findsNothing : findsOneWidget,
      );
    });
  }
}
