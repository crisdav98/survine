import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:survine/src/functions/usuario_functions.dart';
import 'package:survine/src/pages/course/moduleList.dart';
import 'package:survine/src/providers/leccionesProvider.dart';

class CardCourse extends StatefulWidget {
  const CardCourse(
      {Key key,
      @required this.course,
      @required this.size,
      @required this.i,
      @required this.progress})
      : super(key: key);

  final List<Map> course;
  final Size size;
  final int i;
  final int progress;

  @override
  _CardCourseState createState() => _CardCourseState();
}

class _CardCourseState extends State<CardCourse> {
  @override
  Widget build(BuildContext context) {
    final _userFunctions = UserFunctions();
    final _currentLeccionesProvider =
        Provider.of<CurrentLeccionesProvider>(context);
    return ElasticIn(
      duration: Duration(milliseconds: 1300),
      child: GestureDetector(
        onTap: () async {
          if (widget.i == 0) {
            await _userFunctions.buscarDatosCursoDropbox(
                "O9UkPcwBQbXPI2hmFHck", _currentLeccionesProvider);
          } else {
            await _userFunctions.buscarDatosCursoKahoot(
                "CYia4ePDilTzkfOKQHoK", _currentLeccionesProvider);
          }
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      ModuleListPage(id: widget.i)));
        },
        child: Container(
          decoration: BoxDecoration(boxShadow: <BoxShadow>[
            BoxShadow(
              blurRadius: 1,
              offset: Offset(0, 3),
              spreadRadius: 0.6,
              color: Colors.black.withOpacity(0.1),
            )
          ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
          margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          child: ListTile(
            // dense: true,
            // shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(80)),
            contentPadding: EdgeInsets.only(right: 5.0),
            leading: Container(
              width: 100,
              height: 200,
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.contain,
                image: NetworkImage(widget.course[widget.i]["urlImg"]),
              )),
              // child:
            ),
            title: Container(
              padding: EdgeInsets.only(top: 10.0),
              child: Text(
                widget.course[widget.i]["titulo"],
                style: TextStyle(
                    color: Colors.indigo[900], fontWeight: FontWeight.bold),
              ),
            ),
            subtitle: Container(
              margin: EdgeInsets.only(top: 10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text(
                        "Progreso",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: widget.size.width * 0.033),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        (widget.progress == 0)
                            ? "Sin iniciar"
                            : "${widget.progress}",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: widget.size.width * 0.033),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Flexible(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.grey[300],
                        minHeight: 9.0,
                        value: widget.progress == null
                            ? 0
                            : widget.progress.toDouble() / 100,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Color(0xFFE53935),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
