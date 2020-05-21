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
      "https://jsonplaceholder.typicode.com/posts/" + idPost + "/comments";
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
    Widget nombrePost = Padding(
      padding: EdgeInsets.all(2.0),
      child: Card(
          color: Colors.blue[200],
          elevation: 5.0,
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(8.0)),
          child: ListTile(
            title: Text(tituloPost,
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 25)),
          )),
    );

    Widget comments = Expanded(
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
                    margin: EdgeInsets.all(5.0),
                    elevation: 3.0,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(8.0)),
                    child: ListTile(
                      title: Text(comment[index].body),
                      subtitle: Text(comment[index].name),
                      trailing: Icon(Icons.favorite),
                    ),
                  );
                },
              ));

    return Scaffold(
        appBar: AppBar(
          title: Text("Comments"),
          backgroundColor: Colors.blue,
        ),
        backgroundColor: Colors.grey[200],
        body: Column(
          children: <Widget>[nombrePost, comments],
        ));
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
