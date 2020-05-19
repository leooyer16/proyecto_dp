import 'package:flutter/material.dart';
import 'package:proyecto_dp/posts_list.dart';
   void main(){
  runApp(MaterialApp(
    title: "Posts",
    home: PostList(),
    debugShowCheckedModeBanner: false,
  ));
}