import 'package:flutter/material.dart';
import 'register_form.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginForm extends StatefulWidget {
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

        print('El usuario ha iniciado sesión exitosamente: ${userCredential.user!.email}');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Inicio de sesión exitoso'),
            duration: const Duration(seconds: 1),
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
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'), // Ruta a tu imagen en assets
            fit: BoxFit.cover, // Ajusta la imagen para cubrir todo el contenedor
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
                  Container(
                    width: 300,
                    child: TextFormField(
                      controller: _emailController,
                      style: TextStyle(fontSize: 16.0), // Personaliza el tamaño de fuente
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(fontSize: 18.0), // Personaliza el estilo de la etiqueta
                        border: OutlineInputBorder(),
                        filled: true, // Activa el fondo lleno
                        fillColor: Colors.white.withOpacity(0.7), // Color de fondo con transparencia
                        // ...
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    width: 300,
                    child: TextFormField(
                      controller: _passwordController,
                      style: TextStyle(fontSize: 16.0), // Personaliza el tamaño de fuente
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(fontSize: 18.0), // Personaliza el estilo de la etiqueta
                        border: OutlineInputBorder(),
                        filled: true, // Activa el fondo lleno
                        fillColor: Colors.white.withOpacity(0.7), // Color de fondo con transparencia
                        // ...
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () => _submitForm(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Cambia el color de fondo del botón
                      foregroundColor: Colors.white, // Cambia el color del texto del botón
                      elevation: 5, // Cambia la elevación del botón
                    ),
                    child: Text('Iniciar Sesión', style: TextStyle(fontSize: 18.0)),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      // Navega a la pantalla de registro cuando se presione el botón
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterForm()),
                      );
                    },
                    child: Text('Registrarse'),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Volver a la Pantalla Principal
                    },
                    child: Text('Volver a la Pantalla Principal'),
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
