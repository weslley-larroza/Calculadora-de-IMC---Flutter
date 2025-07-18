import 'package:flutter/material.dart';
import 'pessoa.dart';

void main() {
  runApp(const IMCApp());
}

class IMCApp extends StatelessWidget {
  const IMCApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de IMC',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const IMCHomePage(),
    );
  }
}

class IMCHomePage extends StatefulWidget {
  const IMCHomePage({super.key});

  @override
  State<IMCHomePage> createState() => _IMCHomePageState();
}

class _IMCHomePageState extends State<IMCHomePage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _pesoController = TextEditingController();
  final _alturaController = TextEditingController();

  String _resultado = '';

  void _calcularIMC() {
    if (_formKey.currentState!.validate()) {
      final nome = _nomeController.text;
      final peso = double.parse(_pesoController.text);
      final altura = double.parse(_alturaController.text);

      final pessoa = Pessoa(nome: nome, peso: peso, altura: altura);
      final imc = pessoa.calcularIMC().toStringAsFixed(2);
      final classificacao = pessoa.classificarIMC();

      setState(() {
        _resultado =
            '$nome tem IMC = $imc\nClassificação: $classificacao';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculadora de IMC')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Digite o nome' : null,
              ),
              TextFormField(
                controller: _pesoController,
                decoration: const InputDecoration(labelText: 'Peso (kg)'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    double.tryParse(value ?? '') == null ? 'Digite o peso válido' : null,
              ),
              TextFormField(
                controller: _alturaController,
                decoration: const InputDecoration(labelText: 'Altura (m)'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    double.tryParse(value ?? '') == null ? 'Digite a altura válida' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _calcularIMC,
                child: const Text('Calcular IMC'),
              ),
              const SizedBox(height: 20),
              Text(
                _resultado,
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
