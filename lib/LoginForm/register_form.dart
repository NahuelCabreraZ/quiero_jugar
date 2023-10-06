import 'package:flutter/material.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _repeatPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
      ),
       body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/backgroundregistro.jpg'), // Ruta de tu imagen de fondo
            fit: BoxFit.cover, // Ajusta la imagen para que cubra toda la pantalla
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Opacity(
            opacity: 0.9, // Ajusta la opacidad según tus preferencias
            child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              SizedBox(height: 20.0),
              Container(
              child: TextFormField(
                style: TextStyle(fontSize: 16.0),
                decoration: InputDecoration(
                  labelText: 'Nombre Completo',
                  labelStyle: TextStyle(fontSize: 18.0), // Personaliza el estilo de la etiqueta
                  border: OutlineInputBorder(),
                  filled: true, // Activa el fondo lleno
                  fillColor: Colors.white.withOpacity(0.7)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa tu nombre completo';
                  }
                  return null;
                },
              ),
              ),
              SizedBox(height: 20.0),
              Container(
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(fontSize: 18.0), // Personaliza el estilo de la etiqueta
                  border: OutlineInputBorder(),
                  filled: true, // Activa el fondo lleno
                  fillColor: Colors.white.withOpacity(0.7)),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa tu dirección de email';
                  }
                  // Puedes agregar más validación de email si es necesario
                  return null;
                },
              ),
              ),
              SizedBox(height: 20.0),
              Container(
              child: TextFormField(
                decoration: InputDecoration(labelText: 'Contraseña',
                border: OutlineInputBorder(),
                filled: true, // Activa el fondo lleno
                fillColor: Colors.white.withOpacity(0.7)),
                obscureText: true,
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa tu contraseña';
                  }
                  return null;
                },
              ),
              ),
              SizedBox(height: 20.0),
              Container(
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Repetir Contraseña',
                  border: OutlineInputBorder(),
                  filled: true, // Activa el fondo lleno
                fillColor: Colors.white.withOpacity(0.7)),
                obscureText: true,
                controller: _repeatPasswordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, repite tu contraseña';
                  }
                  if (value != _passwordController.text) {
                    return 'Las contraseñas no coinciden';
                  }
                  return null;
                },
              ),
              ),
              SizedBox(height: 20.0),
              Container(
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Edad',
                  labelStyle: TextStyle(fontSize: 18.0), // Personaliza el estilo de la etiqueta
                  border: OutlineInputBorder(),
                  filled: true, // Activa el fondo lleno
                  fillColor: Colors.white.withOpacity(0.7)),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa tu edad';
                  }
                  // Puedes agregar más validación de edad si es necesario
                  return null;
                },
              ),
              ),
              SizedBox(height: 20.0),
              Container(
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Ubicación',
                  labelStyle: TextStyle(fontSize: 18.0), // Personaliza el estilo de la etiqueta
                  border: OutlineInputBorder(),
                  filled: true, // Activa el fondo lleno
                  fillColor: Colors.white.withOpacity(0.7)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa tu ubicación';
                  }
                  return null;
                },
              ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState != null &&
                      _formKey.currentState!.validate()) {
                    // Realiza la acción de registro aquí
                    // Puedes acceder a los valores ingresados por el usuario
                    // mediante los controladores de los campos o usando
                    // _formKey.currentState
                  }
                },
                child: Text('Registrarse'),
              ),
            ],
          ),
        ),
      ),
    )
  )
);
  }
}
