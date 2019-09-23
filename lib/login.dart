import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import 'package:toast/toast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'class/labor_social.dart';
import 'package:upb_app/class/global.dart' as globals;
import 'components/button_login.dart';
import 'request/login.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();

}

class User {
  String email;
  String pasword;
}


class _LoginState extends State<Login> {
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  User _user = User();
  ProgressDialog pr;
  void loginCheck() async {
    pr = new ProgressDialog(context, ProgressDialogType.Normal);
    pr.setMessage("Cargando..");
    pr.show();
    if (_globalKey.currentState.validate()) _globalKey.currentState.save();
    final response = await ApiClient.loginRequest(_user.email, _user.pasword);

    if (response == null) {
      pr.hide();
      showSnackBar("Error Login");
      return;
    }

    if (response['success']) {
      globals.token = response["token"];
      globals.user.token = response["token"];
      globals.user.nombre = response["nombre"];
      globals.user.id = response["id"];
      globals.user.expiration = response["expiration"];
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("token", response["token"]);
      prefs.setString("nombre", response["nombre"]);
      prefs.setString("id", response["id"]);
      prefs.setString("expiration", response["expiration"]);
      pr.hide();
      Navigator.of(context).pushReplacementNamed("/dash");
    }else {
      pr.hide();
      Toast.show(response["message"], context, duration: Toast.LENGTH_SHORT, gravity:  Toast.CENTER);
    }
    print(response);
  }

  void _preLogin() async {
    final prefs = await SharedPreferences.getInstance();
    String fecha = prefs.getString("expiration" ?? "");
    String token = prefs.getString("token" ?? "");
    if(fecha != null && fecha.isNotEmpty){
      DateTime date = DateTime.parse(fecha.substring(0,19));
      DateTime fechaHoy = DateTime.now();
      if(fechaHoy.isBefore(date)){
          globals.token = token;
          globals.user.token = token;
          globals.user.nombre = prefs.getString("nombre");
          globals.user.id = prefs.getString("id");
          globals.user.expiration = prefs.getString("expiration");
          Navigator.of(context).pushReplacementNamed("/dash");
      }
    }else{
      prefs.setString("token", "");
      prefs.setString("nombre", "");
      prefs.setString("id", "");
      prefs.setString("expiration", "");
    }
  }

  void showSnackBar(String texto) {
    final snackBar = SnackBar(
      content: Text(texto),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  String emailValidator(String value) {
    if (value.isEmpty) return "Usuario no valido";

    return null;
  }

  String passwordValidator(String value) {
    if (value.length < 4) return "Contraseña no valida";

    return null;
  }

  @override
  void initState(){
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  dispose(){
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    _preLogin();
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/img/fondo.jpg"),
                    fit: BoxFit.cover)),
          ),
          ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: new BoxDecoration(
                  color: Colors.grey.shade200.withOpacity(
                      0.7) /*Colors.grey.shade200.withOpacity(0.2)*/,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(12.0),
                      topLeft: Radius.circular(12.0)),
                ),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        //CumstonAppBar(title: "Log in"),
                        Container(
                          width: 200,
                          margin: EdgeInsets.only(top: 50,bottom: 50),
                          child: Image.asset("assets/img/upb-logo.png",),
                        ),
                        Form(
                            key: _globalKey,
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  decoration: InputDecoration(
                                      labelText: "Usuario",
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)))),
                                  onSaved: (value) => _user.email = value,
                                  validator: emailValidator,
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        labelText: "Password",
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0)))),
                                    onSaved: (value) => _user.pasword = value,
                                    validator: passwordValidator,
                                    obscureText: true,
                                  ),
                                )
                              ],
                            )),
                        Container(
                          margin: EdgeInsets.only(top: 50),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  child: CumstonButton(
                                      texto: "login",
                                      callback: () => this.loginCheck()))
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Flexible(
                                    child: Divider(
                                      color: Colors.white,
                                    ),
                                  ),
                                  Flexible(
                                    child: Divider(
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

  }
}

class CumstonAppBar extends StatelessWidget {
  final String title;

  CumstonAppBar({@required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(50),
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Text(
          this.title,
          style: TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}
