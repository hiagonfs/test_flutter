import 'package:flutter/material.dart';
import 'package:task_manager/pages/task_list_pages.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(labelText: 'E-mail'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor, digite seu e-mail';
                }
                return null;
              },
              onSaved: (value) {
                _email = value!;
              },
            ),
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
            ElevatedButton(
              child: Text('Entrar'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  // Implementar a lógica de autenticação aqui
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => TaskListPage()),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
