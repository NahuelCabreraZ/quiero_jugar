import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiero_jugar/home_page.dart'; // Ajusta el nombre de tu proyecto
import 'package:quiero_jugar/LoginForm/login_form.dart';
import 'api_service.dart';
import 'home_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(
    BlocProvider(
      create: (context) => HomeBloc(dataService: DataService()),
      child: MyApp(),
    ),
  );
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
