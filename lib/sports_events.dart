import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'info_card_model.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

//Logica para agregar imagen a firebase storage, y agregar url a la collection

Future<void> addSportsEventToFirestore(InfoCardModel infoCard, String imagePath) async {
  // Subir la imagen a Firebase Storage
  Reference storageReference = FirebaseStorage.instance.ref().child('event_images/${DateTime.now().toString()}');
  File file = File(imagePath);
  UploadTask uploadTask = storageReference.putFile(file);
  await uploadTask;

  // Obtener la URL de la imagen subida
  String imageUrl = await storageReference.getDownloadURL();

  // Agregar la información del evento junto con la URL de la imagen a Firestore
  FirebaseFirestore.instance
      .collection('eventosDeportivos')
      .add({
        'title': infoCard.title,
        'description': infoCard.description,
        'imageUrl': imageUrl,
        'likes': infoCard.likes,
        'location': infoCard.location,
        // Agrega otros campos según sea necesario
      })
      .then((value) => print('Evento deportivo agregado correctamente'))
      .catchError((error) => print('Error al agregar el evento: $error'));
}



class SportsEventForm extends StatefulWidget {
  @override
  _SportsEventFormState createState() => _SportsEventFormState();
}

class _SportsEventFormState extends State<SportsEventForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  String _imagePath = ''; // Esto debe ser el path de la imagen seleccionada

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Crear evento deportivo'),
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Título',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa un título';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Descripción'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa una descripción';
                }
                return null;
              },
            ),
            // Agrega más campos TextFormField según sea necesario
            TextFormField(
              controller: _locationController,
              decoration: InputDecoration(labelText: 'Ubicación'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa una ubicación';
                }
                return null;
              },
            ),
            TextButton(
              onPressed: () async {
                final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

                if (pickedFile != null) {
                  final imagePath = pickedFile.path;
                  addSportsEventToFirestore(
                    InfoCardModel(
                      title: _titleController.text,
                      description: _descriptionController.text,
                      location: _locationController.text,
                    ),
                    imagePath,
                  );
                  } else {
                    addSportsEventToFirestore(
                      InfoCardModel(
                        title: _titleController.text,
                        description: _descriptionController.text,
                        location: _locationController.text,
                      ),
                      _imagePath='', // Pasar null si no hay ninguna imagen seleccionada
                    );
                   }
                  },
                     child: Text('Subir imagen'),
                        ),
            // Asegúrate de ajustar los controladores y la lógica de validación para cada campo según sea necesario
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Si el formulario es válido, se llama a la función de agregar evento
                  addSportsEventToFirestore(
                    InfoCardModel(
                      title: _titleController.text,
                      description: _descriptionController.text,
                      likes: 0,
                      location: _locationController.text,
                    ),
                    _imagePath,
                  );
                }
              },
              child: Text('Agregar evento'),
            ),
          ],
        ),
      ),
    ),
  );
}
}