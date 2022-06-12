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
      backgroundColor: Colors.black,
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
          child: Padding(padding: EdgeInsets.all(10.0),
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
                    )

                  ],
                )

              ],
            ),
          ),)),
    );
  }
}
