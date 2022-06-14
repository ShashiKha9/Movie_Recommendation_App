import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/models/api.dart';

class SearchScreenPage extends StatefulWidget {
  const SearchScreenPage({Key? key}) : super(key: key);

  @override
  State<SearchScreenPage> createState() => _SearchScreenPageState();
}

class _SearchScreenPageState extends State<SearchScreenPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(12),
              child: TextFormField(
                cursorHeight: 20,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  filled: true,
                  border: InputBorder.none,
                  fillColor: Colors.grey.withOpacity(0.4),
                  hintText: "Search for a movie, Tv shows......",
                  hintStyle: TextStyle(color: Colors.grey),

                  prefixIcon: Icon(Icons.search_outlined,
                    color: Colors.grey,),

                  suffixIcon: Icon(Icons.mic,color: Colors.grey,)
                ),

              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding:EdgeInsets.only(left: 20,bottom: 10,top: 10),
                    child: Text("Top Searches",
                      style: TextStyle(color: Colors.white,
                          fontSize: 22,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.bold),),
                  ),
                  FutureBuilder(
                    future: getTopRated(),
                      builder: (context,snapshot){
                      if(snapshot.hasData) {
                        List topRated = snapshot.data as List;
                        return ListView.separated(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 3,);
                          },
                          itemCount:topRated.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              child: ListTile(
                                leading: Container(
                                  height: 120,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              'http://image.tmdb.org/t/p/w500' +
                                              topRated[index]["backdrop_path"]))
                                  ),
                                ),
                                title: Text(topRated[index]["title"],
                                  maxLines: 2,
                                  style: TextStyle(color: Colors.white),),

                                trailing: Icon(Icons.play_circle_outline,
                                  color: Colors.white,size: 30,),
                                
                              ),
                              onTap: (){},
                            );
                          },
                        );
                      }
                      return Container();
                  }
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
