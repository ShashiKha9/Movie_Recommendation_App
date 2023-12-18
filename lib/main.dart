import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_clone/cubit/appbar_cubit.dart';
import 'package:netflix_clone/screens/homescreen_page.dart';
import 'package:netflix_clone/screens/navscreen_page.dart';
import 'package:netflix_clone/screens/recommendationscreen.dart';
import 'package:netflix_clone/screens/registerscreen_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:netflix_clone/screens/searchscreen_page.dart';
import 'package:netflix_clone/screens/upcomingscreen_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  runApp(
      MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppBarCubit>(create: (context)=> AppBarCubit(),
       child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              visualDensity:VisualDensity.adaptivePlatformDensity ,
              scaffoldBackgroundColor: Color(0xff121012)  ,
               primaryColor: Color(0xff121012),


          ),
            home: NavScreenPage(),
        )
    );
  }
}
