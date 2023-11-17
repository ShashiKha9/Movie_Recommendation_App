import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix_clone/models/api.dart';
import 'package:shimmer/shimmer.dart';

import '../models/movieModel.dart';

class RecommendationScreen extends StatefulWidget {

  @override
  State<RecommendationScreen> createState() => _RecommendationScreenState();
}

class _RecommendationScreenState extends State<RecommendationScreen> {
  final _movieController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("Recommendations for you",style: GoogleFonts.lato(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500),),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              style: TextStyle(color: Colors.white),
              controller: _movieController,
              decoration: InputDecoration(
                  hintText: "search the movie",
                  suffixIcon: IconButton(
                    onPressed: (){
                      log("dwd2");

                      Expanded(
              child: FutureBuilder<List<MovieModel>?>(

                future:  getRecommend(_movieController.text),

                builder: (BuildContext context, AsyncSnapshot<List<MovieModel>?> snapshot) {
                  if(!snapshot.hasData){
                    log("dwd1");
                    return GridView.builder(
                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                         childAspectRatio: 0.7,
                           crossAxisCount: 2),
                        itemCount: 10,
                        itemBuilder: (context, index) => Shimmer.fromColors(
                            baseColor: Colors.grey.shade400,
                            highlightColor: Colors.white,
                          child:   Container(
                            margin: EdgeInsets.all(10.0),
                       decoration: BoxDecoration(
                         color: Colors.red,
                         borderRadius: BorderRadius.circular(10),


                       ),
                           )
                        )
                     );
                  }else{ log("shashi else");
                  Fluttertoast.showToast(
                      msg: "This is a second Toast message",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      textColor: Colors.white


                  );
                    return
                    GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 0.7,
                          crossAxisCount: 2),
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.all(10.0),

                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image:
                                  NetworkImage('http://image.tmdb.org/t/p/w500  ${getPoster(snapshot.data![index].id)}')
                              )


                          ),
                          child: Text(snapshot.data![index].name,style: TextStyle(color: Colors.white),),
                        );
                      },
                    );}


                }
              ),
            );
              },
                    icon: Icon(Icons.send_outlined,color: Colors.white,),
                  )
              )
            )

          ],

        ),
      ),
    );
  }
}
