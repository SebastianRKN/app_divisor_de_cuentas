import 'package:flutter/material.dart';

import 'divisor_controller.dart';
import 'formateador_moneda.dart';

class PantallaDivisor extends StatefulWidget {
  const PantallaDivisor({
    super.key,
    required this.controller,
    required this.formateador,
  });
  final DivisorController controller;
  final FormateadorMoneda formateador;

  @override
  State<PantallaDivisor> createState() => _PantallaDivisorState();
}

class _PantallaDivisorState extends State<PantallaDivisor> {
  final _monto = TextEditingController();
  final _personas = TextEditingController(text: '2');
  final _propina = TextEditingController(text: '0');
  String _modo = 'Exacto';
  String? _resultado;
  String? _error;

  /// Lee campos, delega y actualiza la vista; sin retorno ni excepciones esperadas.
  void _calcular() {
    final respuesta = widget.controller.calcular(
      monto: _monto.text,
      personas: _personas.text,
      propina: _propina.text,
      modo: _modo,
    );
    setState(() {
      _error = respuesta.error;
      final resultado = respuesta.resultado;
      _resultado = resultado == null
          ? null
          : widget.formateador.formatear(resultado.porPersona);
    });
  }

  /// Libera controladores al retirar la pantalla; no recibe datos ni devuelve valor.
  @override
  void dispose() {
    _monto.dispose();
    _personas.dispose();
    _propina.dispose();
    super.dispose();
  }

  /// Dibuja una pantalla desplazable para admitir teclado y pantallas pequeñas.
  /// Recibe el contexto Flutter y devuelve widgets, sin cálculo de negocio.
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Divisor de cuenta')),
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Divide la cuenta',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text('Incluye la propina y elige cómo redondear.'),
                const SizedBox(height: 24),
                TextField(
                  key: const Key('monto'),
                  controller: _monto,
                  decoration: const InputDecoration(
                    labelText: 'Monto total',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  key: const Key('personas'),
                  controller: _personas,
                  decoration: const InputDecoration(
                    labelText: 'Personas',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                TextField(
                  key: const Key('propina'),
                  controller: _propina,
                  decoration: const InputDecoration(
                    labelText: 'Propina (%)',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: _modo,
                  decoration: const InputDecoration(
                    labelText: 'Redondeo',
                    border: OutlineInputBorder(),
                  ),
                  items: [
                    for (final modo in widget.controller.modos)
                      DropdownMenuItem(value: modo, child: Text(modo)),
                  ],
                  onChanged: (modo) => setState(() {
                    _modo = modo ?? _modo;
                    _resultado = null;
                    _error = null;
                  }),
                ),
                const SizedBox(height: 20),
                FilledButton(
                  onPressed: _calcular,
                  child: const Text('Calcular'),
                ),
                const SizedBox(height: 20),
                if (_error != null)
                  Text(
                    _error!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                if (_resultado != null) ...[
                  const Text('Por persona', textAlign: TextAlign.center),
                  Text(
                    _resultado!,
                    key: const Key('resultado'),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
