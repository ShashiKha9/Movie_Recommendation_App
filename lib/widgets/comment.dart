import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/screens/moviescreen.dart';

class Comment extends StatelessWidget {
  final String text;
  final String time;
  final String user;


   Comment({
    required this.text,
    required this.time,
    required this.user});

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TextField(
          //   decoration: InputDecoration(
          //     hintText: "comment"
          //
          //   ),
          // ),

          Text(user,style: TextStyle(color: Colors.white),),

          Text(text,style: TextStyle(color: Colors.white)),

          Text(time,style: TextStyle(color: Colors.white)),


        ],
      ),
    );
  }
}
