import 'package:flutter/material.dart';
import 'package:quiero_jugar/home_page.dart'; // Ajusta el nombre de tu proyecto
import 'package:quiero_jugar/LoginForm/login_form.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(), // Pantalla primaria
        '/login': (context) => LoginForm(), // Pantalla secundaria (Formulario de inicio de sesión)
      },
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: LoginForm(), // Usa la clase LoginForm aquí
      ),
    );
  }
}
