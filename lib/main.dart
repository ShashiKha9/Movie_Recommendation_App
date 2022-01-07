import 'package:flutter/material.dart';
import 'package:netflix_clone/screens/homescreen_page.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity:VisualDensity.adaptivePlatformDensity ,
        scaffoldBackgroundColor: Colors.black
      ),
      home: HomeScreenPage(),
    );

  }
}
