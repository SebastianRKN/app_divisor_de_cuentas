# Deber 3 — Sebastián Rosero

Rama de entrega: https://github.com/SebastianRKN/app_divisor_de_cuentas/tree/deber3

## Resultado

Aplicación Flutter original conservada. Las propinas mayores al 100% se rechazan con `La propina no puede superar el 100%`; el 100% está permitido. El controlador valida antes de calcular y la pantalla retira el resultado cuando hay un error.

| Parte | Estado verificado |
|---|---|
| 1. Preparación | Ejecutada: sdd limpio, dependencias resueltas, 16 pruebas correctas. PNG pendiente. |
| 2. Rojo | Ejecutada: exactamente dos pruebas nuevas; 17 correctas y 1 fallo por devolver null. Commit real anterior al código. PNG pendiente. |
| 3. Verde | Ejecutada: cambio mínimo en lib/, 18 pruebas correctas. PNG pendiente. |
| 4. Linter | Ejecutada: avisos temporales unused_local_variable y avoid_print registrados y retirados. Análisis final limpio; sin commit vacío. PNG pendiente. |
| 5. Code smells | Completa: revisión de los 11 archivos; hallazgos con líneas en evidencias/parte5_code_smells.md. |
| 6. Refactor | Ejecutada: constante privada para centavos; 18 pruebas antes y después, sin cambios en test/. PNG pendiente. |
| 7. Cobertura | Ejecutada: 92/93 líneas (98.92%). coverage/ ignorado y excluido de la entrega. PNG pendiente. |
| 8. Documentación | Respuestas, registros e historial preparados. Las siete capturas PNG siguen pendientes; consultar evidencias/README.md. |

## Verificaciones finales

- Flutter 3.47.1, Dart 3.13.1.
- `flutter test`: 18 pruebas correctas.
- `flutter analyze`: `No issues found!`.
- `flutter build web --release`: compilación correcta (`Built build/web`). Hubo un aviso no bloqueante sobre la fuente opcional Cupertino; no se afirma compilación Android/iOS en esta sesión.
- Comprobación adicional de widgets: 100% produce 50.00; 150% muestra el mensaje exacto y elimina el resultado; volver a 100% recupera 50.00. Una prueba adicional ejecutada correctamente fuera de test/; fuente y salida conservadas en evidencias/.
- Menor cobertura instrumentada: lib/main.dart, 11/12 líneas (91.67%). Los otros nueve archivos instrumentados tienen 100%; estrategia_redondeo.dart no tiene líneas instrumentadas. Tabla completa: evidencias/cobertura.md.
- Historial: 7d4e28b (rojo), 4cbf3c1 (verde), dca80ab (refactor). El commit documental final añade estas evidencias y respuestas.

## Proyecto reproducible

El ZIP contiene una carpeta app_divisor_de_cuentas/ con fuentes, pruebas, plataformas Flutter y configuración. No incluye .git, .dart_tool, build, coverage, dependencias descargadas ni credenciales. El historial completo está en GitHub; su registro previo al commit documental está en evidencias/parte8_log.txt.

Con Flutter 3.47.1 / Dart 3.13.1 se puede recuperar el proyecto con `flutter pub get`, verificar con `flutter test` y `flutter analyze`, y compilar con `flutter build web --release`. Estos comandos ya se ejecutaron durante la preparación; se indican para reproducibilidad.

## Límite de la entrega

No se generó ninguna captura PNG: la consola del entorno no expuso una ventana capturable. Se conservaron registros auténticos durante las etapas; no son capturas simuladas. Si D2L exige los siete PNG como requisito estricto, ese requisito sigue pendiente. El código, los commits, las respuestas y las verificaciones sí están realizados.
