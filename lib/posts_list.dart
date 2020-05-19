import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:proyecto_dp/posts.dart';
import 'package:http/http.dart' as http;

class PostList extends StatefulWidget {
  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  String url = "https://raw.githubusercontent.com/LizbethGarcia1/posts/master/posts.json";
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
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post App"),
        backgroundColor: Colors.pink,
      ),
      drawer: Drawer(),
      body: postss==null ? Center(child: CircularProgressIndicator(),) :
      GridView.count(
        crossAxisCount: 1,
        children: postss.posts.map((p)=> Padding(
          padding: const EdgeInsets.all(2.0),
          child: InkWell(
            onTap: (){
              //Navigator.push(context, MaterialPageRoute(builder: (context) => PostsDetail(pokemon: p,)));
            },
            child: Hero(
              tag: p.userId,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    /*Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(p.userId)
                          )
                      ),
                    ),*/
                    Text(
                      p.title,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    )
                  ],
                ),
              
            ),
          ),
        )).toList(),
      ),
    );
  }
}