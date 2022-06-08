import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_clone/cubit/appbar_cubit.dart';
import 'package:netflix_clone/screens/homescreen_page.dart';
import 'package:bloc/bloc.dart';
import 'package:netflix_clone/widgets/responsive.dart';

class NavScreenPage extends StatefulWidget{
  NavScreenPageState  createState()=> NavScreenPageState();
}
class NavScreenPageState extends State<NavScreenPage>{
  final List<Widget> _screens=[
    HomeScreenPage(key:PageStorageKey("homescreen")),
    Scaffold(),
    Scaffold(),
    Scaffold(),
    Scaffold(),
  ];
  final Map<String,IconData> _icons = const{
    "Home": Icons.home,
    "Search":Icons.search,
    "Coming Soon":Icons.queue_play_next,
    "Downloads":Icons.file_download,
    "More":Icons.menu,
  };
  int _currentIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      BlocProvider<AppBarCubit>(
        create: (context)=> AppBarCubit(),
          child: _screens[_currentIndex]),
      bottomNavigationBar: !Responsive.isDesktop( context)?
      BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: _icons.map((title, icon) => MapEntry(
            title, BottomNavigationBarItem(
          icon: Icon(icon,size: 30.0,),
          label: title,

        ))).values.toList(),
        currentIndex: _currentIndex,
        selectedItemColor: Colors.white,
        selectedFontSize: 11.0,
        unselectedItemColor: Colors.grey,
        unselectedFontSize: 11.0,
        backgroundColor: Colors.black87,
        onTap: (index)=>setState(()=>_currentIndex=index),

        ): null

    );

  }
}