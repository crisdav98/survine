import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:survine/src/providers/cursoProvider.dart';
import 'package:survine/src/providers/leccionesProvider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ContentCoursePage extends StatefulWidget {
  final String title;
  final String idVideo;
  final int id;

  const ContentCoursePage(
      {Key key,
      @required this.title,
      @required this.idVideo,
      @required this.id})
      : super(key: key);

  @override
  _ContentCoursePageState createState() => _ContentCoursePageState();
}

class _ContentCoursePageState extends State<ContentCoursePage> {
  YoutubePlayerController _controller;
  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: widget.idVideo,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
      ),
    );
    super.initState();
  }

  // _con
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _cursoProvider = Provider.of<CurrentLeccionesProvider>(context);
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.grey[200],
          child: Column(
            children: [
              Headermodulo(
                size: size,
                title: widget.id == 0
                    ? "Curso-dropbox"
                    : "Cuestionarios en línea con Kahoot",
              ),
              Container(
                // color: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                height: size.height * 0.7618,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        child: Text(
                          widget.title,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: size.width * 0.05,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700]),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: MaterialButton(
                            elevation: 0,
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.08),
                            shape: StadiumBorder(),
                            color: Colors.grey[500],
                            textColor: Colors.grey[200],
                            child: Text("Módulo"),
                            onPressed: () {}),
                      ),
                      YoutubePlayerBuilder(
                          player: YoutubePlayer(
                            controller: _controller,
                          ),
                          builder: (context, player) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // some widgets
                                player,
                                //some other widgets
                                SizedBox(
                                  height: 15.0,
                                ),

                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "Resúmen del capítulo",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: size.width * 0.05),
                                      ),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      Text(
                                        _cursoProvider.descripcion,
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                            fontSize: size.width * 0.035),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            );
                          }),
                    ],
                  ),
                ),
              ),
              _footerModule(size)
            ],
          ),
        ),
      ),
    );
  }

  Container _footerModule(Size size) {
    final _cursoProvider = Provider.of<CursoProvider>(context);
    return Container(
      decoration: BoxDecoration(color: Colors.grey[200], boxShadow: [
        BoxShadow(
            blurRadius: 1.0,
            color: Colors.grey[300],
            offset: Offset(3, 0),
            spreadRadius: 1.0)
      ]),
      // color: Colors.red,
      height: size.height * 0.08,
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: CircleAvatar(
                backgroundColor: Colors.grey[500],
                child: Icon(
                  Icons.list,
                  color: Colors.white,
                )),
          ),
          SizedBox(
            width: 10.0,
          ),
          MaterialButton(
              elevation: 0,
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
              shape: StadiumBorder(),
              color: Colors.red,
              textColor: Colors.white,
              child: Text(
                "Completar Módulo",
                style: TextStyle(fontSize: size.width * 0.04),
              ),
              onPressed: widget.id == 0
                  ? _cursoProvider.progresoDropbox == 100
                      ? null
                      : () {
                          Navigator.pushNamed(context, "leccion",
                              arguments: {"id": widget.id});
                        }
                  : _cursoProvider.progresoKahoot == 100
                      ? null
                      : () {
                          Navigator.pushNamed(context, "leccion",
                              arguments: {"id": widget.id});
                        }),
          SizedBox(
            width: 10.0,
          ),
          // CircleAvatar(
          //     backgroundColor: Colors.grey[500],
          //     child: Padding(
          //       padding: EdgeInsets.only(left: size.width * 0.02),
          //       child: Icon(
          //         Icons.arrow_back_ios,
          //         color: Colors.white,
          //         size: size.width * 0.05,
          //       ),
          //     )),
          // SizedBox(
          //   width: 10.0,
          // ),
          // CircleAvatar(
          //     backgroundColor: Colors.grey[500],
          //     child: Icon(
          //       Icons.arrow_forward_ios,
          //       color: Colors.white,
          //       size: size.width * 0.05,
          //     )),
        ],
      ),
    );
  }
}

class Headermodulo extends StatelessWidget {
  const Headermodulo({
    Key key,
    @required this.size,
    this.title,
  }) : super(key: key);

  final Size size;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      height: size.height * 0.12,
      width: double.infinity,
      color: Colors.indigo[900],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: size.width * 0.04)),
          Container(
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: size.width * 0.07,
              ),
            ),
          )
        ],
      ),
    );
  }
}
