import 'package:flutter/material.dart';

class CursoProvider extends ChangeNotifier {
  int _progresoDropbox;
  int _progresoKahoot;

  int get progresoDropbox => _progresoDropbox;
  set progresoDropbox(int value) {
    _progresoDropbox = value;
    notifyListeners();
  }

  int get progresoKahoot => _progresoKahoot;
  set progresoKahoot(int value) {
    _progresoKahoot = value;
    notifyListeners();
  }
}
