import 'package:appvotaciones/Widgets/boart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VotacionesPage extends StatelessWidget {
  VotacionesPage({super.key});
  FirebaseFirestore instance = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    final banda = instance.collection('Bandas').snapshots();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 82, 71, 123),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 82, 71, 123),
          title:  const Text('Dala tap a la banda para votar',style: TextStyle(color: Colors.white, fontSize: 20),),
        ),
        body:StreamBuilder(
          stream: banda,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final listaBanda = snapshot.data!.docs;

              return ListView.builder(
                  itemCount: listaBanda.length,
                  itemBuilder: (context, index) {
                    final banda = listaBanda[index];
                    final foto = banda['Portada'];
                       var column = Column(
                      children: [
                        Board(
                        titulo: banda['nombre'],
                        nombreAlbum: 'Album: ${banda['album']}'.toString(),
                        anio: 'Año: ${banda['anioLanzamiento']}'.toString(),
                        votos:'Votos: ${banda['votos']}'.toString(),
                        foto: foto, 
                        ontap: () async {
                          if (banda['Portada'] == "") {
                            return;
                          }
                          final votos = banda['votos'] + 1;
                          await instance
                              .collection('Bandas')
                              .doc(banda.id)
                              .update({'votos': votos});
                        }),
                       const Padding(padding:EdgeInsets.all(20)),
                      ],
                      );
                      return column;
                  });
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
