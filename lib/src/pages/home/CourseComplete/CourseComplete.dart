import 'package:flutter/material.dart';

class CompletePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Container(
            child: Column(
              children: [
                Icon(
                  Icons.check_circle_outline,
                  color: Colors.green,
                  size: 120.0,
                ),
                Container(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Text("¡Felicidades!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                      )),
                ),
                Container(
                  padding: EdgeInsets.only(
                      top: 10.0, left: 30.0, right: 30.0, bottom: 40.0),
                  child: Text(
                    "Has completado con éxito el curso. Recuerda que puedes volver y ver el curso cuando lo necesites.",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 22.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                MaterialButton(
                    color: Colors.blue[700],
                    textColor: Colors.white,
                    child: Text("Volver al inicio"),
                    minWidth: 250.0,
                    shape: StadiumBorder(),
                    elevation: 0.0,
                    onPressed: () =>
                        Navigator.pushReplacementNamed(context, "home"))
              ],
            ),
          ),
        )
      ],
    ));
  }
}
