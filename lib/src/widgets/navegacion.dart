import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'navegacionModel.dart';

class Navegacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<NavegacionModel>(context);
    return SafeArea(
      child: BottomNavigationBar(
          showUnselectedLabels: true,
          elevation: 10.0,
          // backgroundColor: Colors.grey,
          // fixedColor: Colors.blue,
          // unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          onTap: (i) => navegacionModel.paginaActual = i,
          currentIndex: navegacionModel.paginaActual,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                label: 'Mis Cursos',
                // title: Text("ordenes"),
                icon: Icon(Icons.book)),
            BottomNavigationBarItem(
              label: 'Mi perfil',
              // title: Text("Menú"),
              icon: Icon(
                Icons.person,
              ),
            ),
          ]),
    );
  }
}
