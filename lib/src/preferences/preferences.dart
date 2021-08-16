import 'package:shared_preferences/shared_preferences.dart';

/*
  Recordar instalar el paquete de:
    shared_preferences:

  Inicializar en el main
    final prefs = new PreferenciasUsuario();
    await prefs.initPrefs();
    
    Recuerden que el main() debe de ser async {...

*/

class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia =
      new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // GET y SET del nombre
  get token {
    return _prefs.getString('token') ?? '';
  }

  set token(String value) {
    _prefs.setString('token', value);
  }

  // GET y SET de admin
  get user {
    return _prefs.getString('user') ?? '';
  }

  set user(String value) {
    _prefs.setString('user', value);
  }

  // GET y SET de UID USER
  get uid {
    return _prefs.getString('uid') ?? '';
  }

  set uid(String value) {
    _prefs.setString('uid', value);
  }

  // GET y SET PROGRESODROPBOX
  get dropbox {
    return _prefs.getInt('dropbox') ?? 0;
  }

  set dropbox(int value) {
    _prefs.setInt('dropbox', value);
  }

  // GET y SET PROGRESO KAHOOT
  get kahoot {
    return _prefs.getInt('kahoot') ?? 0;
  }

  set kahoot(int value) {
    _prefs.setInt('kahoot', value);
  }
}
