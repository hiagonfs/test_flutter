import 'package:flutter/material.dart';
import 'package:task_manager/pages/task_list_pages.dart';
import '../models/task_manager.dart';

// login page
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _user = '';
  String _password = '';

  TaskManager _taskManager = TaskManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        width: double.infinity,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: 'User'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, digite seu user';
                  }
                  return null;
                },
                onSaved: (value) {
                  _user = value!;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Senha'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, digite sua senha';
                  }
                  return null;
                },
                onSaved: (value) {
                  _password = value!;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                child: Text('Entrar'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Implementar a lógica de autenticação aqui
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TaskListPage(
                              tasks: _taskManager.getTasks(), user: _user)),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
