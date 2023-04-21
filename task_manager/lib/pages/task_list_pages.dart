import 'package:flutter/material.dart';
import 'package:task_manager/models/task.dart';
import 'package:task_manager/pages/task_create_page.dart';
import 'package:task_manager/pages/task_detail_page.dart';

class TaskListPage extends StatefulWidget {
  final List<Task> tasks;

  TaskListPage({required this.tasks});

  @override
  _TaskListPageState createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  void _navigateToTaskFormPage() async {
    final newTask = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TaskFormPage()),
    );
    if (newTask != null) {
      setState(() {
        widget.tasks.add(newTask);
      });
    }
  }

  // void _navigateToTaskDetailPage(Task task) {

  // Navigator.push(
  //   context,
  //   MaterialPageRoute(builder: (context) => TaskDetailPage(task: task)),
  // );
  // }

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
                if (task != null) {
                  _navigateToTaskDetailPage(task);
                } else {
                  // adicionar uma mensagem de erro ou tratamento aqui
                }
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
      body: SingleChildScrollView(
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
          rows: rows,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
