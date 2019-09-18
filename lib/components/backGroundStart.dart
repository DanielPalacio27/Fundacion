import 'package:flutter/material.dart';

class BackStart extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        Center(
          child: Image.asset("assets/img/fondo.jpg"),
        ),
/*
        Container(
          alignment: Alignment(0, 1),
          width: 300,
          height: 150,
          decoration: BoxDecoration(
            color: Colors.amberAccent.withOpacity(0.6),
            borderRadius: BorderRadius.only(topRight: Radius.circular(100.0))
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
                  child: Text("hola"),
            ),
          ),
        )
*/
      ],
    );
  }
 
  
}