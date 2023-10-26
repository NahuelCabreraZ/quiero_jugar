import 'package:flutter/material.dart';
import 'package:quiero_jugar/home_page.dart';
import 'register_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Importa el paquete Cloud Firestore
import 'package:shared_preferences/shared_preferences.dart'; // Importa el paquete Shared Preferences

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _submitForm(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        final userDoc = await FirebaseFirestore.instance
            .collection('usuarios')
            .doc(userCredential.user!.uid)
            .get();

        final fullName = userDoc.data()?['nombreCompleto'];

        Future<String?> _saveNameToLocalStorage(String name) async {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('fullName', name);
          print('Nombre completo guardado: $name');
          return name;
        }

        // Guardar el nombre en el almacenamiento local
        await _saveNameToLocalStorage(fullName);

        print(
            'El usuario ha iniciado sesión exitosamente: ${userCredential.user!.email}');

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Inicio de sesión exitoso'),
            duration: Duration(seconds: 1),
          ),
        );

        await Future.delayed(const Duration(seconds: 2));
        Navigator.pushReplacementNamed(context, '/');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No se encontró ninguna cuenta con este correo electrónico.');
        } else if (e.code == 'wrong-password') {
          print('Contraseña incorrecta.');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/background.jpg'), // Ruta a tu imagen en assets
            fit:
                BoxFit.cover, // Ajusta la imagen para cubrir todo el contenedor
          ),
        ),
        child: Center(
          child: FractionallySizedBox(
            widthFactor: 2 / 3, // 2/3 del ancho de la pantalla
            child: Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  // Campos de formulario
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: _emailController,
                      style: const TextStyle(
                          fontSize: 16.0), // Personaliza el tamaño de fuente
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: const TextStyle(
                            fontSize:
                                18.0), // Personaliza el estilo de la etiqueta
                        border: const OutlineInputBorder(),
                        filled: true, // Activa el fondo lleno
                        fillColor: Colors.white.withOpacity(
                            0.7), // Color de fondo con transparencia
                        // ...
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: _passwordController,
                      style: const TextStyle(
                          fontSize: 16.0), // Personaliza el tamaño de fuente
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: const TextStyle(
                            fontSize:
                                18.0), // Personaliza el estilo de la etiqueta
                        border: const OutlineInputBorder(),
                        filled: true, // Activa el fondo lleno
                        fillColor: Colors.white.withOpacity(
                            0.7), // Color de fondo con transparencia
                        // ...
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () => _submitForm(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.blue, // Cambia el color de fondo del botón
                      foregroundColor:
                          Colors.white, // Cambia el color del texto del botón
                      elevation: 5, // Cambia la elevación del botón
                    ),
                    child: const Text('Iniciar Sesión',
                        style: TextStyle(fontSize: 18.0)),
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      // Navega a la pantalla de registro cuando se presione el botón
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RegisterForm()),
                      );
                    },
                    child: const Text('Registrarse'),
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: ((context) => const HomePage())
                      )); // Volver a la Pantalla Principal
                    },
                    child: const Text('Volver a la Pantalla Principal'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
