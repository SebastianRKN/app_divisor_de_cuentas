# Verificación de implementación interactiva
Fecha: 2026-10-01. Rama: sdd-interactivo.

## Procedencia y proceso real
Se reutilizaron los archivos compatibles de la versión sdd anterior (92fc101),
después de acordar y documentar constitution, spec, clarify, plan, tasks y analyze.
No se presenta esta reconstrucción como un experimento independiente ni código
generado desde cero. La modificación funcional acordada es propina vacía = 0%.
Se redactaron contratos preliminares y se ejecutaron tests antes de completar lib/.

Primera fase roja: faltaban las implementaciones, con error al leer
lib/data/redondeo_exacto.dart. La ejecución inicial de analyze coincidió con los
contratos incompletos y reportó 45 issues; no se registra como análisis exitoso.
Después de reutilizar lib/, las pruebas específicas detectaron cuatro fallos reales:
propina vacía y espacios fallaban tanto en controller como en pantalla.
Se corrigió solo lib/presentation/divisor_controller.dart para normalizarlas a 0.
Las expectativas no fueron rebajadas para lograr el resultado.

## Ejecuciones finales
- flutter pub get: completado sin nuevas dependencias.
- flutter test --reporter expanded --concurrency=1: 26 pruebas aprobadas.
- flutter analyze: No issues found! (ran in 1.8s).
- flutter build apk --debug: Built build/app/outputs/flutter-apk/app-debug.apk.
- No se modificaron android/, ios/ ni pubspec.yaml.
- No se ejecutó una prueba manual en teléfono físico.
Los archivos de evidencia se encuentran en evidencia/interactivo/.

## Distribución de pruebas
- division_test.dart: 6 escenarios de dominio y LSP, 7 tests.
- divisor_controller_test.dart: 2 de propina vacía/espacios, 1 de coma decimal,
  5 entradas inválidas con espía de cálculo: 8 tests.
- pantalla_test.dart: 6 escenarios, error tras éxito, propina vacía y espacios: 9 tests.
- validar_entrada_test.dart: límites y OCP: 2 tests.
Total: 26. OCP está junto a los tests adicionales en validar_entrada_test.dart;
es una diferencia de ubicación respecto de T004, sin cambio de cobertura.
casos_de_prueba.dart mantiene exactamente seis casos.

## SOLID y arquitectura
Comandos ejecutados:
- Get-ChildItem lib/domain -Filter *.dart | Select-String 'package:flutter|presentation/|data/'
  -> sin coincidencias.
- Get-ChildItem lib/presentation -Filter *.dart | Select-String "import.*data/"
  -> sin coincidencias.
- Get-ChildItem lib -Recurse -Filter *.dart | Select-String 'RedondeoExacto\(\)|RedondeoHaciaArriba\(\)'
  -> solo lib/main.dart:21 y :22.
- Select-String -Path lib/domain/calcular_division.dart -Pattern
  'is Redondeo|as Redondeo|toStringAsFixed|inválido|al menos una persona'
  -> sin coincidencias.
- Búsqueda de http, dart:io, sqlite, apiKey y secret en lib/: sin coincidencias.

La lectura de lib/ confirma que no hay red ni persistencia.
SRP: validación, cálculo, formato y UI separados.
OCP: tercera estrategia de prueba sin cambiar CalcularDivision.
LSP: una misma instancia recibe las dos estrategias.
ISP: cada contrato tiene una operación.
DIP: controller recibe ValidadorEntrada, CalculadorDivision y registro de EstrategiaRedondeo.
Las búsquedas complementan la lectura y las pruebas; no son por sí solas prueba universal de SOLID.

## Explicación de funciones
- main: arranca Flutter; sin entradas ni retorno.
- crearAplicacion: construye servicios, estrategias y pantalla; devuelve Widget.
- CalcularDivision.ejecutar: recibe Cuenta validada y estrategia, devuelve Resultado.
  Su precondición es validación previa; no define mensajes ni conoce widgets.
- ValidarEntrada.ejecutar: recibe Cuenta, devuelve primer error o null, evita división
  inválida y desbordamiento.
- redondear: recibe pago validado; exacto devuelve centavos, arriba devuelve techo entero.
- DivisorController.calcular: recibe textos y modo; normaliza, parsea, valida y delega.
  Devuelve resultado o error; incluye Modo inválido si el identificador no está registrado.
- modos: expone etiquetas de las estrategias registradas.
- formatear: recibe pago y devuelve dos decimales.
- createState: crea el estado Flutter de la pantalla.
- _calcular: lee campos y actualiza pago/error usando el controller.
- build: recibe contexto y dibuja controles; no realiza el cálculo de negocio.
- dispose: libera controladores.
- Callback del selector: cambia modo y limpia resultado/error; sin retorno.
- Constructores: inicializan entidades y dependencias; no realizan cálculos.
Con entradas validadas estas operaciones no esperan excepciones; los errores de entrada
se representan mediante los mensajes especificados.

## Métricas
11 archivos Dart en lib/; 320 líneas incluidas líneas vacías y comentarios.
Comandos: (Get-ChildItem lib -Recurse -Filter *.dart).Count y
(Get-ChildItem lib -Recurse -Filter *.dart | Get-Content).Count.
Seis de seis escenarios originales y la clarificación comprobados.
No se registró tiempo comparable. Correcciones internas no son iteraciones del estudiante.
