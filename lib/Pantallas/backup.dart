
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VotacionesPage extends StatelessWidget {
  VotacionesPage({super.key});
  FirebaseFirestore instance = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    final banda = instance.collection('Bandas').snapshots();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Votaciones'),
        ),
        body: StreamBuilder(
          stream: banda,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final listaBanda = snapshot.data!.docs;

              return ListView.builder(
                  itemCount: listaBanda.length,
                  itemBuilder: (context, index) {
                    final banda = listaBanda[index];
                    final foto = banda['Portada'];
                    var listTile = ListTile(
                      title: Text(banda['nombre']),
                      subtitle: Column(
                        children: [
                          Text(banda['album']),
                          Text(banda['anioLanzamiento']),
                        ],
                      ),
                      leading: foto == ""
                          ? const Icon(Icons.no_photography)
                          : CachedNetworkImage(
                              imageUrl: foto!,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.no_photography),
                            ),
                      trailing: Text(banda['votos'].toString()),
                      onTap: () async {
                        if (banda['Portada'] == "") {
                          return;
                        }
                        final votos = banda['votos'] + 1;
                        await instance
                            .collection('Bandas')
                            .doc(banda.id)
                            .update({'votos': votos});
                      },
                    );
                    return listTile;
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

