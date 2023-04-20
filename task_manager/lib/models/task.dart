class Task {
  final int numero;
  final String titulo;
  final String tipo;
  final String prioridade;
  final DateTime dataAbertura;
  final String responsavel;

  Task({
    required this.numero,
    required this.titulo,
    required this.tipo,
    required this.prioridade,
    required this.dataAbertura,
    required this.responsavel,
  });
}
