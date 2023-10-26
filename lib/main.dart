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
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(), // Pantalla primaria
        '/login': (context) => const LoginForm(), // Pantalla secundaria (Formulario de inicio de sesión)
      },
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: LoginForm(), // Usa la clase LoginForm aquí
      ),
    );
  }
}
