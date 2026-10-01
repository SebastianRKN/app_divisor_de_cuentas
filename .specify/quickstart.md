# Validar y ejecutar
Con Flutter estable, Android SDK y JDK configurados:
1. git checkout sdd
2. flutter pub get
3. flutter test --reporter expanded
4. flutter analyze
5. flutter build apk --debug
6. flutter run (elegir dispositivo disponible)

Resultados esperados: seis pruebas de dominio más LSP y pruebas de pantalla en verde,
análisis sin issues, APK en build/app/outputs/flutter-apk/app-debug.apk.
Consultar spec.md para entradas y resultados, y contracts/interfaz.md para textos.
