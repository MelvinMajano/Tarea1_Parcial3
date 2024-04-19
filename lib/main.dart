import 'package:appvotaciones/Pantallas/Rutas/myroute.dart';
import 'package:appvotaciones/Pantallas/Rutas/router.dart';
import 'package:appvotaciones/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
    await  Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
   );
  runApp(const MyApp()); 
} 

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
       initialRoute: MyRoutes.homePage.name ,
       routes: appRoutes,
    );
  }
}

