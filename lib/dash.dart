import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upb_app/class/global.dart' as globals;

import 'articleDetail.dart';
import 'class/labor_social.dart';
import 'class/noticia.dart';
import 'components/laborSocialDateTable.dart';
import 'noticias.dart';
import 'request/login.dart';

class Dash extends StatefulWidget {
  @override
  _DashState createState() => _DashState();
}

class _DashState extends State<Dash> {
  int _selectedDrawerIndex = 0;
  ProgressDialog pr;
  String urlImagenAvatar =
      "https://www.libelularoja.com/wp-content/uploads/explicacion-resolucion-imagen.jpg";
  Noticia noticia = new Noticia(
      "Los dioses hawaianos nublan la vista de la astronomía mundial",
      Colors.transparent,
      "https://ep01.epimg.net/elpais/imagenes/2019/08/06/ciencia/1565103261_854833_1565255933_miniatura_normal.jpg",
      "UNIVERSIDAD",
      "Dos grandes noticias astronómicas han saltado a las portadas y telediarios en los últimos tiempos: la primera imagen de un agujero negro y la observación del primer cuerpo interestelar llegado desde fuera de nuestro sistema solar, la misteriosa roca Oumuamua. En estos dos hitos científicos tuvieron un papel determinante los observatorios hawaianos, los telescopios ubicados en las cumbres más altas de estas islas del pacífico. Pero desde hace casi cuatro semanas está parada toda la ciencia astronómica en Mauna Kea, la cumbre más alta de Hawái. El 16 de julio, los manifestantes contrarios a que se construya allí el Telescopio de Treinta Metros (TMT) bloquearon el acceso a esa cumbre. Y desde entonces, los 13 aparatos de la montaña sagrada de los nativos ni analizan agujeros negros, ni localizan asteroides peligrosos, ni buscan nuevos planetas habitables. Multiplicando el tiempo perdido entre los 13 instrumentos de observación, los científicos hablan de un año de trabajo científico tirado a la basura.",
      "https://elpais.com/elpais/2019/08/06/ciencia/1565103261_854833.html");

  Noticia noticia1 = new Noticia(
      "A la caza de un planeta gemelo de la Tierra",
      Colors.transparent,
      "https://ep01.epimg.net/elpais/imagenes/2019/08/02/ciencia/1564745315_633572_1564751613_noticia_normal_recorte1.jpg",
      "DR. SEBASTIAN",
      "En menos de 25 años los humanos hemos pasado de no saber si había planetas fuera del Sistema Solar a descubrir más de 4.000. Ahora sabemos que casi todas las estrellas tienen al menos un planeta y muchas de ellas albergan familias enteras de ellos. Ya no tenemos que preguntarnos si existe otro planeta como la Tierra con vida e inteligencia, sino si seremos capaces de desarrollar la tecnología para encontrarlo.",
      "https://elpais.com/elpais/2019/08/02/ciencia/1564745315_633572.html");

  Noticia noticia2 = new Noticia(
      "Aciertos y errores del vídeo que muestra el fin del universo",
      Colors.transparent,
      "https://ep01.epimg.net/elpais/imagenes/2019/08/02/ciencia/1564739222_702954_1564844286_noticia_normal_recorte1.jpg",
      "ING. CARLOS",
      "¿Cómo será el futuro? Es una pregunta que muchos se han hecho, pero quizá solo unos pocos han querido imaginar el futuro más distante. No el mañana, sino el viaje que llevará al universo a su frío final. El realizador y compositor John Boswell, conocido por sus vídeos en YouTube como Melodysheep, permite asomarse a ese futuro, el recorrido del cosmos a través de trillones de trillones de trillones de años, hasta el fin de todo, el momento en que 'el tiempo carece de sentido' porque, como dice el vídeo, 'nada sucede y nada sucederá, nunca más'.",
      "https://elpais.com/elpais/2019/08/02/ciencia/1564739222_702954.html");
  List<Noticia> lst;

}