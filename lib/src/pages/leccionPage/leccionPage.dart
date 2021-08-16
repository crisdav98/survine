import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:survine/src/functions/usuario_functions.dart';
import 'package:survine/src/preferences/preferences.dart';
import 'package:survine/src/providers/cursoProvider.dart';
import 'package:survine/src/providers/leccionesProvider.dart';

class LeccionPage extends StatefulWidget {
  @override
  _LeccionPageState createState() => _LeccionPageState();
}

class _LeccionPageState extends State<LeccionPage> {
  CurrentLeccionesProvider _currentLeccionesProvider;
  final userFunctions = UserFunctions();
  final prefs = PreferenciasUsuario();
  String group = "";
  String group2 = "";
  String group3 = "";
  String group4 = "";
  String group5 = "";

  @override
  void initState() {
    _currentLeccionesProvider =
        Provider.of<CurrentLeccionesProvider>(context, listen: false);
    print("===> Leccion de curso");
    print(_currentLeccionesProvider.leccion);
    super.initState();
  }

  Future _errorAlert(int respuestas) {
    return showDialog(
        builder: (context) => Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Constants.padding),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: contentBox(context, respuestas),
            ),
        context: context);
  }

  contentBox(context, respuestas) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
              left: Constants.padding,
              top: Constants.avatarRadius + Constants.padding,
              right: Constants.padding,
              bottom: Constants.padding),
          margin: EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(Constants.padding),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "Calificación insuficiente",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "No has alcanzado la calificación suficiente.\nCalificación: $respuestas/5",
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Aceptar",
                      style: TextStyle(fontSize: 14),
                    )),
              ),
            ],
          ),
        ), // bottom part
        Positioned(
          left: Constants.padding,
          right: Constants.padding,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: Constants.avatarRadius,
            child: ClipRRect(
                borderRadius:
                    BorderRadius.all(Radius.circular(Constants.avatarRadius)),
                child: Icon(
                  Icons.error,
                  color: Colors.red,
                  size: 70.0,
                )),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments;
    final _courseProvider = Provider.of<CursoProvider>(context);
    verificarRespuestas() async {
      int numRespuesta = 0;
      // PREGUNTA 1
      if (_currentLeccionesProvider.leccion["pregunta1"]["respuestaCorrecta"] ==
          group) {
        print("==> PREGUNTA 1 OK");
        numRespuesta += 1;
      }
      // PREGUNTA 2
      if (_currentLeccionesProvider.leccion["pregunta2"]["respuestaCorrecta"] ==
          group2) {
        print("==> PREGUNTA 2 OK");
        numRespuesta += 1;
      }
      // PREGUNTA 3
      if (_currentLeccionesProvider.leccion["pregunta3"]["respuestaCorrecta"] ==
          group3) {
        print("==> PREGUNTA 3 OK");
        numRespuesta += 1;
      }
      // PREGUNTA 4
      if (_currentLeccionesProvider.leccion["pregunta4"]["respuestaCorrecta"] ==
          group4) {
        print("==> PREGUNTA 4 OK");
        numRespuesta += 1;
      }
      // PREGUNTA 5
      if (_currentLeccionesProvider.leccion["pregunta5"]["respuestaCorrecta"] ==
          group5) {
        print("==> PREGUNTA 5 OK");
        numRespuesta += 1;
      }
      print("====> NUMERO DE RESPUESTAS CORRECTAS");
      print(numRespuesta);
      if (numRespuesta == 5) {
        final resp = json.decode(prefs.user);
        print("====> DATOS DEL USUARIO");
        print(resp["userId"]);
        print("===> ARGUMENTOS");
        print(arguments);
        if (arguments["id"] == 0) {
          await userFunctions.finalizarCursoDropbox(
              resp["userId"], _courseProvider);
        } else {
          await userFunctions.finalizarCursoKahoot(
              resp["userId"], _courseProvider);
        }
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, "complete");
      } else {
        _errorAlert(numRespuesta);
      }
    }

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 25.0, bottom: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      "Evaluación del curso",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 25.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    padding:
                        EdgeInsets.only(bottom: 30.0, left: 15.0, right: 15.0),
                    child: Text(
                      "Recuerda que necesitas tener un porcentaje de acierto del 100% para parobar el curso",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                          color: Colors.blue[800]),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _currentLeccionesProvider.leccion.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      String key = _currentLeccionesProvider.leccion.keys
                          .elementAt(index);
                      return Container(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${index + 1}.- ${_currentLeccionesProvider.leccion[key]["nombre"]}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16.0),
                            ),
                            ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: _currentLeccionesProvider
                                    .leccion[key]["opciones"].length,
                                shrinkWrap: true,
                                itemBuilder: (context, i) {
                                  final value = _currentLeccionesProvider
                                      .leccion[key]["opciones"][i];
                                  return ListTile(
                                    title: Text(value),
                                    leading: Radio(
                                        value: i == 0
                                            ? "a"
                                            : i == 1
                                                ? "b"
                                                : i == 2
                                                    ? "c"
                                                    : i == 3
                                                        ? "d"
                                                        : "e",
                                        groupValue: index == 0
                                            ? group
                                            : index == 1
                                                ? group5
                                                : index == 2
                                                    ? group4
                                                    : index == 3
                                                        ? group3
                                                        : group2,
                                        onChanged: (value) {
                                          print(value);
                                          setState(() {
                                            if (index == 0) {
                                              group = value;
                                            } else {
                                              if (index == 1) {
                                                group5 = value;
                                              } else {
                                                if (index == 2) {
                                                  group4 = value;
                                                } else {
                                                  if (index == 3) {
                                                    group3 = value;
                                                  } else {
                                                    group2 = value;
                                                  }
                                                }
                                              }
                                            }
                                          });
                                        }),
                                  );
                                })
                          ],
                        ),
                      );
                    }),
                SizedBox(
                  height: 30.0,
                ),
                Center(
                  child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width * 0.88,
                      shape: StadiumBorder(),
                      color: Colors.blue[700],
                      textColor: Colors.white,
                      child: Text("Finalizar"),
                      onPressed: () {
                        presentarDialogo();
                        verificarRespuestas();
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  presentarDialogo() {
    showDialog(
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              content: Container(
                padding: EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 25,
                      width: 25,
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.indigo[900]),
                        strokeWidth: 2,
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Text(
                      "Comprobando respuestas...",
                      style: TextStyle(),
                    )
                  ],
                ),
              ),
            ),
        context: context);
  }
}

class Constants {
  Constants._();
  static const double padding = 20;
  static const double avatarRadius = 45;
}
