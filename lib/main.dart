import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:netflix_clone/screens/homescreen_page.dart';
import 'package:netflix_clone/screens/navscreen_page.dart';
import 'package:netflix_clone/screens/splashscreen_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
      MyApp());
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
      home: SplashScreen(),
    );

  }
}
