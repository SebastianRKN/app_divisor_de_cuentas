# Guía de validación prevista
Requisitos: Flutter estable, Android SDK y JDK configurados.
En la rama sdd-interactivo, después de implementar:
1. flutter pub get
2. flutter test --reporter expanded
3. flutter analyze
4. flutter build apk --debug
5. flutter run en un dispositivo disponible.

Comprobar los seis casos de spec.md y la clarificación:
monto 100, 4 personas, borrar propina, Exacto -> 25.00 por persona.
Repetir con espacios en propina. Introducir luego cero personas y comprobar que
se retira el pago y aparece Debe haber al menos una persona.

Resultado esperado: pruebas aprobadas, análisis sin issues y APK debug construido.
Estos son criterios de validación futuros, no resultados ya obtenidos en esta rama.
