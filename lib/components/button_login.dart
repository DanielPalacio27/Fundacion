import 'package:flutter/material.dart';


class CumstonButton extends StatefulWidget {

  final String texto;
  final VoidCallback callback;
  CumstonButton({@required this.texto, this.callback });

  @override
  _CumstonButtonState createState() => _CumstonButtonState();
}

class _CumstonButtonState extends State<CumstonButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.callback,
      child: Container(
        height: 50,
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: widget.colorBorder),
            borderRadius: BorderRadius.all(Radius.circular(10))

        ),
        child: Text(
            widget.texto.toUpperCase(),
            style: TextStyle(
                color: widget.colorBorder,
                fontSize: 15
            )
        ),
      ),
    );
  }
}
