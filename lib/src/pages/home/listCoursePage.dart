import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:survine/src/providers/cursoProvider.dart';
import 'package:survine/src/widgets/cardCourse.dart';

class ListCoursePage extends StatefulWidget {
  @override
  _ListCoursePageState createState() => _ListCoursePageState();
}

class _ListCoursePageState extends State<ListCoursePage> {
  List<Map> course = [
    {
      "urlImg":
          "https://aprendefacil.com.ec/wp-content/uploads/2020/10/Dropbox-logo-300x214.jpg",
      "titulo": "Curso - Dropbox",
      "progreso": 25
    },
    {
      "urlImg":
          "https://www.marketing4food.com/wp-content/uploads/2020/03/man-computer-filling-online-questionnaire-form-survey-vector-flat-concept-feedback-questionnaire-online-survey-report-illustration_53562-6152.jpg",
      "titulo": "Crear cuestionarios en kahoot",
      "progreso": 0
    },
    // {
    //   "urlImg":
    //       "https://cursosoferta.online/wp-content/uploads/2021/01/convierte-mas-con-facebook-ads-2020-vilma-nunez_6003a95cb7bd5.jpeg",
    //   "titulo": "",
    //   "progreso": 75
    // },
  ];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _course = Provider.of<CursoProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey[200],
          child: Column(
            children: [
              // HEADER
              SizedBox(
                height: 20.0,
              ),
              // BODY
              ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: course.length,
                  itemBuilder: (context, i) {
                    return CardCourse(
                      course: course,
                      size: size,
                      i: i,
                      progress: i == 0
                          ? _course.progresoDropbox
                          : _course.progresoKahoot,
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
