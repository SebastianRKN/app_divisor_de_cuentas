class FormateadorMoneda {
  /// Convierte el pago a texto de dos decimales para la pantalla.
  /// Recibe un número validado y no produce errores.
  String formatear(double cantidad) => cantidad.toStringAsFixed(2);
}
