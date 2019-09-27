import 'package:flutter/material.dart';

import 'dash.dart';
import 'login.dart';
import 'splash.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UPB',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: hexToColor("#da0d25")),
      home: Splash(),
      routes: {
        "/splash": (context) => Splash(),
        "/login": (context) => Login(),
        "/dash": (context) => Dash()
      },
    );
  }

  Color hexToColor(String hexString, {String alphaChannel = 'FF'}) {
    return Color(int.parse(hexString.replaceFirst('#', '0x$alphaChannel')));
  }
}