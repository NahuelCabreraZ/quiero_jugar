import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {

  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();
  final _ageController = TextEditingController();
  final _locationController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _email;
  String? _password;
  

void _submitForm(BuildContext context) async {
    print('se inicia la funcion');

    if (_formKey.currentState?.validate() ?? false) {
      _email = _emailController.text;
      _password = _passwordController.text;

      if (_password != _repeatPasswordController.text) {
        print('Las contraseñas no coinciden');
        return;
      }

      try {
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: _email!,
          password: _password!,
        );

        await FirebaseFirestore.instance.collection('usuarios').doc(userCredential.user!.uid).set({
          'nombreCompleto': _fullNameController.text,
          'email': _email,
          'edad': _ageController.text,
          'localidad': _locationController.text,
          'contraseña': _passwordController.text,
        });

      print('El usuario ha sido registrado exitosamente: ${userCredential.user!.email}');
      //Mensajito de success
      final snackBar = SnackBar(
        content: Text('Usuario registrado con éxito: ${userCredential.user!.email}'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      //Mensajito de success

      Navigator.pushReplacementNamed(context, '/login');

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('La contraseña proporcionada es demasiado débil.');
      } else if (e.code == 'email-already-in-use') {
        print('Ya existe una cuenta con este correo electrónico.');
      }
    } catch (e) {
      print(e);
    }
  }
}

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
                controller: _fullNameController,
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
                controller: _emailController,
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
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Contraseña',
                border: OutlineInputBorder(),
                filled: true, // Activa el fondo lleno
                fillColor: Colors.white.withOpacity(0.7)),
                obscureText: true,
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
                controller: _repeatPasswordController,
                decoration: InputDecoration(
                  labelText: 'Repetir Contraseña',
                  border: OutlineInputBorder(),
                  filled: true, // Activa el fondo lleno
                fillColor: Colors.white.withOpacity(0.7)),
                obscureText: true,
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
                controller: _ageController,
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
                controller: _locationController,
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
                    onPressed: () => _submitForm(context), // Llama a la función _submitForm al presionar el botón
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
