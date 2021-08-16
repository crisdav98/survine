import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:survine/src/pages/home/listCoursePage.dart';
import 'package:survine/src/pages/home/profile.dart';

import 'navegacionModel.dart';

class Paginas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<NavegacionModel>(context);
    return PageView(
      controller: navegacionModel.pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        ListCoursePage(),
        ProfilePage(),
      ],
    );
  }
}
