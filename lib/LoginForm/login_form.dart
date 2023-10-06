import 'package:flutter/material.dart';
import 'register_form.dart'; // Importa la pantalla de registro

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _email = '';
  String? _password = '';

  void _submitForm() {
  if (_formKey.currentState?.validate() ?? false) {
    // Realizar la autenticación aquí (por ejemplo, enviar datos a un servidor).
    print('Email: $_email');
    print('Password: $_password');
  }
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Container(decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/background.jpg'), // Ruta a tu imagen en assets
          fit: BoxFit.cover, // Ajusta la imagen para cubrir todo el contenedor
        ),
      ),
    child: Center(
      child: FractionallySizedBox(
        widthFactor: 2 / 3, // 2/3 del ancho de la pantalla
        child: ListView(
          shrinkWrap: true,
            children: <Widget>[
              // Campos de formulario
              Container(
              width: 300,
              child : TextFormField(
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
                onPressed: () {
                  if (_formKey.currentState != null &&
                      _formKey.currentState!.validate()) {
                    _submitForm();
                  }
                },
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
    );
  }
}
