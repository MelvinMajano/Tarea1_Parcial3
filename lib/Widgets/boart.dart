
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Board extends StatelessWidget {
  const Board({
  super.key,
  required this.titulo,
  this.ontap,
  required this.foto, 
  required this.nombreAlbum,
  required this.anio, 
  required this.votos});

  
  final String titulo;
  final String nombreAlbum;
  final String anio;
  final String votos;
  final Function? ontap;
  final String foto;

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: ontap as void Function()?,
      child: Container(
          
         decoration: BoxDecoration(
              image:  DecorationImage(
                image: NetworkImage(foto),
                fit: BoxFit.cover,
              ),
                borderRadius: BorderRadius.circular(20),
                color: Colors.blueGrey,
              ),
              height: 180,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(right: 20, left: 20),
              child: FittedBox(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SingleChildScrollView(
                          child: Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(titulo, 
                          style: const TextStyle(fontSize: 30, color: Colors.white), 
                          textAlign: TextAlign.start,))),
                        ),
                        SingleChildScrollView(
                          child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(anio, 
                          style: const TextStyle(fontSize: 20, color: Colors.white), 
                          textAlign: TextAlign.start,))),
                        ),
                      ],
                    ),
                    SingleChildScrollView(
                      child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: Text(nombreAlbum, 
                      style: const TextStyle(fontSize: 25, color: Colors.white), 
                      textAlign: TextAlign.start,))),
                    ),
                    const Padding(padding: EdgeInsets.all(10),),
                    SingleChildScrollView(
                      child: Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(votos, 
                      style: const TextStyle(fontSize: 22, color: Colors.white), 
                      textAlign: TextAlign.start,))),
                    ),
                  ],
                ),
              )
      ),
    );
  }
}