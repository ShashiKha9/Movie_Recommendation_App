import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MovieScreen extends StatefulWidget {
  dynamic movie;
   MovieScreen({Key? key,required this.movie}) : super(key: key);

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
        const  Icon(Icons.search,
          size: 30,),
          const SizedBox(width: 20,),
          Padding(
            padding: EdgeInsets.all(8.0),
              child: Image.asset("assets/netflix.jpeg"
                ,height: 10,
                fit: BoxFit.cover,
              ))
        ],
      ),
      body: SafeArea(
          child: Padding(padding: EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage( 'http://image.tmdb.org/t/p/w500'
                                + widget.movie["backdrop_path"]),
                            fit:BoxFit.cover )
                      ),
                    ), 
                    IconButton(onPressed:()=> print("Play"),
                        icon: Icon(Icons.play_circle_outline,
                          color: Colors.white,size: 40,)),
                  ],
                ),
                const SizedBox(
                  height: 7,),
                Text(widget.movie["title"],
                  style: TextStyle(fontWeight: FontWeight.bold,
                      color: Colors.white,
                  fontSize: 18),),

                Text(widget.movie["release_date"],
                  style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 15),),
                Padding(padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 40,
                    child: ElevatedButton(onPressed:(){},
                        child: Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.play_arrow,color: Colors.black,),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Play",style: TextStyle(color: Colors.black),),
                          ],
                        ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white)
                    ),),

                  ),
                ),
                Padding(padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 40,
                    child: ElevatedButton(onPressed:(){},
                      child: Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.download,color: Colors.white,),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Download",style: TextStyle(color: Colors.white),),
                        ],
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.grey[900])
                      ),),

                  ),
                ),
                Text(widget.movie["overview"],
                  style: const TextStyle(color: Colors.white70,
                      fontSize: 15,
                  ),
                  maxLines: 6,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: 120,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.red
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Icon(Icons.thumb_up_sharp,
                        color: Colors.white,
                        size: 20,),
                      Text("Most Liked",
                        style: TextStyle(color: Colors.white,
                            fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buttons(Icons.add, "My List"),
                      buttons(Icons.thumb_up_sharp, "Rate"),
                      buttons(Icons.share, "Share")

                    ],
                  ),
                )

              ],
            ),
          ),)),
    );
  }
 Widget  buttons(IconData icons,String name){
    return Column(
      children: [
        IconButton(onPressed: (){},
            icon: Icon(icons,color: Colors.white,)),
        Text(name,style: const TextStyle(color: Colors.white),)
      ],
    );
 }
}
