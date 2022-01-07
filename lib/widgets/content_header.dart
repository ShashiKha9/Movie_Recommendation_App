import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/models/models.dart';
import 'package:netflix_clone/widgets/vertical_icon_button.dart';

import '../assets.dart';

class ContentHeader extends StatelessWidget{
  final Content featuredContent;
  ContentHeader({
  required this.featuredContent,});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 500.0,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(featuredContent.imageUrl ),
            fit: BoxFit.cover),
          ),
        ),
        Container(
          height: 500.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.black,Colors.transparent],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter
            )
          ),
        ),
       Positioned(
         bottom: 110.0,
       child: SizedBox(
          width: 250.0,
          child: Image.asset(featuredContent.titleImageUrl!),
        )
       ),
        Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 40.0,
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                VerticalIconButton(
                    title: "List",
                    onTap: ()=> print("List"),
                    icon: Icons.add),
                _PlayButton(),
                VerticalIconButton(
                    title: "Info",
                    onTap: ()=> print("Info"),
                    icon: Icons.info_outline),
              ],
            ) )



      ],

    );

  }
}
class _PlayButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
 return ElevatedButton.icon(
   style:  ElevatedButton.styleFrom(
     primary: Colors.white,
     shape: RoundedRectangleBorder(
       borderRadius: BorderRadius.circular(0.0),
     ),
   ),
     onPressed: ()=>print("Play"),
     icon: const Icon(Icons.play_arrow,size: 30.0,color: Colors.black,),
     label: const Text("Play",
       style: TextStyle(fontSize: 16.0,
           fontWeight: FontWeight.w600,
           color: Colors.black),))
 ;

  }
}