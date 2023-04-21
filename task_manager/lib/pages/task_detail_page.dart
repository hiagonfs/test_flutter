import 'package:flutter/material.dart';
import 'package:task_manager/models/task.dart';

class TaskDetailPage extends StatefulWidget {
  final Task task;

  TaskDetailPage({required this.task}) : assert(task.numero != null);

  @override
  _TaskDetailPageState createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  late Task _task;
  late TextEditingController _tituloController;
  late TextEditingController _tipoController;
  late TextEditingController _responsavelController;
  late TextEditingController _descricaoController;
  late TextEditingController _prioridadeController;
  late TextEditingController _dataAberturaController;
  late TextEditingController _numeroController;

  @override
  void initState() {
    super.initState();
    _task = widget.task;
    _tituloController = TextEditingController(text: _task.titulo);
    _tipoController = TextEditingController(text: _task.tipo);
    _responsavelController = TextEditingController(text: _task.responsavel);
    _descricaoController = TextEditingController(text: _task.descricao);
    _prioridadeController = TextEditingController(text: _task.prioridade);
    _dataAberturaController =
        TextEditingController(text: _task.dataAbertura.toString());
    _numeroController = TextEditingController(
        text: _task.numero != null ? _task.numero.toString() : '');
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _tipoController.dispose();
    _responsavelController.dispose();
    _descricaoController.dispose();
    _prioridadeController.dispose();
    _dataAberturaController.dispose();
    _numeroController.dispose();
    super.dispose();
  }

  void _assumirTarefa() {
    setState(() {
      _task.status = "Em andamento";
    });
  }

  void _finalizarTarefa() {
    setState(() {
      _task.status = "Finalizada";
    });
  }

  void _editarTarefa() {
    setState(() {
      _task.titulo = _tituloController.text;
      _task.tipo = _tipoController.text;
      _task.responsavel = _responsavelController.text;
      _task.descricao = _descricaoController.text;
      _task.prioridade = _prioridadeController.text;
      _task.dataAbertura = DateTime.parse(_dataAberturaController.text);
      _task.numero = int.parse(_numeroController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes da Tarefa'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Número: ${_task.numero != null ? _task.numero.toString() : ""}',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Table(
              children: [
                _buildTableRow('Título', _task.titulo, _tituloController),
                _buildTableRow('Tipo', _task.tipo, _tipoController),
                _buildTableRow(
                    'Prioridade', _task.prioridade, _prioridadeController),
                _buildTableRow('Data', _task.dataAbertura.toString(),
                    _dataAberturaController),
                _buildTableRow(
                    'Responsável', _task.responsavel, _responsavelController),
                _buildTableRow(
                    'Descrição', _task.descricao, _descricaoController),
              ],
            ),
            SizedBox(height: 32.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () => _assumirTarefa(),
                  child: Text('Assumir Tarefa'),
                ),
                ElevatedButton(
                  onPressed: () => _finalizarTarefa(),
                  child: Text('Finalizar Tarefa'),
                ),
                ElevatedButton(
                  onPressed: () => _editarTarefa(),
                  child: Text('Editar Tarefa'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ignore: no_leading_underscores_for_local_identifiers
  TableRow _buildTableRow(
      String label, String value, TextEditingController controller) {
    return TableRow(
      children: [
        TableCell(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              label,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        TableCell(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: TextFormField(
              controller: controller,
              initialValue: value,
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Campo obrigatório';
                }
                return null;
              },
            ),
          ),
        ),
      ],
    );
  }
}
