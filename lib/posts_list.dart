import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:proyecto_dp/globales.dart';
import 'package:proyecto_dp/posts.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto_dp/prueba.dart';

class PostList extends StatefulWidget {
  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  String url =
      "https://raw.githubusercontent.com/LizbethGarcia1/posts/master/posts.json";
  Postss postss;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    var response = await http.get(url);
    var decodedJson = jsonDecode(response.body);
    postss = Postss.fromJson(decodedJson);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(90.0), // here the desired height
          child: AppBar(
            titleSpacing: 0.0,
            centerTitle: true,
            title: new Transform(
                transform: new Matrix4.translationValues(0.0, 10.0, 0.0),
                child: Text(
                  "PostApp",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                )),
            backgroundColor: Colors.blue,
          ),
        ),
        backgroundColor: Colors.grey[300],
        drawer: Drawer(),
        body: postss == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                children: postss.posts
                    .map((p) => Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: InkWell(
                              child: Hero(
                            tag: p.title,
                            child: Card(
                                margin: EdgeInsets.all(2.0),
                                elevation: 3.0,
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(7.0)),
                                //width: 300,
                                //height: 90,
                                //padding: EdgeInsets.all(2.0),
                                child: ListTile(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  JsonApiPhp()));
                                      id_post = p.id.toString();
                                      titulo_post = p.title;
                                    },
                                    title: Text(
                                      p.title,
                                      style: TextStyle(
                                          color: Colors.grey[800],
                                          fontWeight: FontWeight.normal,
                                          fontSize: 20),
                                    ),
                                    subtitle: Text(p.body)
                                    //elevation: 2,
                                    //color: Colors.white,
                                    //shape: new RoundedRectangleBorder(
                                    // borderRadius:
                                    //new BorderRadius.circular(7.0)),
                                    //highlightColor: Colors.cyan[100],
                                    //child:
                                    )),
                          )),
                        ))
                    .toList()));
  }
}

/*GridView.count(
              crossAxisCount: 1,
              children: postss.posts
                  .map((p) => Padding(
                    /*
                        padding: const EdgeInsets.all(2.0),
                        child: InkWell(
                          onTap: () {
                            //Navigator.push(context, MaterialPageRoute(builder: (context) => PostsDetail(pokemon: p,)));
                          },
                          //child: Hero(
                            //tag: p.userId,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Text(
                                      p.title, 
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ))
                              ],
                            ),
                          //),
                        ),
                     */ ))
                  .toList(),
            ),*/
