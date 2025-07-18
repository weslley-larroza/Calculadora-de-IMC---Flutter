import 'package:flutter/material.dart';
import 'pessoa.dart';

class IMC {
  final double peso;
  final double altura;

  IMC({required this.peso, required this.altura});

  double calcular() {
    return peso / (altura * altura);
  }

  @override
  String toString() {
    return 'IMC: ${calcular().toStringAsFixed(2)} (Peso: $peso kg, Altura: $altura m)';
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de IMC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ImcPage(),
    );
  }
}

class ImcPage extends StatefulWidget {
  const ImcPage({super.key});

  @override
  State<ImcPage> createState() => _ImcPageState();
}

class _ImcPageState extends State<ImcPage> {
  final TextEditingController _pesoController = TextEditingController();
  final TextEditingController _alturaController = TextEditingController();
  final List<IMC> _resultados = [];

  void _calcularIMC() {
    try {
      final double peso = double.parse(_pesoController.text);
      final double altura = double.parse(_alturaController.text);

      final imc = IMC(peso: peso, altura: altura);
      setState(() {
        _resultados.insert(0, imc); // insere no início da lista
      });

      _pesoController.clear();
      _alturaController.clear();
    } catch (e) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Erro'),
          content: const Text('Por favor, insira valores numéricos válidos.'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de IMC'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _pesoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Peso (kg)'),
            ),
            TextField(
              controller: _alturaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Altura (m)'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _calcularIMC,
              child: const Text('Calcular IMC'),
            ),
            const SizedBox(height: 24),
            const Text('Resultados:', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: _resultados.length,
                itemBuilder: (context, index) {
                  final imc = _resultados[index];
                  return ListTile(
                    leading: const Icon(Icons.monitor_weight),
                    title: Text(imc.toString()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
