import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../assets.dart';

class CustomAppBar extends StatelessWidget{
  final double scrollOffset;
   CustomAppBar( {required this.scrollOffset});
  @override
  Widget build(BuildContext context) {
return Container(
  color: Colors.black.withOpacity((scrollOffset/350).clamp(0, 1).toDouble()),
  child: SafeArea(
    child: Row(
      children: [
        Image.asset(Assets.netflixLogo0,height: 40,),
        const SizedBox(width: 12.0),
        Expanded(child:
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _AppBarButton(title: "Tv Shows", onTap: ()=> print("Tv Shows")),
            _AppBarButton(title: "Movies ", onTap: ()=> print("Movies")),
            _AppBarButton(title: "My List", onTap: ()=> print("My List"))


          ],
        )
        )

      ],
    ),
  ),


);


  }
}
class _AppBarButton extends StatelessWidget{
  final String title;
  final Function() onTap;
  _AppBarButton({ required this.title,required this.onTap});

  @override
  Widget build(BuildContext context) {
  return GestureDetector(
    onTap: onTap,
    child: Text(title,
    style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.white),),

  ) ;
  }
}