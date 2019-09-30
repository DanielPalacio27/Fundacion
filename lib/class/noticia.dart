import 'dart:ui';
import 'package:flutter/material.dart';

class Noticia{
  String title;
  String name;
  String texto;
  Color color;
  String image;
  String url;

  Noticia(this.title, this.color, this.image, this.name, this.texto, this.url);

  static List<Noticia> noticias(){
    return [Noticia("prueba",Colors.black, "assets/img/prueba.jpg", "Prueba nueva card", "noticia de prueba para el card", "")];
  }
}