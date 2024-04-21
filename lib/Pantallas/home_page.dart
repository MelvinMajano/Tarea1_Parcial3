import 'dart:io';
import 'package:appvotaciones/Pantallas/Rutas/myroute.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final nombrecontroler = TextEditingController();
  final albumcontroler = TextEditingController();
  final anioLanzamientocontroler = TextEditingController();
  final instance = FirebaseFirestore.instance;
  var url = '';
   String ruta = '';

   Future<String> subirFoto(String path) async {
    final storageref = FirebaseStorage.instance.ref();
    final imagen = File(path); 
    final iamgenPortada = storageref.child('portadas/${DateTime.now().millisecondsSinceEpoch}$ruta.jpg');
    final uploadTask = await iamgenPortada.putFile(imagen);
    final url = await uploadTask.ref.getDownloadURL();
    return url;
   }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            const Text('Hello World'),
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: nombrecontroler,
                    decoration:
                        const InputDecoration(labelText: 'Ingrese el Nombre'),
                  ),
                  TextFormField(
                    controller: albumcontroler,
                    decoration:
                        const InputDecoration(labelText: 'Ingrese el Album'),
                  ),
                  TextFormField(
                    controller: anioLanzamientocontroler,
                    decoration: const InputDecoration(
                        labelText: 'Ingrese el año de lanzamiento'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final data = {
                        'nombre': nombrecontroler.text.trim(),
                        'album': albumcontroler.text.trim(),
                        'anioLanzamiento': anioLanzamientocontroler.text.trim(),
                        'votos': 0,
                        'Portada': url,
                      };

                      if(nombrecontroler.text.trim().isEmpty || albumcontroler.text.trim().isEmpty || anioLanzamientocontroler.text.trim().isEmpty ){
                      return;
                    }
                      final respuesta =
                          await instance.collection('Bandas').add(data);
                      print(respuesta);

                      ruta = albumcontroler.text;
                    },
                    child: const Text('Agregar Banda'),
                  ),
                  ElevatedButton(
                    onPressed: () async{
                      ImagePicker picker = ImagePicker();
                      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                      if(image == null){
                        return;
                      }
                      url = await subirFoto(image.path);
                      print('=============url=============');
                      print(url);
                    },
                    child: const Text('Subir Foto'),
                    ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, MyRoutes.votacionesPage.name);
                    },
                    child: const Text('ir a votaciones'),
                  )
                ],
              ),
            )
          ],
        )));
  }
  
}
