import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class VotacionesPage extends StatelessWidget {
  VotacionesPage({super.key});

  FirebaseFirestore instance = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 82, 71, 123),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 82, 71, 123),
          title: const Text(
            'Dale tap a la banda para votar',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        body: Container(
          child: Column(
            children: [
              showAgenda(),
            ],
          ),
        ));
  }

  showAgenda() {
    final banda = instance.collection('Bandas').snapshots();
    return StreamBuilder(
        stream: banda,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            final listabanda = snapshot.data!.docs;
            return Expanded(
              child: ListView.builder(
                itemCount: listabanda.length,
                itemBuilder: (BuildContext context, int index) {
                  final banda = listabanda[index];
                  return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      child: SlideAnimation(
                          child: FadeInAnimation(
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.9,
                            padding: const EdgeInsets.all(20),
                            margin: const EdgeInsets.only(
                                top: 20, left: 20, right: 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(banda["Portada"]),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    height: 100,
                                    width: 100,
                                  ),
                                ),
                                Column(
                                  children: [
                                    Text(
                                      banda["nombre"],
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      banda['anioLanzamiento'],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      )));
                },
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
