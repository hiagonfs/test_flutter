import 'package:flutter/material.dart';
import 'package:task_manager/models/task.dart';
import 'package:task_manager/pages/task_create_page.dart';
import 'package:task_manager/pages/task_detail_page.dart';

class TaskListPage extends StatefulWidget {
  final List<Task> tasks;
  final String user;

  TaskListPage({required this.tasks, required this.user});

  @override
  _TaskListPageState createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  List<DataRow> _rows = [];

  void _navigateToTaskFormPage() async {
    final newTask = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TaskFormPage(user: widget.user)),
    );
    if (newTask != null) {
      setState(() {
        widget.tasks.add(newTask);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _createRows();
  }

  void _createRows() {
    // Ordena as tarefas por data de abertura
    widget.tasks.sort((a, b) => b.dataAbertura.compareTo(a.dataAbertura));

    _rows = widget.tasks
        .map((task) => DataRow(cells: [
              DataCell(Text('${task.numero}'), onTap: () {
                _navigateToTaskDetailPage(task);
              }),
              DataCell(Text(task.titulo)),
              DataCell(Text(task.tipo)),
              DataCell(Text(task.prioridade)),
              DataCell(Text('${task.dataAbertura}')),
              DataCell(Text(task.responsavel)),
            ]))
        .toList();
  }

  void _navigateToTaskDetailPage(Task task) {
    if (task != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TaskDetailPage(task: task)),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Erro'),
          content: Text('Tarefa inválida'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Ordena as tarefas por data de abertura
    widget.tasks.sort((a, b) => b.dataAbertura.compareTo(a.dataAbertura));

    List<DataRow> rows = widget.tasks
        .map((task) => DataRow(cells: [
              DataCell(Text('${task.numero}'), onTap: () {
                _navigateToTaskDetailPage(task);
              }),
              DataCell(Text(task.titulo)),
              DataCell(Text(task.tipo)),
              DataCell(Text(task.prioridade)),
              DataCell(Text('${task.dataAbertura}')),
              DataCell(Text(task.responsavel)),
            ]))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Tarefas'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _navigateToTaskFormPage();
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: [
              DataColumn(label: Text('Número')),
              DataColumn(label: Text('Título')),
              DataColumn(label: Text('Tipo')),
              DataColumn(label: Text('Prioridade')),
              DataColumn(label: Text('Data')),
              DataColumn(label: Text('Responsável')),
            ],
            rows: _rows,
          ),
        ),
      ),
    );
  }
}
