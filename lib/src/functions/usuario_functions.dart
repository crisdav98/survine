import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:survine/src/preferences/preferences.dart';
import 'package:survine/src/providers/cursoProvider.dart';
import 'package:survine/src/providers/leccionesProvider.dart';

class UserFunctions {
  final prefs = PreferenciasUsuario();

  buscarProgreso(String id, CursoProvider cursoProvider) async {
    try {
      final resp =
          await FirebaseFirestore.instance.collection("usuarios").doc(id).get();
      print("===> RESPUESTA AL BUSCAR PROGRESO");
      print(resp.data());
      cursoProvider.progresoDropbox = resp.data()["cursoDrop"];
      cursoProvider.progresoKahoot = resp.data()["cursoKahoot"];
      prefs.dropbox = resp.data()["cursoDrop"];
      prefs.kahoot = resp.data()["cursoKahoot"];
      // return {"user": mAuth.user, "verify": true};
    } catch (e) {
      print("******** CACTH FIND PROGRESS ******");
      print(e);
      // return {"user": null, "verify": false};
    }
  }

  buscarDatosCursoDropbox(
      String idCurso, CurrentLeccionesProvider currentLeccionesProvider) async {
    try {
      final resp = await FirebaseFirestore.instance
          .collection("dropbox")
          .doc(idCurso)
          .get();
      final datos = resp.data();
      print("==> DATOS DE DROPBOX");
      print(datos);
      currentLeccionesProvider.nombre = datos["NombreCapitulo"];
      currentLeccionesProvider.descripcion = datos["descripcion"];
      currentLeccionesProvider.urlVideo = datos["urlVideo"];
    } catch (e) {
      print("===> Error al buscar datos de Curso");
      print(e);
    }
  }

  buscarDatosCursoKahoot(
      String idCurso, CurrentLeccionesProvider currentLeccionesProvider) async {
    try {
      final resp = await FirebaseFirestore.instance
          .collection("kahoot")
          .doc(idCurso)
          .get();
      final datos = resp.data();
      print("==> DATOS DE KAHOOT");
      print(datos);
      currentLeccionesProvider.nombre = datos["NombreCapitulo"];
      currentLeccionesProvider.descripcion = datos["descripcion"];
      currentLeccionesProvider.urlVideo = datos["urlVideo"];
    } catch (e) {
      print("===> Error al buscar datos de Curso");
      print(e);
    }
  }

  buscarLeccionesKahoot(String idCurso, String idLeccion,
      CurrentLeccionesProvider currentLeccionesProvider) async {
    try {
      final resp = await FirebaseFirestore.instance
          .collection("kahoot")
          .doc(idCurso)
          .collection("leccion")
          .doc(idLeccion)
          .get();
      final datos = resp.data();
      currentLeccionesProvider.leccion = datos;
    } catch (e) {
      print("===> Error al buscar Lecciones de Curso");
      print(e);
    }
  }

  buscarLeccionesDropbox(String idCurso, String idLeccion,
      CurrentLeccionesProvider currentLeccionesProvider) async {
    try {
      final resp = await FirebaseFirestore.instance
          .collection("dropbox")
          .doc(idCurso)
          .collection("leccion")
          .doc(idLeccion)
          .get();
      final datos = resp.data();
      currentLeccionesProvider.leccion = datos;
    } catch (e) {
      print("===> Error al buscar Lecciones de Curso");
      print(e);
    }
  }

  finalizarCursoDropbox(String idUser, CursoProvider cursoProvider) async {
    try {
      await FirebaseFirestore.instance
          .collection("usuarios")
          .doc(idUser)
          .update({"cursoDrop": 100});
      cursoProvider.progresoDropbox = 100;
    } catch (e) {
      print("===> Error al finalizar curso de dropbox");
      print(e);
    }
  }

  finalizarCursoKahoot(String idUser, CursoProvider cursoProvider) async {
    try {
      await FirebaseFirestore.instance
          .collection("usuarios")
          .doc(idUser)
          .update({"cursoKahoot": 100});
      cursoProvider.progresoKahoot = 100;
    } catch (e) {
      print("===> Error al finalizar curso de dropbox");
      print(e);
    }
  }
}
