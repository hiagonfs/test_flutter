import 'dart:math';

class Task {
  late int _numero;
  String titulo;
  String tipo;
  String responsavel;
  String descricao;
  String prioridade;
  DateTime dataAbertura;
  String status;

  int get numero => _numero;

  set numero(int numero) {
    _numero = numero;
  }

  Task({
    required int numero,
    required this.titulo,
    required this.tipo,
    required this.responsavel,
    required this.descricao,
    required this.prioridade,
    required this.dataAbertura,
    required this.status,
  }) : _numero = numero;

  static int _gerarNumeroAleatorio() {
    final random = Random();
    int numeroAleatorio = random.nextInt(999999);
    return numeroAleatorio;
  }

  factory Task.criar(
      {required String titulo,
      required String descricao,
      required String tipo,
      required String prioridade,
      required String responsavel,
      required String status}) {
    return Task(
        numero: _gerarNumeroAleatorio(),
        titulo: titulo,
        descricao: descricao,
        tipo: tipo,
        prioridade: prioridade,
        dataAbertura: DateTime.now(),
        responsavel: responsavel,
        status: status);
  }
}
