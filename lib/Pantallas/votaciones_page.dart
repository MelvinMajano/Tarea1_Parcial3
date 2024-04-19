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
        builder: (context, snapshot ){
          if(snapshot.hasData){
            final listaBanda =snapshot.data!.docs;

            return ListView.builder(
              itemCount: listaBanda.length,
              itemBuilder: (context, index) {
                
                final banda = listaBanda[index];
                
                
                return ListTile(
                  title: Text(banda['nombre']),
                  subtitle: Column(
                    children: [
                      Text(banda['album']),
                      Text(banda['anioLanzamiento']),
                    ],
                  ),
                  trailing: Text(banda['votos'].toString()),
                  onTap: () async{
                    final votos = banda['votos'] + 1;
                    await instance.collection('Bandas').doc(banda.id).update({'votos': votos});
                  },
                );
              }
            );
          }
          else{
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
        )
    );
  }
}