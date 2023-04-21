import 'package:flutter/material.dart';
import 'package:task_manager/models/task.dart';
import 'package:task_manager/pages/task_list_pages.dart';
import 'package:task_manager/models/task_manager.dart';

class TaskFormPage extends StatefulWidget {
  @override
  _TaskFormPageState createState() => _TaskFormPageState();
}

class _TaskFormPageState extends State<TaskFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _typeValue = 'Incidente';
  String _priorityValue = 'Alta';
  TaskManager _taskManager = TaskManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Tarefa'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Título *'),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Por favor, digite um título';
                }
                return null;
              },
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: _typeValue,
              decoration: InputDecoration(labelText: 'Tipo'),
              items: [
                'Incidente',
                'Solicitação de Serviço',
                'Melhoria',
                'Projetos'
              ]
                  .map((type) => DropdownMenuItem(
                        value: type,
                        child: Text(type),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _typeValue = value!;
                });
              },
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: _priorityValue,
              decoration: InputDecoration(labelText: 'Prioridade'),
              items: ['Alta', 'Média', 'Baixa', 'Sem prioridade']
                  .map((priority) => DropdownMenuItem(
                        value: priority,
                        child: Text(priority),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _priorityValue = value!;
                });
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _descriptionController,
              maxLines: 5,
              decoration: InputDecoration(labelText: 'Descrição'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('Salvar'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final task = Task.criar(
                      titulo: _titleController.text,
                      tipo: _typeValue,
                      prioridade: _priorityValue,
                      descricao: _descriptionController.text,
                      responsavel: 'Nome do responsável',
                      status: 'Nova');
                  _taskManager.addTask(task);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            TaskListPage(tasks: _taskManager.getTasks())),
                  );
                }
              },
            ),
            ElevatedButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
