import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_clone/cubit/appbar_cubit.dart';
import 'package:netflix_clone/screens/homescreen_page.dart';
import 'package:netflix_clone/screens/navscreen_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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
              scaffoldBackgroundColor: Colors.black
          ),
          home: HomeScreenPage(),
        )
    );
      

  }
}
