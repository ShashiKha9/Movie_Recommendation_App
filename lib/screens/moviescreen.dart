
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix_clone/models/api.dart';
import 'package:netflix_clone/models/models.dart';
import 'package:netflix_clone/screens/registerscreen_page.dart';
import 'package:netflix_clone/widgets/comment.dart';
import 'package:readmore/readmore.dart';
import 'package:video_player/video_player.dart';

class MovieScreen extends StatefulWidget {
  dynamic movie;
   MovieScreen({Key? key,required this.movie}) : super(key: key);

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  late VideoPlayerController _controller;
  bool textFieldDisplayed = false;


  final _commentController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(
        'https://www.youtube.com/watch?v=mdE9FXCUIbc'))
    ..addListener(() { setState(() {
      
    });})..setLooping(true)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          _controller.play();
        });
      });
  }



  void addComment(String commentText){
    FirebaseFirestore.instance.collection("User Posts")
        .doc(widget.movie.toString())
        .collection("Comments")
        .add({
       "CommentText": commentText,
      "CommentBy": FirebaseAuth.instance.currentUser!.email,
      "CommentTime": Timestamp.now()
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.black,
      //   actions: [
      //   const  Icon(Icons.search,
      //     size: 30,),
      //     const SizedBox(width: 20,),
      //     Padding(
      //       padding: EdgeInsets.all(8.0),
      //         child: Image.asset("assets/netflix.jpeg"
      //           ,height: 10,
      //           fit: BoxFit.cover,
      //         ))
      //   ],
      // ),
      // body: SafeArea(
      //     child: Padding(padding: EdgeInsets.all(8.0),
      //     child: SingleChildScrollView(
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: <Widget>[
      //           Stack(
      //             alignment: Alignment.center,
      //             children: [
      //               Container(
      //                 height: 200,
      //                 width: double.infinity,
      //                 decoration: BoxDecoration(
      //                   image: DecorationImage(
      //                       image: NetworkImage( 'http://image.tmdb.org/t/p/w500'
      //                           + widget.movie["backdrop_path"]),
      //                       fit:BoxFit.cover )
      //                 ),
      //               ),
      //               IconButton(onPressed:()=> print("Play"),
      //                   icon: Icon(Icons.play_circle_outline,
      //                     color: Colors.white,size: 40,)),
      //             ],
      //           ),
      //           const SizedBox(
      //             height: 7,),
      //           Text(widget.movie["title"],
      //             style: TextStyle(fontWeight: FontWeight.bold,
      //                 color: Colors.white,
      //             fontSize: 18),),
      //
      //           Text(widget.movie["release_date"],
      //             style: TextStyle(
      //                 color: Colors.grey[300],
      //                 fontSize: 15),),
      //
      //
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //
      //             children: [
      //               Padding(padding: EdgeInsets.symmetric(horizontal: 3,vertical: 16),
      //                 child: SizedBox(
      //                   width: 180,
      //                   height: 40,
      //
      //
      //
      //
      //                   child: ElevatedButton(onPressed:(){
      //                     _controller!=null && _controller.value.isInitialized?
      //
      //                     Column(
      //                             children: [
      //                               SizedBox(
      //                                 height: 300,
      //                                 child: VideoPlayer(_controller),
      //                               )
      //                             ],
      //                           ):Container(
      //                       height: 200,
      //                             child: Center(
      //                       child: CircularProgressIndicator(),
      //                     ),
      //                           );
      //
      //
      //
      //                   },
      //                     child: Row(mainAxisAlignment: MainAxisAlignment.center,
      //                       children: [
      //                         Icon(Icons.play_arrow,color: Colors.black,),
      //                         SizedBox(
      //                           width: 10,
      //                         ),
      //                         Text("Play",style: TextStyle(color: Colors.black),),
      //                       ],
      //                     ),
      //                     style: ButtonStyle(
      //                         backgroundColor: MaterialStateProperty.all(Colors.white)
      //                     ),),
      //
      //                 ),
      //               ),
      //               Padding(padding: EdgeInsets.all(8.0),
      //                 child: SizedBox(
      //                   width: 180,
      //                   height: 40,
      //                   child: ElevatedButton(onPressed:(){},
      //                     child: Row(mainAxisAlignment: MainAxisAlignment.center,
      //                       children: [
      //                         Icon(Icons.download,color: Colors.white,),
      //                         SizedBox(
      //                           width: 10,
      //                         ),
      //                         Text("Download",style: TextStyle(color: Colors.white),),
      //                       ],
      //                     ),
      //                     style: ButtonStyle(
      //                         backgroundColor: MaterialStateProperty.all(Colors.grey[900])
      //                     ),),
      //
      //                 ),
      //               ),
      //             ],
      //
      //           ),
      //           Text(widget.movie["overview"],
      //             style: const TextStyle(color: Colors.white70,
      //                 fontSize: 15,
      //             ),
      //             maxLines: 6,
      //             overflow: TextOverflow.ellipsis,
      //           ),
      //           const SizedBox(
      //             height: 15,
      //           ),
      //           Container(
      //             width: 120,
      //             height: 30,
      //             decoration: BoxDecoration(
      //               borderRadius: BorderRadius.circular(10),
      //               color: Colors.red
      //             ),
      //             child: Row(
      //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //               children: const [
      //                 Icon(Icons.thumb_up_sharp,
      //                   color: Colors.white,
      //                   size: 20,),
      //                 Text("Most Liked",
      //                   style: TextStyle(color: Colors.white,
      //                       fontWeight: FontWeight.bold),)
      //               ],
      //             ),
      //           ),
      //           const SizedBox(
      //             height: 20,
      //           ),
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               Text("Reviews",style: TextStyle(color: Colors.white,fontSize: 18,),),
      //
      //               Divider(
      //                 color: Colors.grey,
      //               ),
      //
      //               TextButton(onPressed: (){
      //                 textFieldDisplayed = true;
      //                 setState(() {});
      //               },
      //                   child: Row(
      //                     children: [
      //                       Icon(Icons.message_outlined,color: Colors.white,),
      //                       SizedBox(width: 5,),
      //                       Text("Add review",style: TextStyle(color: Colors.white),)
      //                     ],
      //                   )),
      //             ],
      //           ),
      //
      //
      //
      //
      //
      //
      //
      //
      //
      //           if(textFieldDisplayed)
      //           TextField(
      //             controller: _commentController,
      //             maxLength: 10,
      //               maxLines: 5,
      //
      //               decoration: InputDecoration(
      //
      //                 suffixIcon: IconButton(onPressed: (){
      //                     addComment(_commentController.text);
      //
      //                     _commentController.clear();
      //
      //                 }, icon: Icon(Icons.send_outlined)),
      //                 hintText: "Write a review",
      //                 border: OutlineInputBorder(
      //                   borderRadius: BorderRadius.circular(10.0)
      //                 ),
      //                 filled: true,
      //                 fillColor: Colors.white
      //
      //               ),
      //           ),
      //
      //
      //           // Container(
      //           //   child: Row(
      //           //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //           //     children: [
      //           //       buttons(Icons.add, "My List"),
      //           //       buttons(Icons.thumb_up_sharp, "Rate"),
      //           //       buttons(Icons.share, "Share")
      //           //
      //           //     ],
      //           //   ),
      //           // ),
      //           Comment(text: "", time: "", user: RegisterScreenState().emailController.text),
      //           //comments
      //           StreamBuilder<QuerySnapshot>(
      //             stream: FirebaseFirestore.instance.collection("User Posts")
      //               .doc(widget.movie.toString())
      //               .collection("Comments")
      //               .orderBy("CommentTime",descending: true)
      //               .snapshots(),
      //               builder: (context,snapshot){
      //               if(!snapshot.hasData){
      //                 return Center(
      //                   child: CircularProgressIndicator(),
      //                 );
      //               }
      //               //
      //                 return ListView(
      //                   shrinkWrap: true,
      //                   physics: NeverScrollableScrollPhysics(),
      //                   children: snapshot.data!.docs.map((doc){
      //                     final commentData = doc.data() as Map<String,dynamic>;
      //                     return Comment(text: commentData["CommentText"],
      //                       user: commentData["CommentBy"],
      //                       time: " ");
      //
      //
      //                   }).toList(),
      //
      //                 );
      //
      //           }),
      //
      //           //
      //           // TextField(
      //           //   controller: _commentController,
      //           //   decoration: InputDecoration(
      //           //     hintText: "comments",
      //           //   ),
      //           //
      //           // ),
      //           // TextButton(onPressed: (){
      //           //   addComment(_commentController.text);
      //           //
      //           //
      //           //   _commentController.clear();
      //           // },
      //           //     child: Text("Add"))
      //
      //
      //         ],
      //       ),
      //     ),)),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  foregroundDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    gradient: LinearGradient(colors: [
                      Theme.of(context).primaryColor.withOpacity(0.8),
                      Colors.transparent
                    ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter
                    )
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.50,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage( 'http://image.tmdb.org/t/p/w500'
                              + widget.movie["backdrop_path"]),
                          fit:BoxFit.cover )
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.movie["title"],
                                            style: GoogleFonts.lato(fontWeight: FontWeight.w600,
                                                color: Colors.white,

                                                fontSize: 24),),

                              SizedBox(
                                height: 10,
                              ),
                              Text(widget.movie["release_date"].toString().substring(0,4),
                                            maxLines: 3,
                                            style: GoogleFonts.lato(color: Colors.white38,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600)
                                            ),




                            ],
                          ),
                          //ratings
                          Row(
                            children: [
                              Text(widget.movie["vote_average"].toString().substring(0,3),
                                  style: GoogleFonts.lato(color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600)
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(Icons.star,color: Colors.yellow,size: 15,)

                            ],
                          ),


                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        child: ReadMoreText(widget.movie["overview"],
                          trimLines: 3,
                          trimMode: TrimMode.Line,
                          style: GoogleFonts.lato(
                            color: Colors.white70,
                            height: 1.5,
                            fontWeight: FontWeight.w500
                        ),),),

                  const SizedBox(
                                height: 20,
                              ),
                  Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Comments",style: TextStyle(color: Colors.white38,fontSize: 18,),),

                                  Divider(
                                    color: Colors.grey,
                                  ),

                                  TextButton(onPressed: (){
                                    textFieldDisplayed = true;
                                    setState(() {});
                                  },
                                      child: Row(
                                        children: [
                                          Icon(Icons.message_outlined,color: Colors.deepPurpleAccent,),
                                          SizedBox(width: 5,),
                                          Text("Add review",style: GoogleFonts.lato(color: Colors.deepPurpleAccent),)
                                        ],
                                      )),
                                ],
                              ),
                      if(textFieldDisplayed)
                                buildwriteReview(),
                      //

                    //
                              buildComments(),



                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  TextField buildwriteReview() {
    return TextField(
      style: TextStyle(color: Colors.white70),
                                controller: _commentController,
                                maxLength: 10,
                                  maxLines: 5,

                                  decoration: InputDecoration(

                                    suffixIcon: IconButton(onPressed: (){
                                        addComment(_commentController.text);

                                        _commentController.clear();

                                    }, icon: Icon(Icons.send_outlined,color: Colors.white38,)),
                                    hintText: "Write a review",
                                    hintStyle: TextStyle(color: Colors.white38),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0)
                                    ),
                                    filled: true,
                                    fillColor: Color(0xff251546)

                                  ),
                              );
  }

  Container buildComments() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      height: 160,
      child: FutureBuilder(
        future: getReviews(widget.movie["id"]),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  bool hasImage = snapshot
                      .data[index]["author_details"]["avatar_path"] != null;
                  return Container(
                    width: 300,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xff251546)
                    ),
                    margin: EdgeInsets.only(right: 15),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,


                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            hasImage ?

                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image:

                                DecorationImage(
                                  image:
                                  NetworkImage('http://image.tmdb.org/t/p/w500'
                                      + snapshot
                                          .data[index]["author_details"]["avatar_path"]),


                                ),
                              ),
                            ) :
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image:

                                  DecorationImage(
                                      image:
                                      AssetImage("assets/netflix.jpeg",
                                      ))

                              ),

                            ),
                            SizedBox(
                              width: 10,
                            ),

                            Text(snapshot
                                .data[index]["author_details"]["username"],
                              style: TextStyle(color: Colors.white),)


                          ],
                        ),

                        SizedBox(
                          width: 10,
                        ),


                        Padding(padding: EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                          child: ReadMoreText(snapshot.data[index]["content"],
                            trimLines: 2,
                            trimMode: TrimMode.Line,
                            style: GoogleFonts.lato(
                                color: Colors.white70,
                                height: 1.5,
                                fontWeight: FontWeight.w500
                            ),),),
                      ],

                    ),


                  );
                });

          } else{
            return Text("");
          }
          
        }
      ),
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
