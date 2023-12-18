import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix_clone/models/api.dart';
import 'package:intl/intl.dart';


class UpcomingScreenPage extends StatefulWidget {
  const UpcomingScreenPage({Key? key}) : super(key: key);

  @override
  State<UpcomingScreenPage> createState() => _UpcomingScreenPageState();
}

class _UpcomingScreenPageState extends State<UpcomingScreenPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Coming Soon",style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold),),
        actions: [
          Icon(Icons.collections_bookmark),
          const SizedBox(
            width: 20,
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Image.asset("assets/netflix.jpeg",
              height: 10,
              fit: BoxFit.cover,),
          )

        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20,right: 20,top: 15,bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.notifications_none_outlined,
                        size: 28,
                        color: Colors.white.withOpacity(0.9),),
                      SizedBox(width: 15,),
                      Text("Notifications",style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white.withOpacity(0.9)),)
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios_outlined,
                    color: Colors.white,)
                ],
              ),
            ),
            FutureBuilder(
              future: getUpcoming(),
                builder: (context,snapshot){
                if(snapshot.hasData) {
                  List upcoming = snapshot.data as List;
                  return ListView.builder(

                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                      itemCount: upcoming.length,
                      itemBuilder: (context, index) {
                        if (upcoming[index]["backdrop_path"] != null) {
                          String dateString = upcoming[index]["release_date"];
                          DateTime dateTime = DateTime.parse(dateString);
                          String yearInWords = DateFormat('y', 'en_US').format(
                              dateTime);
                          String monthInWords = DateFormat('MMMM', 'en_US')
                              .format(dateTime);
                          print('Month in words: $monthInWords');

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(


                                      margin: EdgeInsets.all(10),
                                      height: 180,
                                      width: double.infinity,


                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(colors: [
                                            Theme
                                                .of(context)
                                                .primaryColor,
                                            Colors.black
                                          ],
                                            begin: Alignment.center,
                                            end: Alignment.bottomCenter,
                                            stops: [
                                              0.1,
                                              0.75
                                            ],

                                          ),

                                          borderRadius: BorderRadius.circular(
                                              16),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  'http://image.tmdb.org/t/p/w500' +
                                                      upcoming[index]["backdrop_path"]),
                                              fit: BoxFit.cover))
                                  ),
                                  Container(
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Colors.white,
                                            width: 1),
                                        color: Colors.black38

                                    ),
                                    child: Icon(Icons.play_arrow,
                                      color: Colors.white,
                                      size: 28,
                                    ),
                                  )


                                ],

                              ),
                              const SizedBox(
                                height: 3,),
                              Text(upcoming[index]["title"],
                                  style: GoogleFonts.lato(fontSize: 22,
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w600)),
                              const SizedBox(
                                height: 5,
                              ),

                              Text("$yearInWords  $monthInWords",


                                  style: GoogleFonts.lato(fontSize: 14,
                                      color: Colors.white38,
                                      fontWeight: FontWeight.w600)),

                              const SizedBox(
                                height: 15,),
                              // Text(
                              //   upcoming[index]['overview'],
                              //   style: GoogleFonts.lato(fontSize: 14,color: Colors.white38,),
                              //   maxLines: 5,
                              // ),
                              const SizedBox(
                                height: 2,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(" Thriller  ", style: GoogleFonts.lato(
                                      fontSize: 14,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w600),),

                                  Icon(Icons.circle, size: 5,
                                      color: Color(0xff251546)),

                                  Text("  Exciting  ", style: GoogleFonts.lato(
                                      fontSize: 14,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w600),),

                                  Icon(Icons.circle, size: 5,
                                      color: Color(0xff251546)),

                                  Text("  Action  ", style: GoogleFonts.lato(
                                      fontSize: 14,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w600),),

                                  Icon(Icons.circle, size: 5,
                                      color: Color(0xff251546)),

                                  Text("  Inspiring", style: GoogleFonts.lato(
                                      fontSize: 14,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w600),),
                                ],

                              ),
                              const SizedBox(
                                height: 10,
                              )

                            ],

                          );
                        } else{
                          return Container();

                        }
                      }


                  );

                  }

                  return Container();



            })
          ],
        ),
      ),
    );
  }
}
