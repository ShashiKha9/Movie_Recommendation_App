import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix_clone/models/api.dart';
import 'package:http/http.dart' as http;


class SearchScreenPage extends StatefulWidget {
  const SearchScreenPage({Key? key}) : super(key: key);

  @override
  State<SearchScreenPage> createState() => _SearchScreenPageState();
}

class _SearchScreenPageState extends State<SearchScreenPage> {
  _SearchScreenPageState(){
    _filter.addListener(() {
      if(_filter.text.isEmpty){
        setState((){
          _searchText="";
            filteredmovies=movies;
        });
      }else{
        setState((){
          _searchText= _filter.text;
        });
      }
    });
  }
  final _filter = TextEditingController();
  String _searchText="";
  List movies= [];
  List filteredmovies=[];

void  _getMovies() async {
      final response = await http.get(Uri.parse("https://api.themoviedb.org/3/movie/top_rated?api_key=cbe53c92b7ca5adb0d70ed0f27fd9432"));
      Map<String,dynamic> map = json.decode(response.body);
      List<dynamic>data=map["results"];
      // print(data);


    List tempList= [];
    for(int i =0;i<data.length;i++){
      tempList.add(data[i]);
    }
    setState((){
      movies=tempList;
      filteredmovies=movies;
    });
  }


  Widget buildList(){
    if(!(_searchText.isEmpty)){
      List tempList = [];
      for(int i =0;i<filteredmovies.length;i++){
        if(filteredmovies[i]["title"]
            .toLowerCase()
            .contains(_searchText.toLowerCase())){
          tempList.add(filteredmovies[i]);
        }
      }
      filteredmovies=tempList;
    }
    return Container(
      decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(12)
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        separatorBuilder: (context, index) {
          return SizedBox(height: 3,);
        },
        itemCount:filteredmovies.length,
        itemBuilder: (context, index) {
          return InkWell(
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff251546).withOpacity(0.1),
                borderRadius: BorderRadius.circular(13),

                
              ),
              child: ListTile(
                leading: Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                          image: NetworkImage(
                              'http://image.tmdb.org/t/p/w500' +
                                  filteredmovies[index]["backdrop_path"]))
                  ),
                ),
                title: Text(filteredmovies[index]["title"],
                  maxLines: 2,
                    style: GoogleFonts.lato(color: Colors.white70,fontSize: 16)),
                subtitle: Text(filteredmovies[index]['release_date'].toString().substring(0,4),
                style: GoogleFonts.lato(color: Colors.white38,fontSize: 13),),

                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(filteredmovies[index]['vote_average'].toString().substring(0,3),
                      style: GoogleFonts.lato(color: Colors.white70,fontSize: 14),),
                    SizedBox(
                      width: 4,
                    ),
                    Icon(Icons.star,color: Colors.yellow,size: 18,)
                  ],
                )
           
              ),
            ),
            onTap: (){},
          );
        },
      ),
    );
  }

  @override
  void initState(){
    _getMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(12),
              child: TextFormField(
                controller: _filter,
                style: TextStyle(color: Colors.white70),
                cursorHeight: 20,
                cursorColor: Colors.white,
                decoration: InputDecoration(

                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)
                  ),
                  fillColor:Color(0xff251546).withOpacity(0.6),
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
                      style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w600
                      ),),
                  ),
                       buildList(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
