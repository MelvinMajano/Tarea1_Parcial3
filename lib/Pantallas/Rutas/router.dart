import 'package:appvotaciones/Pantallas/Rutas/homePage.dart';
import 'package:appvotaciones/Pantallas/Rutas/myroute.dart';
import 'package:appvotaciones/Pantallas/votaciones_page.dart';
import 'package:flutter/material.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
 MyRoutes.homePage.name : (context) =>   HomePage(),
 MyRoutes.votacionesPage.name : (context) =>  VotacionesPage(),
};