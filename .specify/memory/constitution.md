# App divisor de cuentas Constitution

## Core Principles

### I. SRP — responsabilidad única
Cada clase tiene una razón de cambio. El cálculo no valida entradas ni formatea texto.
La validación, el cálculo y la presentación del resultado se mantienen separados.

### II. OCP — extensión del redondeo
Agregar una nueva regla de redondeo no obliga a modificar las clases de cálculo existentes.
El cálculo utiliza el contrato EstrategiaRedondeo.

### III. LSP — sustitución
Cualquier implementación de EstrategiaRedondeo puede sustituir a otra.
El consumidor no usa casts ni comprobaciones de tipo para escoger el comportamiento.

### IV. ISP — interfaces pequeñas
EstrategiaRedondeo expone solo la operación necesaria para redondear.
Ningún consumidor depende de métodos que no necesita.

### V. DIP — inversión de dependencias
presentation depende de contratos de domain, nunca de implementaciones concretas de data.
Las dependencias se reciben por constructor y se conectan en main.dart.

## Arquitectura limpia y seguridad

- Estructura: lib/presentation, lib/domain y lib/data.
- Dirección de dependencias: presentation -> domain <- data.
- domain contiene entidades, casos de uso e interfaces; no importa package:flutter,
  presentation ni data.
- data implementa las estrategias definidas por domain. Esta capa no implica agregar
  una base de datos ni acceso a red.
- presentation contiene pantalla y coordinación; no contiene la fórmula del reparto.
- lib/main.dart es el punto de composición de dependencias de producción.
  Las estrategias concretas solo se instancian allí dentro de lib/.
  Los tests pueden instanciar estrategias para verificar sus contratos.
- Nunca guardar secretos ni API keys en el repositorio.

## Calidad, pruebas y explicación del código

- Toda funcionalidad crítica tiene pruebas.
- Los criterios de aceptación se convierten en pruebas ejecutables.
- Toda función debe poder explicarse: qué hace, por qué existe, qué recibe,
  qué devuelve y qué errores produce.
- Verificar las dependencias mediante lectura de imports y búsquedas en lib/.
- Verificar sustitución y cálculo con pruebas; las búsquedas por sí solas no demuestran SOLID.

## Governance

Primera constitución de la reconstrucción interactiva, acordada con el estudiante.
Registra las reglas de la práctica y su requisito explícito de arquitectura limpia.
Los cambios de reglas se documentan antes de implementar el código afectado.
La revisión de plan, tareas e implementación comprueba estas reglas.
La versión distingue cambios incompatibles (mayor), ampliaciones (menor) y
correcciones de redacción (parche).

**Version**: 1.0.0 | **Ratified**: 2026-10-01 | **Last Amended**: 2026-10-01
