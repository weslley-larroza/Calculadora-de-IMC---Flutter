class Pessoa {
  final String nome;
  final double peso;
  final double altura;

  Pessoa({required this.nome, required this.peso, required this.altura});

  double calcularIMC() {
    return peso / (altura * altura);
  }

  String classificarIMC() {
    final imc = calcularIMC();
    if (imc < 18.5) return "Abaixo do peso";
    if (imc < 25) return "Peso normal";
    if (imc < 30) return "Sobrepeso";
    return "Obesidade";
  }
}
