import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DownloadScreenPage extends StatefulWidget {
  const DownloadScreenPage({Key? key}) : super(key: key);

  @override
  State<DownloadScreenPage> createState() => _DownloadScreenPageState();
}

class _DownloadScreenPageState extends State<DownloadScreenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("My Downloads",
          style: TextStyle(fontSize: 22,
            fontWeight: FontWeight.bold),),
        actions: [
          Icon(Icons.collections_bookmark),
          const SizedBox(width: 20,),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Image.asset("assets/netflix.jpeg",
              height: 10,
              fit: BoxFit.cover,),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2)
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 20,right: 20),
              child: Row(
                children: [
                  Icon(Icons.info_outline,
                    color: Colors.white,),

                  const SizedBox(
                    width: 10,),

                  Text("Smart Downloads",
                    style: TextStyle(color: Colors.white,
                        fontWeight: FontWeight.bold),),

                  const SizedBox(
                    width: 3,),

                  Text("ON",
                    style: TextStyle(color: Colors.blue,
                        fontWeight: FontWeight.bold),)
                ],
              ),
            ),
          ),
          SizedBox(
            height: 60,
          ),
          Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.withOpacity(0.2),
            ),
            child: Center(
              child: Icon(Icons.file_download,
                size: 80,
                color: Colors.grey.withOpacity(0.3),),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text("Never be without Netflix",
            style: TextStyle(color: Colors.white,
                fontWeight: FontWeight.bold,
              fontSize: 20
            ),),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(left: 40,right: 40),
            child: Text("Download shows and movies so you'll never be without "
                "something to watch even when you are offline.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white,
                  fontWeight: FontWeight.bold,
                  height: 1.4,
                  fontSize: 16
              ),),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              color: Colors.white
            ),
            child: Center(
              child: Text("See What You Can Download",
                style: TextStyle(color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold),),
            ),
          )
        ],
      ),


    );
  }
}
