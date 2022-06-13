import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/models/api.dart';

class UpcomingScreenPage extends StatefulWidget {
  const UpcomingScreenPage({Key? key}) : super(key: key);

  @override
  State<UpcomingScreenPage> createState() => _UpcomingScreenPageState();
}

class _UpcomingScreenPageState extends State<UpcomingScreenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height: 180,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
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
                              height: 15,),
                            Text(upcoming[index]["title"],
                              style: TextStyle(fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 22,
                              ),),
                            const SizedBox(
                              height: 5,
                            ),

                            Text(upcoming[index]["release_date"],
                              style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                              fontWeight: FontWeight.w400),),

                            const SizedBox(
                              height: 15,),
                            Text(
                              upcoming[index]['overview'],
                              style: const TextStyle(
                                  color: Colors.white70, fontSize: 18,),
                              maxLines: 5,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const[
                                Text(" Triller  ",style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white),),

                                Icon(Icons.circle,size: 5,color: Colors.blue,),

                                Text("  Exciting  ",style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white),),

                                Icon(Icons.circle,size: 5,color: Colors.blue,),

                                Text("  Action  ",style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white),),

                                Icon(Icons.circle,size: 5,color: Colors.blue,),

                                Text("  Inspiring",style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white),),
                              ],

                            ),
                            const SizedBox(
                              height: 10,
                            )

                          ],

                        );
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
