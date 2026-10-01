# Participación semana 7: Vibe coding y SDD

**Estudiante:** Sebastián Rosero  
**Curso:** Programación Asistida de Aplicaciones  
**Fecha:** 2026-10-01

## 1. Métricas, contexto y decisiones

| Métrica | rama vibe | rama sdd |
|---|---|---|
| Iteraciones adicionales | No reproducible de forma fiel en esta ejecución automatizada. | No reproducible de forma fiel en esta ejecución automatizada. |
| Casos de aceptación que cumple (0–6) | 6/6 mediante pruebas de interfaz | 6/6 en dominio e interfaz |
| Pruebas automatizadas que pasan | 6 propias; suite SDD incompatible | 16 |
| Archivos Dart en lib/ | 1 | 11 |
| Líneas de código Dart en lib/ | 145 | 319 |
| ¿domain/ depende de Flutter? | No existe domain/; cálculo acoplado al widget Flutter | No |
| ¿Existe separación presentation/domain/data? | No | Sí |
| ¿El agente agregó algo que nadie pidió? | Decisiones menores: coma decimal y validación de límites; sin nuevas funciones de producto | Mismas decisiones menores, documentadas; pruebas adicionales justificadas |
| ¿Se puede agregar otra estrategia sin modificar el cálculo existente? | No: se modifica _calcular | Sí: implementar EstrategiaRedondeo y registrarla en main |

| Métrica secundaria | rama vibe | rama sdd |
|---|---:|---:|
| Tiempo aproximado hasta cumplir los seis escenarios | No registrado | No registrado |

Conteo real con (Get-ChildItem lib -Recurse -Filter *.dart).Count y
(Get-ChildItem lib -Recurse -Filter *.dart | Get-Content).Count. Las líneas incluyen
comentarios y espacios; más líneas no demuestran por sí solas mayor calidad.

Agente: Codex, identificado en esta sesión como basado en GPT-6. El identificador exacto
del modelo servido y el nivel de razonamiento no están disponibles como datos verificables;
no se inventan. No cambié voluntariamente de agente/modelo/configuración ni usé subagentes.
El entorno de permisos cambió durante la ejecución, lo que interrumpió Git temporalmente.
Archivo de instrucciones de SDD: AGENTS.md. Vibe no tiene ese archivo.

Caso Git A: la carpeta Flutter existía, pero git status y git rev-parse --show-toplevel
respondieron "not a git repository". Se inicializó Git en esa misma carpeta, sin clonar
ni reemplazar el proyecto. Se conservó la plantilla de contador en main; se corrigió
el nombre del paquete a app_divisor_de_cuentas y se quitó cupertino_icons sin uso.

Ambas ramas nacieron de 660c5b9336d24239e455aff48c87906b8376b5da.
git merge-base vibe sdd devolvió exactamente ese hash.

Cumplimiento funcional: empate 6/6. SDD proporciona contratos sustituibles, documentación
y más pruebas. Esta ejecución no permite concluir causalmente que SDD siempre sea mejor:
el encargo maestro ya expuso todos los requisitos al mismo agente. Vibe es una
reconstrucción sencilla, no un ensayo ciego con contexto aislado.

En SDD fueron explícitos los errores, redondeos, capas, inyección, SOLID y pruebas.
En vibe el agente decidió organizar todo en un widget con estado, validar antes del
cálculo y formatear ahí mismo. Coma decimal, rechazo de negativos/no finitos y valores
iniciales de 2 personas y 0% fueron decisiones menores del agente.
Las correcciones internas y comandos no se cuentan como mensajes de iteración del alumno.
Los mensajes operativos sobre permisos y continuación tampoco constituyen una comparación
fiel de iteraciones de desarrollo. No se midió tiempo hasta cumplir los escenarios.

## 2. Reutilización de pruebas y comportamiento

Se ejecutaron realmente:
```powershell
git checkout vibe
git checkout sdd -- test/
flutter test --reporter expanded
git restore --source=HEAD --staged --worktree test/
flutter test --reporter expanded
```

Primer error del compilador (la terminal partió la última frase en dos líneas):
```text
test/division_test.dart:2:8: Error: Error when reading 'lib/data/redondeo_exacto.dart': The system cannot find the path specified
```

No compiló la suite importada: vibe no tiene esos archivos, clases ni crearAplicacion().
Esto demuestra incompatibilidad de arquitectura y puntos de prueba, no que su pantalla
calcule mal. Para reutilizar el dominio habría que extraer validación/cálculo y adaptar
sus contratos; las pruebas de interfaz pueden adaptarse al punto de entrada de vibe.

Se usó comprobación equivalente automatizada de la interfaz (testWidgets), no una
ejecución manual fingida en teléfono. Después de restaurar test/, los seis tests propios
pasaron: "00:04 +6: All tests passed!".

| Caso | Entradas | Resultado vibe | Resultado sdd |
|---|---|---|---|
| 1 | 100, 4, 10%, exacto | 27.50 | 27.50 |
| 2 | 90, 3, 0%, exacto | 30.00 | 30.00 |
| 3 | 50, 0, 0%, exacto | Debe haber al menos una persona; sin pago | Igual |
| 4 | abc, 4, 0%, exacto | Monto inválido; sin pago | Igual |
| 5 | 10, 3, 0%, exacto | 3.33 | 3.33 |
| 6 | 10, 3, 0%, arriba | 4.00 | 4.00 |

SDD: 6 tests de dominio + 1 LSP + 6 de interfaz + 1 de resultado obsoleto +
1 de límites + 1 OCP = 16. La tercera estrategia existe solo en test, no en la app.
El dominio es Dart puro; el runner de pruebas usa flutter_test del SDK, por lo que
no se afirma haber ejecutado dart test sin Flutter.

## 3. Evidencia SOLID

Comandos PowerShell ejecutados en sdd:
```powershell
Get-ChildItem lib/domain -Filter *.dart | Select-String 'package:flutter'
Get-ChildItem lib -Recurse -Filter *.dart | Select-String 'RedondeoExacto\(\)|RedondeoHaciaArriba\(\)'
Select-String -Path lib/domain/calcular_division.dart -Pattern 'is Redondeo|as Redondeo'
Select-String -Path lib/domain/calcular_division.dart -Pattern 'toStringAsFixed|inválido|al menos una persona'
```

Resultados: primera búsqueda vacía; segunda solo:
```text
lib\main.dart:21:      'Exacto': RedondeoExacto(),
lib\main.dart:22:      'Hacia arriba': RedondeoHaciaArriba(),
```
Tercera y cuarta búsquedas vacías. presentation no importa data; recibe contratos
ValidadorEntrada, CalculadorDivision y EstrategiaRedondeo.

En vibe, Get-ChildItem lib -Recurse mostró solo main.dart.
Select-String sobre ese archivo encontró:
```text
1: import 'package:flutter/material.dart';
40: _error = 'Monto inválido';
48: _error = 'Monto inválido';
50: _resultado = (_arriba ? pago.ceilToDouble() : pago).toStringAsFixed(
```

| Regla | SDD | Vibe |
|---|---|---|
| SRP | ValidarEntrada valida; CalcularDivision calcula; FormateadorMoneda formatea | _calcular valida, calcula, formatea y cambia estado |
| OCP | Nueva estrategia se agrega sin tocar el caso de uso; probado con múltiplo de 5 | Se debe modificar el condicional del cálculo |
| LSP | El mismo caso de uso recibe ambas estrategias en un bucle sin casts | No hay contrato de estrategia; no se puede demostrar esa sustitución |
| ISP | EstrategiaRedondeo tiene un único método | No hay interfaz equivalente; no aplica esa comprobación |
| DIP | Dependencia hacia abstracciones de domain; main compone | Lógica ligada al estado del widget; sin inyección |
| Capas | presentation -> domain <- data | Solo main.dart |

La ausencia de coincidencias en un archivo inexistente no se cuenta como cumplimiento
de SOLID en vibe. Las búsquedas son evidencia estructural, complementada por lectura y
tests; no constituyen una prueba universal de todos los principios.

## 4. Clarificaciones y uso real de Spec Kit

No fueron necesarias preguntas funcionales adicionales. Inputs, dos redondeos, mensajes
y escenarios ya estaban definidos. La pregunta por la ruta del proyecto fue operativa.
En vibe las decisiones de estructura y detalles menores fueron del agente; el encargo
maestro ya incluía los comportamientos evaluados.

Se instaló specify-cli 1.0.13 y se ejecutó:
```text
specify init . --integration codex --script ps --non-interactive --force --ignore-agent-tools
```
La CLI instaló plantillas, scripts y skills reales en .agents/skills/.
Codex leyó las skills y redactó los artefactos siguiendo ese flujo; no se fingió ejecutar
slash commands. La integración instalada usa $speckit-*.
Se ejecutaron resolve-template, check-prerequisites, setup-plan y setup-tasks.
Hay 16 tareas numeradas. El análisis previo resolvió el alcance de composición en lib/
frente a fixtures y la distinción dominio puro / runner Flutter.
La revisión posterior de convergencia no encontró nuevas funciones pendientes.
Los artefactos y su procedencia están en .specify/ de sdd.

## 5. Diferencias y mantenibilidad

git diff vibe sdd --stat se guardó completo en evidencia/diff-stat.txt:
**60 files changed, 5610 insertions(+), 195 deletions(-)** en las versiones comparadas
dd87a4e y 92fc101. La mayoría de las líneas adicionales procede del andamiaje real de
Spec Kit, sus skills y plantillas; no son miles de líneas de aplicación.
Las actualizaciones posteriores de documentación pueden cambiar el total del diff.

No se agregó login, historial, base de datos ni una pantalla adicional. Sí se incluyeron
detalles no especificados literalmente: coma decimal, límites inválidos y pruebas
adicionales de regresión/OCP. Se justifican en el alcance y están documentados.
Los archivos multiplataforma del contador pertenecen a la base existente, no a funciones
nuevas introducidas en sdd o vibe.

Para retomar SDD en dos semanas o incorporar un compañero, compartiría AGENTS.md,
constitution, spec, plan, tasks y pruebas. Vibe se lee rápido por ser pequeño, pero
sus reglas están implícitas en el widget. Para agregar redondeo al múltiplo de 5,
en SDD crearía una implementación de EstrategiaRedondeo y la registraría en main;
no tocaría CalcularDivision. En vibe editaría el cálculo y el selector.

## 6. OpenSpec y cuándo elegir vibe

Spec Kit ofrece herramientas, plantillas y flujos de trabajo con especificación,
planificación y tareas. OpenSpec organiza propuestas de cambios con requisitos,
diseño, tareas y archivado, y declara un enfoque iterativo aplicable a proyectos
existentes. Lo preferiría para pequeños cambios sucesivos en una aplicación ya creada,
si el equipo busca ese flujo alrededor de cambios. Es una preferencia contextual,
no una afirmación de superioridad.
Fuentes oficiales consultadas:
[GitHub Spec Kit](https://github.com/github/spec-kit) y
[OpenSpec](https://github.com/Fission-AI/OpenSpec).

Vibe sería razonable para un prototipo pequeño y descartable, con requisitos simples
y bajo costo de mantenimiento, por ejemplo una pantalla para probar una idea de reparto.
Aun entonces comprobaría los casos básicos.

## Entrega y limitaciones

main conserva la aplicación base y añade esta respuesta, bitácora y evidencia.
vibe y sdd conservan sus implementaciones independientes.
No se probó manualmente en un teléfono físico ni se midieron tiempos comparables.
La evidencia registra ejecuciones reales; los errores temporales de permisos no se
confunden con fallos de las pruebas de la app.
