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

void cerrarSesion() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Alerta!"),
          content: new Text("Desea cerrar sesion?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Cancelar"),
              onPressed: () {},
            ),
            new FlatButton(
                onPressed: () {
                  limpiarDatos();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil("/login", (routes) => false);
                },
                child: new Text("Aceptar"))
          ],
        );
      },
    );
  }

  void limpiarDatos() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("token", "");
    prefs.setString("nombre", "");
    prefs.setString("id", "");
    prefs.setString("expiration", "");
  }

  void laboralCheck() async {
    pr = new ProgressDialog(context, ProgressDialogType.Normal);
    pr.setMessage("Cargando..");
    pr.show();
    final res = await ApiClient.LaborRequest();
    List<LaborSocial> lstL = new List<LaborSocial>();
    List<dynamic> ls = res["message"];
    for (var obj in ls) {
      LaborSocial l = new LaborSocial(obj["id"], obj["usuario"], obj["horas"],
          obj["documento"], obj["idUniversitario"], obj["nombreUsuario"]);
      lstL.add(l);
    }
    pr.hide();
    Navigator.of(context).push(_NewPage("Labor social", lstL));
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
    /////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////
    //////////////TODO:PROPIEDADES DEL MENU LATERA///////////////////////////
    /////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////
    lst = new List();
    lst.add(noticia);
    lst.add(noticia1);
    lst.add(noticia2);
/*    for (var i = 0; i < 2; i++) {
      var noti = noticia;
      noti.title = "DIMERSI SE VOLVIO GAY! $i";
      lst.add(noti);
    }*/
    final drawerHeader = UserAccountsDrawerHeader(
      accountName: Text(globals.user.nombre),
      accountEmail: Text(''),
      currentAccountPicture: CircleAvatar(
        child: ClipOval(child: Image.asset("assets/img/escudo.png")
/*          FadeInImage.assetNetwork(
            placeholder: 'assets/img/loading.gif',
            image:'assets/img/escudo.png',
            width: 75.0,
            height: 75.0,
            fit: BoxFit.cover,
          ),*/
            ),
        //FadeInImage.assetNetwork(placeholder: 'assets/img/loading.gif', image: "https://marcianosmx.com/wp-content/uploads/2013/08/minimoo64_fractals_01.jpg",width: 75.0,height: 75.0,fit: BoxFit.cover,),
        backgroundColor: Colors.white,
      ),
/*      otherAccountsPictures: <Widget>[
        CircleAvatar(
          child: Text('A'),
          backgroundColor: Colors.yellow,
        ),
        CircleAvatar(
          child: Text('B'),
          backgroundColor: Colors.red,
        )
      ],*/
    );
    final drawerItems = ListView(
      children: <Widget>[
        drawerHeader,
        ListTile(
          leading: Icon(Icons.event_note),
          title: Text('Labor social'),
          onTap: () => this.laboralCheck(),
        ),
        ListTile(
          leading: Icon(Icons.subdirectory_arrow_left),
          title: Text('Cerrar sesión'),
          onTap: () => this.cerrarSesion(),
        ),
/*        ListTile(
          leading: Icon(Icons.art_track),
          title: Text('Noticias'),
          onTap: () => Navigator.of(context)
              .push(_Noticias("Noticias", urlImagenAvatar, noticia, lst)),
        ),*/
/*        ListTile(
          leading: Icon(Icons.new_releases),
          title: Text('other drawer item'),
          onTap: () {},
        ),*/
      ],
    );
    /////////////////////////////////////////////////////////////////////

    return Scaffold(
        appBar: AppBar(
          title: Text("UPB"),
        ),
        body: _getDrawerItemWidget(_selectedDrawerIndex),
        drawer: Drawer(
          child: drawerItems,
        ));
  }


  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new NoticiasFragment();
      default:
        return new Text("Error");
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }
}

// <Null> means this route returns nothing.
class _NewPage extends MaterialPageRoute<Null> {
  final String _titulo;
  final List<LaborSocial> lst;

  _NewPage(this._titulo, this.lst)
      : super(builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text('$_titulo'),
              elevation: 1.0,
            ),
            body: Center(
              child: LaborSocialDateTable(
                lst: lst,
              ),
            ),
          );
        });



}
Color hexToColor(String hexString, {String alphaChannel = 'FF'}) {
  return Color(int.parse(hexString.replaceFirst('#', '0x$alphaChannel')));
}
class _Noticias extends MaterialPageRoute<Null> {
  final String _titulo;
  final String _url;
  final Noticia noticia;
  final List<Noticia> lst;

  _Noticias(this._titulo, this._url, this.noticia, this.lst)
      : super(builder: (BuildContext context) {
          return DefaultTabController(
            initialIndex: 0,
            length: 1,
            child: Scaffold(
                appBar: AppBar(
                  title: Text('$_titulo'),
                  elevation: 1.0,
                ),
                body: Stack(
                  children: <Widget>[
/*                    Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                        strokeWidth: 2.5,
                      ),
                    ),*/
                    TabBarView(
                      children: <Widget>[
                        ListView.builder(
                          itemCount: lst == null ? 0 : lst.length,
                          itemBuilder: (_, int i) {
                            return Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Card(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(topRight: Radius.circular(5.0),topLeft: Radius.circular(5.0),bottomLeft: Radius.circular(5.0),bottomRight: Radius.circular(50.0)),
                                    ),
                                    child: ListTile(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                ArticleDetail(
                                              articles: lst[i],
                                            ),
                                          ),
                                        );
                                      },
                                      title: Container(
                                        child: Stack(
                                          alignment: AlignmentDirectional(0, 1),
                                          children: <Widget>[
                                            Hero(
                                                tag: i,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 0,
                                                      left: 0,
                                                      right: 0,
                                                      top: 0),
                                                  child:
                                                      FadeInImage.assetNetwork(
                                                    placeholder:
                                                        'assets/img/loading.gif',
                                                    image: lst[i].image == null
                                                        ? Image.asset(
                                                            'assets/img/imgPlaceholder.png',
                                                          )
                                                        : lst[i].image,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    height: 200,
                                                    fit: BoxFit.fill,
                                                  ),
                                                )),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(0.0),
                                              child: new Container(
                                                  decoration: new BoxDecoration(
                                                      color: Colors.black
                                                          .withOpacity(0.5)),
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 40,
                                                  child: new Center(
                                                    child: Text(
                                                      lst[i].name == null
                                                          ? Text("Title here")
                                                              .toString()
                                                          : lst[i]
                                                              .title
                                                              .toString(),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18.0,
                                                      ),
                                                    ),
                                                  )),
                                            )
                                          ],
                                        ),
                                      ),
                                      subtitle: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 2.0),
                                            child: FlatButton(
                                              splashColor: Colors.redAccent,
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        ArticleDetail(
                                                      articles: lst[i],
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Text(
                                                "Leer más",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue,
                                                  fontSize: 18.0,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(),
                              ],
                            );
                          },
                        )
                      ],
                    )
                  ],
                )),
          );
        });
}
