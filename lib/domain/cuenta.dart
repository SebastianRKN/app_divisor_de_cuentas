/// Datos inmutables de una cuenta; la validación corresponde a ValidarEntrada.
class Cuenta {
  const Cuenta({
    required this.monto,
    required this.personas,
    required this.propina,
  });
  final double monto;
  final int personas;
  final double propina;
}
