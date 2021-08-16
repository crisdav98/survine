import 'package:flutter/material.dart';

class CurrentLeccionesProvider extends ChangeNotifier {
  String _nombre;
  String _descripcion;
  String _urlVideo;
  Map _leccion;

  String get nombre => _nombre;
  set nombre(String value) {
    _nombre = value;
    notifyListeners();
  }

  String get descripcion => _descripcion;
  set descripcion(String value) {
    _descripcion = value;
    notifyListeners();
  }

  String get urlVideo => _urlVideo;
  set urlVideo(String value) {
    _urlVideo = value;
    notifyListeners();
  }

  Map get leccion => _leccion;
  set leccion(Map value) {
    _leccion = value;
    notifyListeners();
  }
}
