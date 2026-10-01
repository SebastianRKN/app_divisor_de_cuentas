import 'package:flutter/material.dart';

import 'data/redondeo_exacto.dart';
import 'data/redondeo_hacia_arriba.dart';
import 'domain/calcular_division.dart';
import 'domain/validar_entrada.dart';
import 'presentation/divisor_controller.dart';
import 'presentation/formateador_moneda.dart';
import 'presentation/pantalla_divisor.dart';

/// Arranca Flutter; no recibe datos ni devuelve valor.
void main() => runApp(crearAplicacion());

/// Compone dependencias de producción y devuelve la aplicación.
/// Compartida con las pruebas de interfaz; sin entradas ni errores esperados.
Widget crearAplicacion() {
  final controller = DivisorController(
    validador: ValidarEntrada(),
    calculador: CalcularDivision(),
    estrategias: {
      'Exacto': RedondeoExacto(),
      'Hacia arriba': RedondeoHaciaArriba(),
    },
  );
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Divisor de cuenta',
    theme: ThemeData(colorSchemeSeed: Colors.teal, useMaterial3: true),
    home: PantallaDivisor(
      controller: controller,
      formateador: FormateadorMoneda(),
    ),
  );
}
