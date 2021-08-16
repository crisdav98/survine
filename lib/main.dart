import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:survine/src/pages/home/CourseComplete/CourseComplete.dart';
import 'package:survine/src/pages/home/home.dart';
import 'package:survine/src/pages/leccionPage/leccionPage.dart';
import 'package:survine/src/pages/login/loginPage.dart';
import 'package:survine/src/pages/register/registerPage.dart';
import 'package:survine/src/preferences/preferences.dart';
import 'package:survine/src/providers/cursoProvider.dart';
import 'package:survine/src/providers/leccionesProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await Firebase.initializeApp();
  await prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final prefs = PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    final prefs = PreferenciasUsuario();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CursoProvider()),
        ChangeNotifierProvider(create: (_) => CurrentLeccionesProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // Define el Brightness y Colores por defecto
          brightness: Brightness.light,
          primaryColor: Colors.lightBlue[800],
          accentColor: Colors.cyan[600],
          // Define la Familia de fuente por defecto
          fontFamily: 'Montserrat',
        ),
        title: 'Escuela Survine',
        initialRoute: prefs.token == "" ? "login" : "home",
        // initialRoute: "complete",
        routes: {
          "login": (_) => LoginPage(),
          "home": (_) => HomePage(),
          "register": (_) => RegisterPage(),
          "leccion": (_) => LeccionPage(),
          "complete": (_) => CompletePage()
        },
      ),
    );
  }
}
