import 'package:flutter/material.dart';
import 'package:survine/src/functions/authentication_functions.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _rePasswordController = TextEditingController();
  bool _obscureText = true;
  bool _obscureText2 = true;
  bool _cargando = false;
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
                    "Registrate Gratis",
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
                    _inputRePass(size),
                    _spaceHeight(20),
                    _btnLogin(size),
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

  Widget _spaceHeight(double space) {
    return SizedBox(
      height: space,
    );
  }

  contentBox(context, String title, String description) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 20, top: 65, right: 20, bottom: 20),
          margin: EdgeInsets.only(top: 45),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                description,
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
          left: 20,
          right: 20,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 45,
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(45)),
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
      onPressed: () async {
        if (_passwordController.text == _rePasswordController.text) {
          //  TODO: Registrar usuario
          setState(() {
            _cargando = true;
          });
          final result = await AuthUser()
              .registerUser(_emailController.text, _passwordController.text);
          if (result["verify"]) {
            Navigator.pushReplacementNamed(context, "home");
          } else {
            _errorAlert('Error', 'Hubo un error al registrarse');
          }
          setState(() {
            _cargando = false;
          });
        } else {
          _errorAlert('Error', 'Las contraseñas no son iguales.');
          setState(() {
            _cargando = false;
          });
        }
      },
      minWidth: double.infinity,
      child: (_cargando)
          ? CircularProgressIndicator(
              backgroundColor: Colors.white,
              strokeWidth: 2.0,
            )
          : Text(
              "Registrarse",
              style:
                  TextStyle(color: Colors.white, fontSize: size.width * 0.04),
            ),
    );
  }

  Future _errorAlert(String title, String description) {
    return showDialog(
        builder: (context) => Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: contentBox(context, title, description),
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

  Container _inputRePass(Size size) {
    return Container(
      margin: EdgeInsets.only(top: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Repite la contraseña",
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
            obscureText: _obscureText2,
            keyboardType: TextInputType.emailAddress,
            controller: _rePasswordController,
            decoration: InputDecoration(
                suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _obscureText2 = !_obscureText2;
                      });
                    },
                    child: (_obscureText2)
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
