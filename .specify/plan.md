# Implementation Plan: Dividir una cuenta
**Branch**: sdd-interactivo | **Date**: 2026-10-01 | **Spec**: [spec.md](spec.md)

## Summary
Una pantalla Flutter, arquitectura limpia y estado local con setState.
La propina vacía o compuesta solo de espacios equivale a 0%, según el estudiante.

## Technical Context
- Flutter estable 3.47.1 y Dart 3.13.1, versiones verificadas en esta sesión.
- Dependencias: Flutter; flutter_test y flutter_lints de la base. Sin nuevos paquetes.
- Plataforma de entrega: Android; sin almacenamiento ni conexiones de red.
- Una pantalla y cálculo local; no se inventan objetivos numéricos de rendimiento.
- Null safety, nombres en español, sin cambios innecesarios en android/ o ios/.

## Constitution Check
Revisión previa y posterior al diseño: conforme.
- SRP: validar, calcular y formatear son responsabilidades separadas.
- OCP: una tercera estrategia requiere nueva implementación y registro en main,
  sin editar CalcularDivision.
- LSP: las estrategias se usan mediante su contrato, sin casts ni consultas de tipo.
- ISP: EstrategiaRedondeo tiene un método.
- DIP: controller recibe contratos de cálculo y validación de domain.
- domain no importa Flutter, data ni presentation.
- main compone las dependencias de producción; fixtures pueden crearlas en tests.
- Sin secretos; criterios críticos convertidos en pruebas.

## Project Structure

### Documentation (this feature)
.specify/ contiene spec.md, clarifications.md, plan.md, research.md,
data-model.md, contracts/interfaz.md y quickstart.md.
tasks.md y analyze.md se crearán en las siguientes etapas.

### Source Code (repository root)
| Archivo | Responsabilidad |
|---|---|
| lib/domain/cuenta.dart | Entidad inmutable: monto, personas, propina |
| lib/domain/resultado.dart | Pago numérico por persona |
| lib/domain/estrategia_redondeo.dart | Contrato redondear(double) |
| lib/domain/validar_entrada.dart | Contrato ValidadorEntrada y ValidarEntrada; error o null |
| lib/domain/calcular_division.dart | Contrato CalculadorDivision y CalcularDivision; fórmula y estrategia |
| lib/data/redondeo_exacto.dart | Redondear a centavos sin formatear texto |
| lib/data/redondeo_hacia_arriba.dart | Redondear al entero superior |
| lib/presentation/divisor_controller.dart | Parsear entradas, validar y coordinar el caso de uso |
| lib/presentation/formateador_moneda.dart | Convertir pago a texto con dos decimales |
| lib/presentation/pantalla_divisor.dart | Dibujar campos y resultado; estado local con setState |
| lib/main.dart | Crear e inyectar dependencias y arrancar la aplicación |

Dependencias: presentation -> domain <- data.
data contiene estrategias por la estructura pedida en la práctica; no se crearán
repositorios de persistencia ni bases de datos para justificar una capa.

## Flujo y errores
1. La pantalla envía textos y el modo al controller al tocar Calcular.
2. El controller recorta espacios; propina vacía se convierte en 0 antes de parsear.
   Acepta punto o coma decimal sin separadores de miles.
3. El validador comprueba monto/propina finitos y no negativos, personas entero positivo
   y rango numérico suficiente para cálculo y redondeo. Devuelve los mensajes de spec.
4. Solo con entrada válida se ejecuta CalcularDivision con EstrategiaRedondeo.
5. El formateador produce dos decimales; la pantalla muestra pago o error, nunca ambos.
   Un error al recalcular elimina cualquier pago anterior.
6. Los controladores de texto se liberan al retirar el widget.

CalcularDivision recibe Cuenta validada y una estrategia por contrato. No valida,
no formatea, no conoce widgets. La misma instancia puede usar distintas estrategias.
La selección se realiza con un registro inyectado en main, no mediante tipos concretos
en el cálculo. Las entidades pueden construirse donde se necesitan como datos;
la regla de composición se aplica a servicios y estrategias de producción.

## Pruebas previstas
- test/casos_de_prueba.dart conserva exactamente los seis casos obligatorios.
- test/division_test.dart recorre esos casos, valida primero, compara closeTo(esperado, 0.001)
  e incluye LSP con la misma instancia del cálculo.
- test/pantalla_test.dart verifica los seis escenarios mediante entradas y botón Calcular,
  además de propina vacía/espacios (100, 4 -> 25.00) y eliminación de resultado tras error.
- Tests de controller demuestran que no se llama al cálculo ante un error.
- Una estrategia de prueba al múltiplo de 5 demuestra extensión sin editar el cálculo.
- Pruebas de límites: negativos, no finitos, personas fraccionarias y texto inválido.
- flutter_test se usa como runner existente; domain sigue siendo Dart puro.
  No se afirmará haber ejecutado pruebas sin SDK Flutter si no se hizo.

## Verificación
flutter pub get, flutter test --reporter expanded, flutter analyze y flutter build apk --debug.
Buscar imports de Flutter en domain, instancias concretas fuera de main y casts/formato
en CalcularDivision. Medir archivos y líneas reales al concluir.
Este documento es un plan: no certifica resultados de la implementación nueva.
