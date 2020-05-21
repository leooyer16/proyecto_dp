import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:proyecto_dp/comments.dart';
import 'package:proyecto_dp/globales.dart';

class PostDetail extends StatefulWidget {
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  String url =
      "https://jsonplaceholder.typicode.com/posts/"+id_post+"/comments";
  Comments comments;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    var response = await http.get(url);
    var decodedJson = jsonDecode(response.body);
    comments = Comments.fromJson(decodedJson);
    setState(() {});
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[300],
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.blue[300],
          //title: Text(posts.title),
        ),
        drawer: Drawer(),
        body: comments == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                children: comments.comment
                    .map((p) => Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Card(
                          elevation: 3.0,
                          child: Column(children: <Widget>[
                            Text(
                              p.name,
                              style: TextStyle(
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.normal,
                                  fontSize: 20),
                            ),
                            Text(
                              p.email,
                              style: TextStyle(
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.normal,
                                  fontSize: 20),
                            ),
                            Text(
                              p.body,
                              style: TextStyle(
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.normal,
                                  fontSize: 20),
                            )
                          ]),
                        )))
                    .toList()));
  }
}
