import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/widgets/responsive.dart';

import '../assets.dart';

class CustomAppBar extends StatelessWidget{
  final double scrollOffset;
   CustomAppBar( {required this.scrollOffset});
  @override
  Widget build(BuildContext context) {
return Container(
  color: Colors.black.withOpacity((scrollOffset/350).clamp(0, 1).toDouble()),
  child: Responsive(mobile:_CustomAppBarMobile(),
  desktop: _CustomAppBarDesktop(),)

);


  }
}
class _CustomAppBarMobile extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
    );


  }
}
class _CustomAppBarDesktop extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          Image.asset(Assets.netflixLogo1,height: 40,),
          const SizedBox(width: 12.0),
          Expanded(child:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _AppBarButton(title: "Home", onTap: ()=> print("Home")),
              _AppBarButton(title: "Tv Shows", onTap: ()=> print("Tv Shows")),
              _AppBarButton(title: "Movies ", onTap: ()=> print("Movies")),
              _AppBarButton(title: "Latest", onTap: ()=> print("Latest")),
              _AppBarButton(title: "My List", onTap: ()=> print("My List"))
            ],
          )
          ),
          const Spacer(),
          Expanded(child:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(onPressed: ()=>print("search"),
                  icon: Icon(Icons.search,color: Colors.white,)),
              _AppBarButton(title: "KIDS", onTap: ()=> print("KIDS")),
              _AppBarButton(title: "DVD", onTap: ()=> print("DVD")),
              IconButton(onPressed: ()=>print("Gift Card"),
                  icon: Icon(Icons.card_giftcard,color: Colors.white,)),
              IconButton(onPressed: ()=>print("notifications"),
                  icon: Icon(Icons.notifications,color: Colors.white,)),




            ],
          )
          )


        ],
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