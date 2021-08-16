import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final String _email = "test@test.com";
  final String _pass = "123456";
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              _spaceHeight(size.height * 0.2),
              // Logo
              Center(
                child: Container(
                    width: double.infinity,
                    // width: size.width * 0.65,
                    // child: Image.asset("assets/logoCmas.png"),
                    child: Text(
                      "Survine",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: size.width * 0.15,
                          shadows: [
                            Shadow(
                              color: Colors.black,
                              blurRadius: 9.0,
                            )
                          ]),
                    )),
              ),
              // Subtitle Text
              Container(
                margin: EdgeInsets.only(top: 40.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Ingreso de alumnos",
                    style: TextStyle(
                        fontSize: size.width * 0.06,
                        color: Color(0xFF1A237E),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              // Container Texts Fields
              Container(
                margin: EdgeInsets.only(top: 40.0),
                child: Column(
                  children: [
                    // Email
                    _inputEmail(size),
                    // Password
                    _inputPass(size),
                    _spaceHeight(20),
                    // Container(
                    //   width: double.infinity,
                    //   child: ,
                    // ),
                    // _spaceHeight(20),
                    _btnLogin(size),
                    _spaceHeight(20),
                    // login Problems
                    _textRegister(size),
                  ],
                ),
              ),
              _spaceHeight(size.height * 0.12),
              _footerInfo()
            ],
          ),
        ),
      ),
    );
  }

  Row _footerInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Grupo 5",
          style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14.0,
              fontWeight: FontWeight.w600),
        ),
        Text(
          " GP 3.2",
          style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14.0,
              fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Container _textRegister(Size size) {
    return Container(
      child: Align(
        alignment: Alignment.center,
        child: InkWell(
          onTap: () {
            // Navegar a pantalla de registro
            Navigator.pushNamed(context, "register");
          },
          child: Text(
            "¿No tienes cuenta? Registrate.",
            style: TextStyle(
                fontSize: size.width * 0.045,
                color: Color(0xFF1A237E),
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _spaceHeight(double space) {
    return SizedBox(
      height: space,
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
              left: Constants.padding,
              top: Constants.avatarRadius + Constants.padding,
              right: Constants.padding,
              bottom: Constants.padding),
          margin: EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(Constants.padding),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "Datos Incorrectos",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "El e-mail o la contraseña son incorrectos.",
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Aceptar",
                      style: TextStyle(fontSize: 14),
                    )),
              ),
            ],
          ),
        ), // bottom part
        Positioned(
          left: Constants.padding,
          right: Constants.padding,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: Constants.avatarRadius,
            child: ClipRRect(
                borderRadius:
                    BorderRadius.all(Radius.circular(Constants.avatarRadius)),
                child: Icon(
                  Icons.error,
                  color: Colors.red,
                  size: 70.0,
                )),
          ),
        )
      ],
    );
  }

  MaterialButton _btnLogin(Size size) {
    return MaterialButton(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      padding: EdgeInsets.symmetric(vertical: 15.0),
      color: Colors.red[600],
      onPressed: () {
        if (_emailController.text != _email ||
            _passwordController.text != _pass) {
          _errorAlert();
        } else {
          Future.delayed(Duration(seconds: 5), () {
            // REDIRIGIR AL HOME
            Navigator.pushReplacementNamed(context, "home");
          });
          showDialog(
              barrierDismissible: false,
              builder: (context) => AlertDialog(
                    content: Container(
                      padding: EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 25,
                            width: 25,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.indigo[900]),
                              strokeWidth: 2,
                            ),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          Text(
                            "Verificando datos...",
                            style: TextStyle(),
                          )
                        ],
                      ),
                    ),
                  ),
              context: context);
        }
      },
      minWidth: double.infinity,
      child: Text(
        "Ingresar a la escuela",
        style: TextStyle(color: Colors.white, fontSize: size.width * 0.04),
      ),
    );
  }

  Future _errorAlert() {
    return showDialog(
        builder: (context) => Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Constants.padding),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: contentBox(context),
            ),
        context: context);
  }

  Container _inputEmail(Size size) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Correo electrónico",
              style: TextStyle(
                  fontSize: size.width * 0.045,
                  color: Color(0xFF1A237E),
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          TextField(
            keyboardType: TextInputType.emailAddress,
            controller: _emailController,
            decoration: InputDecoration(
                hintText: "E-mail", border: OutlineInputBorder()),
          ),
        ],
      ),
    );
  }

  Container _inputPass(Size size) {
    return Container(
      margin: EdgeInsets.only(top: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Contraseña",
              style: TextStyle(
                  fontSize: size.width * 0.045,
                  color: Color(0xFF1A237E),
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          TextField(
            obscureText: _obscureText,
            keyboardType: TextInputType.emailAddress,
            controller: _passwordController,
            decoration: InputDecoration(
                suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    child: (_obscureText)
                        ? Icon(Icons.visibility)
                        : Icon(Icons.visibility_off)),
                hintText: "Contraseña",
                border: OutlineInputBorder()),
          ),
        ],
      ),
    );
  }
}

class Constants {
  Constants._();
  static const double padding = 20;
  static const double avatarRadius = 45;
}
