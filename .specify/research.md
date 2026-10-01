# Decisiones del diseño
- Decisión: Flutter y setState. Motivo: elección confirmada por el estudiante para una
  sola pantalla. Alternativa: gestor externo, innecesario para el alcance.
- Decisión: contratos y estrategias inyectadas. Motivo: arquitectura limpia y SOLID
  exigidos. Alternativa: condicional por tipos en cálculo, incompatible con OCP/LSP.
- Decisión: propina vacía es cero. Motivo: respuesta real del estudiante; sustituye
  la propuesta anterior de mostrar error. Texto no vacío inválido sigue siendo error.
- Decisión: usar flutter_test del SDK para pruebas de dominio y widgets.
  No agregar otro runner; distinguir dominio independiente de Flutter de infraestructura de tests.
- No quedan incógnitas tecnológicas: stack, alcance y restricciones ya fueron fijados
  por la práctica y confirmados. No se requiere investigación externa ni otro agente.
