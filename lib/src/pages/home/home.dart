import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:survine/src/functions/usuario_functions.dart';
import 'package:survine/src/preferences/preferences.dart';
import 'package:survine/src/providers/cursoProvider.dart';
import 'package:survine/src/widgets/header.dart';
import 'package:survine/src/widgets/navegacion.dart';
import 'package:survine/src/widgets/navegacionModel.dart';
import 'package:survine/src/widgets/paginas.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CursoProvider _cursoProvider;
  final UserFunctions _userFunctions = UserFunctions();
  final prefs = PreferenciasUsuario();
  @override
  void initState() {
    // TODO: implement initState
    _cursoProvider = Provider.of<CursoProvider>(context, listen: false);
    _userFunctions.buscarProgreso(prefs.uid, _cursoProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
        create: (_) => NavegacionModel(),
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: SafeArea(
                child: Scaffold(
                    body: Column(
                      children: [
                        Header(size: size),
                        Expanded(flex: 1, child: Paginas()),
                      ],
                    ),
                    bottomNavigationBar: Navegacion())),
          ),
        ));
  }
}
