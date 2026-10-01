import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_divisor_de_cuentas/main.dart';

import 'casos_de_prueba.dart';

Future<void> ingresar(
  WidgetTester tester,
  String monto,
  String personas,
  String propina,
) async {
  await tester.enterText(find.byKey(const Key('monto')), monto);
  await tester.enterText(find.byKey(const Key('personas')), personas);
  await tester.enterText(find.byKey(const Key('propina')), propina);
}

void main() {
  for (final caso in casos) {
    testWidgets('Pantalla: ${caso.nombre}', (tester) async {
      await tester.pumpWidget(crearAplicacion());
      await ingresar(
        tester,
        caso.monto.isNaN ? 'abc' : '${caso.monto}',
        '${caso.personas}',
        '${caso.propina}',
      );
      if (caso.modo == 'arriba') {
        await tester.tap(find.text('Exacto'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Hacia arriba').last);
        await tester.pumpAndSettle();
      }
      await tester.tap(find.text('Calcular'));
      await tester.pumpAndSettle();
      expect(
        find.text(caso.errorEsperado ?? caso.esperado!.toStringAsFixed(2)),
        findsOneWidget,
      );
      expect(
        find.byKey(const Key('resultado')),
        caso.errorEsperado != null ? findsNothing : findsOneWidget,
      );
    });
  }
  testWidgets('Un error retira el pago anterior', (tester) async {
    await tester.pumpWidget(crearAplicacion());
    await ingresar(tester, '100', '4', '10');
    await tester.tap(find.text('Calcular'));
    await tester.pumpAndSettle();
    expect(find.text('27.50'), findsOneWidget);
    await tester.enterText(find.byKey(const Key('personas')), '0');
    await tester.tap(find.text('Calcular'));
    await tester.pumpAndSettle();
    expect(find.text('Debe haber al menos una persona'), findsOneWidget);
    expect(find.byKey(const Key('resultado')), findsNothing);
    expect(find.text('Por persona'), findsNothing);
  });

  for (final propina in ['', '   ']) {
    testWidgets('Propina vacía o espacios "$propina" equivale a cero', (
      tester,
    ) async {
      await tester.pumpWidget(crearAplicacion());
      await ingresar(tester, '100', '4', propina);
      await tester.tap(find.text('Calcular'));
      await tester.pumpAndSettle();
      expect(find.text('25.00'), findsOneWidget);
      expect(find.text('Propina inválida'), findsNothing);
    });
  }
}
