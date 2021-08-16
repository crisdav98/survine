import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:survine/src/preferences/preferences.dart';

class AuthUser {
  final prefs = PreferenciasUsuario();

  registerUser(String email, String pass) async {
    try {
      final mAuth = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: pass);
      // aGREGAR A PROVIDER
      print("==> MAUTH");
      print(mAuth.user);
      final Map userTemp = {
        "email": mAuth.user.email,
        "userId": mAuth.user.uid
      };

      print(prefs.user);
      String token = await FirebaseAuth.instance.currentUser.getIdToken();
      await FirebaseFirestore.instance
          .collection("usuarios")
          .doc(mAuth.user.uid)
          .set({"cursoDrop": 0, "cursoKahoot": 0});
      prefs.token = token;
      prefs.user = json.encode(userTemp);
      prefs.uid = mAuth.user.uid;
      print("====== TOKEN =====");
      print(token);
      return {"user": mAuth.user, "verify": true};
    } catch (e) {
      print("******** CACTH REGISTER USER ******");
      print(e);
      return {"user": null, "verify": false};
    }
  }

  login(String email, String pass) async {
    try {
      final mAuth = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);
      prefs.user = json.encode(mAuth.user);
      prefs.uid = mAuth.user.uid;
      print(prefs.user);
      String token = await FirebaseAuth.instance.currentUser.getIdToken();
      prefs.token = token;
      return {"user": mAuth.user, "verify": true};
    } catch (e) {
      print("******** CACTH LOGIN USER ******");
      print(e);
      return {"user": null, "verify": false};
    }
  }
}
