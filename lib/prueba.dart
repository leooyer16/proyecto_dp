import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto_dp/globales.dart';

class JsonApiPhp extends StatefulWidget {
  @override
  _JsonApiPhpState createState() => _JsonApiPhpState();
}

class _JsonApiPhpState extends State<JsonApiPhp> {
  bool loading = true;
  final String url =
      "https://jsonplaceholder.typicode.com/posts/" + id_post + "/comments";
  var client = http.Client();
  List<Comment> comment = List<Comment>();

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future<void> fetchData() async {
    http.Response response = await client.get(url);
    if (response.statusCode == 200) {
      // Connection Ok
      List responseJson = json.decode(response.body);
      responseJson.map((m) => comment.add(new Comment.fromJson(m))).toList();
      setState(() {
        loading = false;
      });
    } else {
      throw ('error');
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget comments = Container(
        child: loading
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : ListView.builder(
                itemCount: comment.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    margin: EdgeInsets.all(4.0),
                    elevation: 3.0,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(8.0)),
                    child: ListTile(
                      title: Text(comment[index].body),
                      subtitle: Text(comment[index].name),
                      //leading: Text(comment[index].body),
                      trailing: Icon(Icons.favorite),
                    ),
                  );
                },
              ));

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(90.0), // here the desired height
          child: AppBar(
            title: Text(titulo_post, style: TextStyle(
                                          fontWeight: FontWeight.w200,
                                          fontSize: 20)),
            backgroundColor: Colors.blue,
          ),
        ),
        backgroundColor: Colors.grey[100],
        body: comments);
  }
}

class Comment {
  int postId;
  int id;
  String name;
  String email;
  String body;

  Comment({this.postId, this.id, this.name, this.email, this.body});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
        postId: json['postId'],
        name: json['name'],
        email: json['email'],
        body: json['body']);
  }
}
