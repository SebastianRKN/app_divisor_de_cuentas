# Tasks: Divisor de cuenta
Input: spec.md, plan.md, research.md, data-model.md y contracts/interfaz.md.

## Phase 1: Setup
- [x] T001 Verificar proyecto base y dependencias en pubspec.yaml.

## Phase 2: Foundational
- [x] T002 Crear entidades en lib/domain/cuenta.dart y lib/domain/resultado.dart.
- [x] T003 Crear interfaz mínima en lib/domain/estrategia_redondeo.dart.

## Phase 3: User Story 1 (P1) — MVP
Meta: reparto completo. Prueba independiente: seis escenarios de spec.md.
- [x] T004 [US1] Escribir seis datos en test/casos_de_prueba.dart.
- [x] T005 [US1] Escribir pruebas de dominio y LSP en test/division_test.dart.
- [x] T006 [US1] Escribir pruebas de interfaz en test/pantalla_test.dart.
- [x] T007 [US1] Implementar estrategias en lib/data/redondeo_exacto.dart y lib/data/redondeo_hacia_arriba.dart.
- [x] T008 [US1] Implementar validación en lib/domain/validar_entrada.dart.
- [x] T009 [US1] Implementar caso de uso en lib/domain/calcular_division.dart.
- [x] T010 [US1] Implementar coordinación en lib/presentation/divisor_controller.dart.
- [x] T011 [US1] Implementar formato en lib/presentation/formateador_moneda.dart.
- [x] T012 [US1] Implementar pantalla en lib/presentation/pantalla_divisor.dart.
- [x] T013 [US1] Componer dependencias en lib/main.dart.
- [x] T014 [US1] Ejecutar pruebas y límites en test/validacion_test.dart.

## Phase 4: Verificación
- [x] T015 Verificar SOLID y documentar evidencia en .specify/analyze.md.
- [x] T016 Ejecutar análisis final y build APK; completar .specify/tasks.md.

## Dependencies & Execution Order
T001 -> T002/T003 -> T004/T005/T006 (fase roja) -> T007..T013 -> T014..T016.
Las entidades y la interfaz son independientes; estrategias y formato también pueden
desarrollarse por separado. Esta ejecución conserva un solo agente de forma secuencial.
Solo hay una historia; sus once tareas son T004..T014.
MVP: completar US1 y validar antes de medir y comparar ramas.
