import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:netflix_clone/models/api.dart';
import 'package:netflix_clone/models/models.dart';
import 'package:netflix_clone/widgets/Previews.dart';
import 'package:netflix_clone/widgets/content_list.dart';
import 'package:netflix_clone/widgets/responsive.dart';
import 'package:netflix_clone/widgets/vertical_icon_button.dart';
import 'package:video_player/video_player.dart';

import '../assets.dart';
import '../netflixdata/netflixdata.dart';

class ContentHeader extends StatelessWidget{
  final Content featuredContent;
  ContentHeader({
  required this.featuredContent,});

  @override
  Widget build(BuildContext context) {
    return Responsive(mobile: _ContentHeaderMobile(
      featuredContent: featuredContent,),
        desktop: _ContentHeaderDesktop(
          featuredContent: featuredContent));

  }
}

class _ContentHeaderMobile extends StatelessWidget{
  final Content featuredContent;
  _ContentHeaderMobile({
    required this.featuredContent,});


  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 500.0,
          child: CarouselSlider.builder(
            itemCount: 8,
              options: CarouselOptions(
                autoPlay: true,
                  aspectRatio: 16/9,
                  height: 400.0,
              viewportFraction: 1),
            itemBuilder: (context,index,realIndex){
                return ContentList(
                    futuredata: getTopRated(),
                    title: "");
            },
         ),
          // decoration: BoxDecoration(
          //   image: DecorationImage(image: AssetImage(featuredContent.imageUrl ),
          //       fit: BoxFit.cover),
          // ),
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
//
class _ContentHeaderDesktop extends StatefulWidget{
  final Content featuredContent;
  _ContentHeaderDesktop({
    required this.featuredContent,});
  _ContentHeaderDesktopState createState()=> _ContentHeaderDesktopState(featuredContent: featuredContent);
  
}
class _ContentHeaderDesktopState extends State<_ContentHeaderDesktop>{
  final Content featuredContent;
  _ContentHeaderDesktopState({
    required this.featuredContent,
  });

  VideoPlayerController? _videoPlayerController;
  bool _isMuted=true;
  @override
  void initState(){
    super.initState();
    _videoPlayerController=VideoPlayerController.network(featuredContent.videoUrl!)
      ..initialize().then((_) {
      })..setVolume(0)..play();
  }
  @override
  void dispose(){
    _videoPlayerController!.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
    onTap:()=> _videoPlayerController!.value.isPlaying ?_videoPlayerController!.pause():_videoPlayerController!.play(),
      child:
      Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Positioned(
          left: 0,
          right: 0,
          bottom: -1.0,
          child: AspectRatio(
            aspectRatio: _videoPlayerController!.value.isInitialized?
            _videoPlayerController!.value.aspectRatio:2.344,
            child: _videoPlayerController!.value.isInitialized? VideoPlayer(_videoPlayerController!):
            Image.asset(featuredContent.imageUrl,
            fit: BoxFit.cover,),
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
          left: 60.0,
            bottom: 150.0,
            child: Column(
              children: [
                SizedBox(
                  width: 250.0,
                  child: Image.asset(featuredContent.titleImageUrl!),
                ),
                const SizedBox(height: 15.0,),
                Text(featuredContent.description!,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 18.0,
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      offset: Offset(2.0,4.0),
                      blurRadius: 6.0,
                    )
                  ]
                ),),
                const SizedBox(height: 20.0,),
                Row(
                  children: [
                    ElevatedButton.icon(
                        style:  ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                        ),
                        onPressed: ()=>  _videoPlayerController!.value.isPlaying ? _videoPlayerController!.pause():_videoPlayerController!.play(),
                        icon:  Icon ( _videoPlayerController!.value.isPlaying? Icons.play_arrow:Icons.pause,size: 30.0,color: Colors.black,),
                        label:  Text(_videoPlayerController!.value.isPlaying ?"Play":"Pause",
                          style: TextStyle(fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),)),

                    const SizedBox(width: 16.0,),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0)
                        )
                      ),
                        onPressed: ()=> print("More Info"),
                        icon: const Icon(Icons.info_outline,
                          color: Colors.black,),
                        label: const Text("More Info",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,


                          ),)),
                    SizedBox(width: 20.0),
                    if(_videoPlayerController!.value.isInitialized)
                      IconButton(
                        icon: Icon( _isMuted ? Icons.volume_off:Icons.volume_up,
                          color: Colors.white,),
                        onPressed: ()=>
                            setState(() {
                              _isMuted ?
                              _videoPlayerController!.setVolume(100):
                              _videoPlayerController!.setVolume(0);

                              _isMuted= _videoPlayerController!.value.volume==0;

                            } )
                        ,)
                  ],
                )
              ],
            )),

      ],
      )
    );

  }
}
class _PlayButton extends StatelessWidget{
  VideoPlayerController? _videoPlayerController;

  @override
  Widget build(BuildContext context) {
 return ElevatedButton.icon(
   style:  ElevatedButton.styleFrom(
     primary: Colors.white,
     shape: RoundedRectangleBorder(
       borderRadius: BorderRadius.circular(0.0),
     ),
   ),
     onPressed: ()=>  print("Play"),
     icon:  Icon ( Icons.play_arrow ,size: 30.0,color: Colors.black,),
     label: const Text("Play",
       style: TextStyle(fontSize: 16.0,
           fontWeight: FontWeight.w600,
           color: Colors.black),))
 ;

  }
}