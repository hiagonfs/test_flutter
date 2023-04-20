import 'package:flutter/material.dart';
import 'package:task_manager/models/task.dart';
import 'package:task_manager/pages/task_create_page.dart';

class TaskListPage extends StatefulWidget {
  @override
  _TaskListPageState createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  List<Task> _tasks = [];

  void _navigateToTaskFormPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TaskFormPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
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
      body: ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          final task = _tasks[index];
          return ListTile(
            title: Text(task.titulo),
            subtitle: Text('${task.tipo} - ${task.prioridade}'),
            trailing: Text('${task.dataAbertura}'),
          );
        },
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
