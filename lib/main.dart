import 'package:flutter/material.dart';

void main() => runApp(const AplicacionDivisor());

class AplicacionDivisor extends StatelessWidget {
  const AplicacionDivisor({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Divisor de cuenta',
    theme: ThemeData(colorSchemeSeed: Colors.teal, useMaterial3: true),
    home: const PantallaCuenta(),
  );
}

class PantallaCuenta extends StatefulWidget {
  const PantallaCuenta({super.key});

  @override
  State<PantallaCuenta> createState() => _PantallaCuentaState();
}

class _PantallaCuentaState extends State<PantallaCuenta> {
  final _monto = TextEditingController();
  final _personas = TextEditingController(text: '2');
  final _propina = TextEditingController(text: '0');
  bool _arriba = false;
  String? _resultado;
  String? _error;

  void _calcular() {
    final monto = double.tryParse(_monto.text.trim().replaceAll(',', '.'));
    final personas = int.tryParse(_personas.text.trim());
    final propina = double.tryParse(_propina.text.trim().replaceAll(',', '.'));
    setState(() {
      _resultado = null;
      _error = null;
      if (monto == null || !monto.isFinite || monto < 0) {
        _error = 'Monto inválido';
      } else if (personas == null || personas < 1) {
        _error = 'Debe haber al menos una persona';
      } else if (propina == null || !propina.isFinite || propina < 0) {
        _error = 'Propina inválida';
      } else {
        final pago = monto * (1 + propina / 100) / personas;
        if (!pago.isFinite) {
          _error = 'Monto inválido';
        } else {
          _resultado = (_arriba ? pago.ceilToDouble() : pago).toStringAsFixed(
            2,
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _monto.dispose();
    _personas.dispose();
    _propina.dispose();
    super.dispose();
  }

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
                TextField(
                  key: const Key('monto'),
                  controller: _monto,
                  decoration: const InputDecoration(labelText: 'Monto total'),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  key: const Key('personas'),
                  controller: _personas,
                  decoration: const InputDecoration(labelText: 'Personas'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                TextField(
                  key: const Key('propina'),
                  controller: _propina,
                  decoration: const InputDecoration(labelText: 'Propina (%)'),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                ),
                const SizedBox(height: 24),
                DropdownButtonFormField<bool>(
                  initialValue: _arriba,
                  decoration: const InputDecoration(labelText: 'Redondeo'),
                  items: const [
                    DropdownMenuItem(value: false, child: Text('Exacto')),
                    DropdownMenuItem(value: true, child: Text('Hacia arriba')),
                  ],
                  onChanged: (valor) => setState(() {
                    _arriba = valor ?? false;
                    _resultado = null;
                    _error = null;
                  }),
                ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: _calcular,
                  child: const Text('Calcular'),
                ),
                const SizedBox(height: 24),
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
