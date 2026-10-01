# Implementation Plan: Divisor de cuenta
**Branch**: sdd | **Date**: 2026-10-01 | **Spec**: [spec.md](spec.md)

## Summary
Una pantalla Flutter, estado local con setState, cálculo Dart puro y estrategias inyectadas.

## Technical Context
Flutter estable 3.47.1; Dart 3.13.1. Sin nuevas dependencias de ejecución.
flutter_test y flutter_lints ya pertenecen a la plantilla base.
Sin almacenamiento ni red. Plataforma de entrega: Android debug.
Alcance: una pantalla, operaciones constantes; sin objetivos de latencia inventados.

## Constitution Check
Antes y después del diseño: SRP separa cálculo, validación y formato; OCP/LSP mediante
EstrategiaRedondeo; ISP una operación; DIP con interfaces de validación y cálculo en domain.
Sin Flutter en domain. main compone las estrategias y dependencias.
Los tests pueden crear implementaciones concretas fuera de lib/, pues deben comprobarlas.

## Project Structure
- lib/domain/cuenta.dart: datos inmutables del cálculo.
- lib/domain/resultado.dart: pago por persona.
- lib/domain/estrategia_redondeo.dart: interfaz con redondear(double).
- lib/domain/calcular_division.dart: interfaz CalculadorDivision y caso de uso CalcularDivision;
  ejecutar recibe Cuenta ya validada y EstrategiaRedondeo. No valida ni formatea.
- lib/domain/validar_entrada.dart: interfaz ValidadorEntrada y ValidarEntrada; devuelve error o null.
- lib/data/redondeo_exacto.dart: centavos, usando aritmética.
- lib/data/redondeo_hacia_arriba.dart: techo entero.
- lib/presentation/divisor_controller.dart: parsea, valida, coordina y devuelve resultado/error;
  recibe abstracciones de domain por constructor y mapa de estrategias.
- lib/presentation/formateador_moneda.dart: exclusivamente dos decimales.
- lib/presentation/pantalla_divisor.dart: campos, selector, botón, mensajes; setState.
- lib/main.dart: composición de dependencias y arranque.
- test/casos_de_prueba.dart: exactamente seis datos de aceptación.
- test/division_test.dart: seis pruebas y LSP sin widgets.
- test/pantalla_test.dart: seis escenarios de interfaz y regresión de resultado obsoleto.
- test/validacion_test.dart: límites inválidos y sustitución por tercera estrategia de prueba.

## Validation
flutter pub get; flutter test --reporter expanded; flutter analyze; flutter build apk --debug.
Además búsquedas estructurales SOLID, métricas y reutilización temporal de test/ en vibe.
Se usa flutter_test disponible para ejecutar tests; el código de dominio no depende de Flutter.
No se agrega package:test solo por duplicar el runner.
