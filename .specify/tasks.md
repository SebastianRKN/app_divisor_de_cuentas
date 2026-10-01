# Tasks: Dividir una cuenta
Fecha: 2026-10-01. Rama: sdd-interactivo.
Fuentes: spec.md, plan.md, memory/constitution.md, data-model.md y contracts/interfaz.md.
Todas las tareas están pendientes; esta etapa no implementa código.

## Phase 1: Setup
- [ ] T001 Verificar pubspec.yaml y analysis_options.yaml con flutter pub get y flutter analyze, sin agregar paquetes innecesarios.

## Phase 2: Foundational
- [ ] T002 Definir los contratos de dominio en lib/domain/estrategia_redondeo.dart, lib/domain/validar_entrada.dart y lib/domain/calcular_division.dart: un método por contrato; cálculo recibe Cuenta validada y estrategia. Sin implementar aún validación ni fórmula.

## Phase 3: US1 — Conocer el pago por persona (P1, MVP)
Objetivo: cumplir el flujo completo offline en una pantalla.
Prueba independiente: seis escenarios originales y propina vacía/espacios -> 25.00 para monto 100 y 4 personas.

### Pruebas antes del comportamiento
- [ ] T003 [US1] Crear exactamente los seis casos originales en test/casos_de_prueba.dart, incluyendo double.nan para monto inválido.
- [ ] T004 [US1] Crear test/division_test.dart: recorrer casos, validar antes de calcular, comprobar mensajes exactos y closeTo(esperado, 0.001); LSP con la misma instancia y OCP con estrategia de prueba al múltiplo de 5.
- [ ] T005 [US1] Crear test/divisor_controller_test.dart: propina vacía/espacios como cero, coma decimal, personas fraccionarias, texto inválido y doble de cálculo que pruebe cero llamadas si falla la validación.
- [ ] T006 [US1] Crear test/pantalla_test.dart: seis escenarios, propina vacía/espacios, error después de éxito sin pago visible; usar enterText, tap, pumpAndSettle y find.text.
- [ ] T007 [US1] Crear test/validar_entrada_test.dart: monto/propina negativos y no finitos, cero válido, personas menores que uno y desbordamiento; ejecutar test/ y registrar fallo esperado antes de implementar.

### Implementación
- [ ] T008 [US1] Crear lib/domain/cuenta.dart: "Datos inmutables: monto (double), personas (int), propina (double)" y lib/domain/resultado.dart: "porPersona (double)", sin formato ni persistencia.
- [ ] T009 [US1] Implementar lib/data/redondeo_exacto.dart y lib/data/redondeo_hacia_arriba.dart contra EstrategiaRedondeo: centavos y entero superior, sin formato de texto.
- [ ] T010 [US1] Implementar ValidarEntrada en lib/domain/validar_entrada.dart: "finitud, no negatividad, personas >= 1 y rango numérico"; mensajes de spec.md; error o null.
- [ ] T011 [US1] Implementar CalcularDivision en lib/domain/calcular_division.dart: fórmula y delegación a estrategia, sin validación, formato, casts ni tipos concretos.
- [ ] T012 [US1] Implementar lib/presentation/divisor_controller.dart: dependencias abstractas por constructor, parseo, normalizar propina vacía/espacios a cero, validar antes de calcular y devolver resultado/error mutuamente excluyentes.
- [ ] T013 [US1] Implementar lib/presentation/formateador_moneda.dart: solo convertir pago numérico a texto de dos decimales.
- [ ] T014 [US1] Implementar lib/presentation/pantalla_divisor.dart: campos, selector, botón, pago/error, setState y liberación de controladores; "Recalcular con error borra el pago previo".
- [ ] T015 [US1] Componer servicios y estrategias en lib/main.dart, eliminar la prueba obsoleta del contador test/widget_test.dart una vez sustituida por test/pantalla_test.dart, y ejecutar pruebas hasta cumplir US1.

## Phase 4: Verificación transversal
- [ ] T016 Revisar lib/ y registrar en .specify/verificacion.md: dependencias presentation -> domain <- data, domain sin Flutter, instancias concretas solo en main, cinco principios SOLID, ausencia de red/persistencia/secretos y explicación de cada función.
- [ ] T017 Ejecutar flutter test --reporter expanded, flutter analyze y flutter build apk --debug; guardar resultados reales en .specify/verificacion.md y comprobar .specify/quickstart.md.
- [ ] T018 Medir archivos/líneas Dart de lib/, documentar correcciones reales y actualizar bitacora.md y el estado de .specify/tasks.md sin inventar tiempos ni pruebas.

## Dependencies & Execution Order
T001 -> T002 -> T003 -> T004..T007 -> T008..T015 -> T016..T018.
T002 crea firmas que pueden referirse a las entidades pendientes de T008; no se exige
compilación en esa etapa. T007 registra la fase roja, incluidos errores por archivos
todavía ausentes. T008 completa las entidades antes de implementar los servicios.
T004 depende de T003. T005 y T006 pueden redactarse independientemente tras fijar contratos;
se ejecutarán secuencialmente con el mismo agente. No se solicita delegación.
T009 y T013 pueden desarrollarse independientemente una vez disponibles sus contratos.
Cada implementación se comprueba con sus tests; no se alteran expectativas para ocultar errores.

## Implementation Strategy
MVP único: US1 (13 tareas, T003–T015). No hay otras historias.
Primero contratos y pruebas; luego entidades, estrategias, validación, cálculo, coordinación,
formato, pantalla y composición; finalizar con verificación y métricas.
Marcar tareas solo al ejecutarlas y guardar evidencia. Una prueba de extensión no añade
un tercer modo al producto.
