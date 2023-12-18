import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix_clone/models/api.dart';
import 'package:netflix_clone/models/models.dart';
import 'package:netflix_clone/models/topRatedModel.dart';
import 'package:netflix_clone/screens/moviescreen.dart';
import 'package:netflix_clone/screens/recommendationscreen.dart';

class ContentList extends StatelessWidget{
  final String title;
  final bool isOriginals;
  final Future futuredata;
  final Future<TopRatedModel> ?futuredata1;
  final bool isCarousel;

  const ContentList({Key? key,
    required this.futuredata,
    this.futuredata1,
    required this.title,
    this.isCarousel=false,
     this.isOriginals=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
return Padding(padding: EdgeInsets.symmetric(vertical: 6.0),
  child:Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
Padding(padding: EdgeInsets.symmetric(horizontal: 24.0),
    child:Text(title,
    style: GoogleFonts.lato(
      color: Colors.white70,
      fontSize: 20,
      fontWeight: FontWeight.w600
    ))
),
   isCarousel?
   // CarouselSlider(
   //  options: CarouselOptions(
   //    height: 400.0,
   //    enlargeCenterPage: true,
   //    autoPlay: true,
   //    aspectRatio: 16/9,
   //    autoPlayCurve: Curves.fastOutSlowIn,
   //    enableInfiniteScroll: true,
   //    autoPlayAnimationDuration: Duration(milliseconds: 800),
   //    viewportFraction: 0.8,
   //    reverse: false
   //  ),
   //    items: [
   //      Container(
   //      child:  FutureBuilder(
   //            future: futuredata,
   //            builder: (context,AsyncSnapshot snapshot) {
   //              if (snapshot.hasData) {
   //                return Container(
   //                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
   //                  width: MediaQuery.of(context).size.width,
   //                  decoration: BoxDecoration(
   //                    borderRadius: BorderRadius.circular(10),
   //                    image: DecorationImage(
   //                      image: NetworkImage('http://image.tmdb.org/t/p/w500'+
   //                          snapshot.data[0]["poster_path"]),
   //                      fit: BoxFit.cover,
   //                    ),
   //                  ),
   //                );
   //              }
   //              return Container();
   //            }
   //        ),
   //      )
   //
   //    ],
   //  ):
   FutureBuilder<TopRatedModel>(
    future: futuredata1,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        // Convert the object to a JSON string
        // String jsonString = jsonEncode(snapshot.data);
        // print(jsonString);
        // List<Results>? result = snapshot.data?.results;
        // Temp a = imageurl as Temp;
        // jsonDecode(imageurl.toString());
        print("called by ak 2: ${snapshot.data}");
        return Center(
          child: CarouselSlider(
            options: CarouselOptions(
              height: 400.0,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 0.8,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              viewportFraction: 0.8,
            ),
            items: snapshot.data!.results.asMap().entries.map((entry) {
              final int index = entry.key;
              print("shashi 7:${entry.value }");
               print("shashi+ ${snapshot.data}");
              print("called by ak 1:${entry.value.posterPath}");
              return Builder(
                builder: (BuildContext context) {
                  return GestureDetector(
                    onTap: ()=>Navigator.push(context,
                      MaterialPageRoute(builder: (context)=>
                          MovieScreen(movie: entry.value))
                      ,),
                    child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                            image: NetworkImage('http://image.tmdb.org/t/p/w500' + entry.value.posterPath,
                            ),fit: BoxFit.cover)

                      ),

                    ),
                  );
                },
              );
            }).toList(),
          ),
        );
      }
      return Container();

    }

    ):

      Container(
        height: isOriginals ? 210.0 : 220.0,
        child: FutureBuilder(
          future: futuredata,
          builder: (context,AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                padding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 16.0,
                ),
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context)=>
                            MovieScreen(movie: snapshot.data[index])),),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      height: isOriginals ? 200.0 : 50.0,
                      width: isOriginals ? 300.0 : 130.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: NetworkImage('http://image.tmdb.org/t/p/w500'+
                              snapshot.data[index]["poster_path"]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return Container();
          }
        ),
      ),
    ],
  ),
);
  }
}