import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:proyecto_dp/comments.dart';

class PostDetail extends StatefulWidget {
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  String url = "https://jsonplaceholder.typicode.com/comments";
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
                          padding: const EdgeInsets.all(2.0),
                          child: Positioned(
                            height: MediaQuery.of(context).size.height / 1.5,
                            width: MediaQuery.of(context).size.width - 20,
                            left: 10,
                            top: MediaQuery.of(context).size.height * 0.1,
                            child: Card(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  SizedBox(
                                    height: 80.0,
                                  ),
                                  Text(
                                    p.name,
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    p.email,
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    p.body,
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ))
                    .toList()));
  }
}
