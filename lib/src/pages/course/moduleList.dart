import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:survine/src/functions/usuario_functions.dart';
import 'package:survine/src/pages/course/contentCourse.dart';
import 'package:survine/src/providers/cursoProvider.dart';
import 'package:survine/src/providers/leccionesProvider.dart';
import 'package:survine/src/widgets/header.dart';

class ModuleListPage extends StatefulWidget {
  final int id;

  const ModuleListPage({Key key, @required this.id}) : super(key: key);

  @override
  _ModuleListPageState createState() => _ModuleListPageState();
}

class _ModuleListPageState extends State<ModuleListPage> {
  CurrentLeccionesProvider _currentLeccionesProvider;
  final _userFunctions = UserFunctions();

  @override
  void initState() {
    _currentLeccionesProvider =
        Provider.of<CurrentLeccionesProvider>(context, listen: false);
    if (widget.id == 0) {
      _userFunctions.buscarLeccionesDropbox("O9UkPcwBQbXPI2hmFHck",
          "IJabUulxKY33wJgN2Mcq", _currentLeccionesProvider);
    } else {
      _userFunctions.buscarLeccionesKahoot("CYia4ePDilTzkfOKQHoK",
          "oFCVtO2HicyptEskcKOS", _currentLeccionesProvider);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // final _currentLeccionesProvider =
    //     Provider.of<CurrentLeccionesProvider>(context);
    final _cursoProgressProvider = Provider.of<CursoProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Container(
            color: Colors.grey[200],
            child: (_currentLeccionesProvider.nombre == null ||
                    _currentLeccionesProvider.urlVideo == null)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                    ],
                  )
                : Column(
                    // mainAxisSize: MainAxisSize.max,
                    children: [
                      Header(size: size),
                      Container(
                        height: size.height * 0.88,
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            // width: double.infinity,
                            child: Column(
                              children: [
                                // PROGRESS
                                Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: LinearProgress(size: size, data: {
                                    "progreso": (widget.id == 0
                                        ? _cursoProgressProvider.progresoDropbox
                                        : _cursoProgressProvider.progresoKahoot)
                                  }),
                                ),
                                // SPACE FOR IMG
                                Container(
                                  height: size.height * 0.3,
                                  child: Image.network(widget.id == 0
                                      ? "https://aprendefacil.com.ec/wp-content/uploads/2020/10/Dropbox-logo-300x214.jpg"
                                      : "https://www.marketing4food.com/wp-content/uploads/2020/03/man-computer-filling-online-questionnaire-form-survey-vector-flat-concept-feedback-questionnaire-online-survey-report-illustration_53562-6152.jpg"),
                                ),

                                SizedBox(
                                  height: 20.0,
                                ),
                                FadeIn(
                                  duration: Duration(milliseconds: 1300),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ContentCoursePage(
                                                    id: widget.id,
                                                    title:
                                                        _currentLeccionesProvider
                                                            .nombre,
                                                    idVideo:
                                                        _currentLeccionesProvider
                                                            .urlVideo,
                                                  )));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        // borderRadius: BorderRadius.circular(10)
                                      ),
                                      margin: EdgeInsets.symmetric(
                                        vertical: 5.0,
                                      ),
                                      child: ListTile(
                                        // dense: true,
                                        // shape: RoundedRectangleBorder(
                                        //     borderRadius: BorderRadius.circular(80)),
                                        contentPadding:
                                            EdgeInsets.only(right: 5.0),
                                        leading: Container(
                                            // padding: EdgeInsets.only(left: 10.0),
                                            width: 50,
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Container(
                                                width: 20,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    border: Border.all(
                                                        width: 2.0,
                                                        color: Colors.grey)),
                                              ),
                                            )),
                                        title: Container(
                                          padding: EdgeInsets.only(top: 10.0),
                                          child: Text(
                                            _currentLeccionesProvider.nombre,
                                            style: TextStyle(
                                                color: Colors.indigo[900],
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        subtitle: Container(
                                          margin: EdgeInsets.only(
                                              top: 10.0, bottom: 10.0),
                                          child: Text(
                                            "Lecciones Completadas: ${widget.id == 0 ? _cursoProgressProvider.progresoDropbox == 100 ? 1 : 0 : _cursoProgressProvider.progresoKahoot == 100 ? 1 : 0} de 1",
                                            style: TextStyle(
                                                color: Colors.grey[500],
                                                fontSize: size.width * 0.033),
                                          ),
                                        ),
                                        trailing: Container(
                                          width: size.width * 0.04,
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Icon(
                                              Icons.arrow_forward_ios,
                                              color: Colors.grey,
                                              size: size.width * 0.04,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                // ListView.builder(
                                //     shrinkWrap: true,
                                //     scrollDirection: Axis.vertical,
                                //     physics: BouncingScrollPhysics(),
                                //     itemCount: listModules.length,
                                //     itemBuilder: (context, i) {
                                //       return CardModule(
                                //         listModules: listModules,
                                //         size: size,
                                //         i: i,
                                //       );
                                //     })
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

// class CardModule extends StatelessWidget {
//   const CardModule({
//     Key key,
//     @required this.listModules,
//     @required this.size,
//     @required this.i,
//   }) : super(key: key);

//   final List listModules;
//   final Size size;
//   final int i;

//   @override
//   Widget build(BuildContext context) {
//     return FadeIn(
//       duration: Duration(milliseconds: 1300),
//       child: GestureDetector(
//         onTap: () {
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => ContentCoursePage(
//                         title: listModules[i]["title"],
//                       )));
//         },
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             // borderRadius: BorderRadius.circular(10)
//           ),
//           margin: EdgeInsets.symmetric(
//             vertical: 5.0,
//           ),
//           child: ListTile(
//             // dense: true,
//             // shape: RoundedRectangleBorder(
//             //     borderRadius: BorderRadius.circular(80)),
//             contentPadding: EdgeInsets.only(right: 5.0),
//             leading: Container(
//                 // padding: EdgeInsets.only(left: 10.0),
//                 width: 50,
//                 child: Align(
//                   alignment: Alignment.center,
//                   child: Container(
//                     width: 20,
//                     height: 20,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(100),
//                         border: Border.all(width: 2.0, color: Colors.grey)),
//                   ),
//                 )),
//             title: Container(
//               padding: EdgeInsets.only(top: 10.0),
//               child: Text(
//                 listModules[i]["title"],
//                 style: TextStyle(
//                     color: Colors.indigo[900], fontWeight: FontWeight.bold),
//               ),
//             ),
//             subtitle: Container(
//               margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
//               child: Text(
//                 "Lecciones Completadas: ${listModules[i]["complete"]} de  ${listModules[i]["total"]}",
//                 style: TextStyle(
//                     color: Colors.grey[500], fontSize: size.width * 0.033),
//               ),
//             ),
//             trailing: Container(
//               width: size.width * 0.04,
//               child: Align(
//                 alignment: Alignment.center,
//                 child: Icon(
//                   Icons.arrow_forward_ios,
//                   color: Colors.grey,
//                   size: size.width * 0.04,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class LinearProgress extends StatelessWidget {
  const LinearProgress({
    Key key,
    @required this.size,
    @required this.data,
  }) : super(key: key);

  final Size size;
  final Map data;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                "Progreso",
                style:
                    TextStyle(color: Colors.grey, fontSize: size.width * 0.033),
              ),
              SizedBox(
                width: 5.0,
              ),
              Text(
                (data["progreso"] == 0) ? "Sin iniciar" : "${data["progreso"]}",
                style:
                    TextStyle(color: Colors.red, fontSize: size.width * 0.033),
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
                value: data["progreso"].toDouble() / 100,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Color(0xFFE53935),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
