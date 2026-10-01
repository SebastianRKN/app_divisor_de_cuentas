# Instrucciones para Codex

## Descripción
App Flutter de una sola pantalla para dividir una cuenta.

## Estructura
lib/presentation, lib/domain, lib/data.
Dependencias: presentation -> domain <- data.

## Reglas
- domain no importa package:flutter.
- Null safety y nombres en español (excepto API del framework).
- Sin paquetes externos innecesarios ni dependencias nuevas sin necesidad.
- No modificar android/ ni ios/ salvo que sea indispensable.
- main.dart es el punto de composición; las estrategias concretas de producción solo se instancian allí.

## Comandos
flutter pub get
flutter run
flutter analyze
flutter test
