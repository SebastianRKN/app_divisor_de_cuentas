# App divisor de cuentas Constitution

## Core Principles

### I. SRP
Una clase tiene una razón de cambio. El cálculo no valida ni formatea.

### II. OCP
Agregar una regla de redondeo no obliga a modificar las clases de cálculo existentes.

### III. LSP
Cualquier EstrategiaRedondeo puede sustituir a otra sin casts ni comprobaciones de tipo.

### IV. ISP
Interfaces pequeñas. EstrategiaRedondeo expone solamente una operación necesaria: redondear.

### V. DIP
presentation depende de abstracciones de domain, nunca de implementaciones concretas de data.

## Arquitectura y seguridad
- Capas presentation / domain / data; dependencia presentation -> domain <- data.
- lib/domain/ no importa package:flutter.
- main.dart es el único punto de composición de implementaciones concretas en producción.
- Nunca guardar secretos ni API keys.

## Calidad, pruebas y regla de la materia
- Funcionalidad crítica con pruebas; criterios de aceptación convertidos en pruebas ejecutables.
- Toda función debe poder explicarse: qué hace, por qué existe, qué recibe, qué devuelve y qué errores produce.

## Governance
Esta versión registra las reglas solicitadas, sin principios adicionales.
Las verificaciones se documentan en analyze.md y en la evidencia de la práctica.
La restricción de composición se aplica a lib/; las pruebas crean sus estrategias para verificar LSP.

**Version**: 1.0.0 | **Ratified**: 2026-10-01 | **Last Amended**: 2026-10-01
