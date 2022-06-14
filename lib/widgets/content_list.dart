import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/models/api.dart';
import 'package:netflix_clone/models/models.dart';
import 'package:netflix_clone/screens/moviescreen.dart';

class ContentList extends StatelessWidget{
  final String title;
  final List<Content> contentList;
  final bool isOriginals;

  const ContentList({Key? key,required this.contentList,
    required this.title,
     this.isOriginals=false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
return Padding(padding: EdgeInsets.symmetric(vertical: 6.0),
  child:Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
Padding(padding: EdgeInsets.symmetric(horizontal: 24.0),
    child:Text(title,
    style: const TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    color: Colors.white),)
),
      Container(
        height: isOriginals?500:220,
        child: FutureBuilder(
          future: getLatest(),
          builder: (context,snapshot) {
            if (snapshot.hasData) {
              List latest = snapshot.data as List;
              return ListView.builder(
                  itemCount: latest.length,
                  padding: EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 16.0
                  ),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final Content content = contentList[index];
                    return GestureDetector(
                      onTap: () => Navigator.push(context, 
                          MaterialPageRoute(builder: (context)=>
                              MovieScreen(movie: latest[index]))),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        height: isOriginals ? 400.0 : 200.0,
                        width: isOriginals ? 200.0 : 130.0,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    'http://image.tmdb.org/t/p/w500'
                                        + latest[index]["poster_path"]),
                                fit: BoxFit.cover
                            )
                        ),
                      ),
                    );
                  });
            }
            return Container();
          }
        ),
      )
    ]
  )
    );
  }
}