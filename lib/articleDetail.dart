import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'class/noticia.dart';

class ArticleDetail extends StatefulWidget {
  final Noticia articles;
  ArticleDetail({this.articles});
  @override
  _ArticleDetailState createState() => _ArticleDetailState();
}

class _ArticleDetailState extends State<ArticleDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Noticia"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 20.0),
        alignment: Alignment.center,
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 10.0, right: 10.0),
              child: Text(
                "${widget.articles.title == null ? 'Title Here' : widget.articles.title}",
                style: Theme.of(context).textTheme.headline,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10.0),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              child: Stack(
                children: <Widget>[
                  Hero(
                    tag: widget.articles.title,
                    child: FadeInImage.assetNetwork(
                      alignment: Alignment.center,
                      fit: BoxFit.cover,
                      height: 280.0,
                      width: MediaQuery.of(context).size.width,
                      placeholder: 'assets/img/loading.gif',
                      image: widget.articles.image == null
                          ? Image.asset(
                        'assets/img/imgPlaceholder.png',
                      ).toString().toString()
                          : widget.articles.image,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 5.0),
              child: Row(
                children: <Widget>[
                  Text(
                    "Posteado por : ",
                    style: Theme.of(context).textTheme.body2,
                  ),
                  Expanded(
                    child: Text(
                      "${widget.articles.name == null ? 'Ananymous Author' : widget.articles.name.toString()}",
                      style: Theme.of(context).textTheme.subhead,
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 5.0),
              child: Text(
                  "${widget.articles.texto == null ? 'Description of Article' : widget.articles.texto}",
                  style: Theme.of(context).textTheme.subhead),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 5.0),
              child: Text(
                "${widget.articles.texto == null ? 'Loading' : ""}",
                style: Theme.of(context).textTheme.body1,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Para más información visita el siguiente link URL :",
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      if(await canLaunch(widget.articles.url)){
                        await launch(widget.articles.url);
                      }
                    },
                    child: Text(
                      "Click here",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        debugLabel: "Link",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
