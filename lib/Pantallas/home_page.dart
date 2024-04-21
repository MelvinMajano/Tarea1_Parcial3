import 'dart:io';
import 'package:appvotaciones/Pantallas/Rutas/myroute.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
    final iamgenPortada = storageref
        .child('portadas/${DateTime.now().millisecondsSinceEpoch}$ruta.jpg');
    final uploadTask = await iamgenPortada.putFile(imagen);
    final url = await uploadTask.ref.getDownloadURL();
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 82, 71, 123),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 82, 71, 123),
        ),
        body: Card(
          semanticContainer: true,
          shadowColor: Colors.black,
          elevation: 30,
          margin: const EdgeInsets.all(20),
          child: SingleChildScrollView(
              child: Column(
            children: [
              const Card(
                margin: EdgeInsets.all(15),
                color: Color.fromARGB(255, 82, 71, 123),
                child: Text('  Bandas de rock  ',
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Card(
                      margin: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: nombrecontroler,
                        decoration: const InputDecoration(
                          labelText: 'Ingrese el Nombre',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.all(10)),
                    Card(
                      margin: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: albumcontroler,
                        decoration: const InputDecoration(
                          labelText: 'Ingrese el Album',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.all(10)),
                    Card(
                      margin: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: anioLanzamientocontroler,
                        decoration: const InputDecoration(
                          labelText: 'Ingrese el año de lanzamiento',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.all(10)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            final data = {
                              'nombre': nombrecontroler.text.trim(),
                              'album': albumcontroler.text.trim(),
                              'anioLanzamiento':
                                  anioLanzamientocontroler.text.trim(),
                              'votos': 0,
                              'Portada': url,
                            };

                            if (nombrecontroler.text.trim().isEmpty ||
                                albumcontroler.text.trim().isEmpty ||
                                anioLanzamientocontroler.text.trim().isEmpty) {
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
                          onPressed: () async {
                            ImagePicker picker = ImagePicker();
                            final XFile? image = await picker.pickImage(
                                source: ImageSource.gallery);
                            if (image == null) {
                              return;
                            }
                            url = await subirFoto(image.path);
                            print('=============url=============');
                            print(url);
                          },
                          child: const Row(
                            children: [
                              Text('Subir Foto'),
                              Icon(Icons.add_a_photo_rounded),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Card(
                      margin: const EdgeInsets.all(20),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, MyRoutes.votacionesPage.name);
                        },
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('  ir a votaciones'),
                            Icon(Icons.arrow_forward_ios_rounded)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
        ));
  }
}
