import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:survine/src/preferences/preferences.dart';

class ProfilePage extends StatelessWidget {
  final prefs = PreferenciasUsuario();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final user = json.decode(prefs.user);
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        color: Colors.grey[200],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.person,
              size: size.width * 0.45,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "Correo de usuario",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: size.width * 0.045, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "${user["email"]}",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: size.width * 0.045, color: Colors.red),
            ),
            SizedBox(
              height: 25.0,
            ),
            MaterialButton(
              shape: StadiumBorder(),
              onPressed: () => Navigator.pushReplacementNamed(context, "login"),
              color: Colors.red,
              textColor: Colors.white,
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.17, vertical: size.height * 0.015),
              child: Text("Cerrar Sesión"),
            )
          ],
        ),
      ),
    );
  }
}
