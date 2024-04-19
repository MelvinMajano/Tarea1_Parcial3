import 'package:appvotaciones/Pantallas/Rutas/myroute.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final nombrecontroler = TextEditingController();
  final albumcontroler = TextEditingController();
  final anioLanzamientocontroler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body:  SingleChildScrollView(
          child: Column(
            children: [
             const Text('Hello World'),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(  
                      controller: nombrecontroler,
                      decoration: const InputDecoration(
                        labelText: 'Ingrese el Nombre'
                      ),
                    ),
                    TextFormField(
                       controller: albumcontroler,
                      decoration: const InputDecoration(
                        labelText: 'Ingrese el Album'
                      ),
                    ),
                    TextFormField(
                      controller: anioLanzamientocontroler,
                      decoration: const InputDecoration(
                        labelText: 'Ingrese el año de lanzamiento'
                      ),
                    ),                   
                    ElevatedButton(
                      onPressed: () async{
                       
                        final data = {
                          'nombre': nombrecontroler.text ,
                          'album': albumcontroler.text ,
                          'anioLanzamiento': anioLanzamientocontroler.text ,
                          'votos': 0,
                        };

                        final instance = FirebaseFirestore.instance;
                        if(formKey.currentState!.validate()){
                          final respuesta = await instance.collection('Bandas').add(data);
                          print(respuesta);
                        }

                      },
                      child: const Text('Agregar Banda'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, MyRoutes.votacionesPage.name );
                      },
                      child: const Text('ir a votaciones'),
                    )
                  ],
                ),
              )
            ],
          ))
    );
  }
}