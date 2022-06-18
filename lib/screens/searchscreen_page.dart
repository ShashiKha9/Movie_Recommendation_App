import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    return ListView.separated(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      separatorBuilder: (context, index) {
        return SizedBox(height: 3,);
      },
      itemCount:filteredmovies.length,
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
                              filteredmovies[index]["backdrop_path"]))
              ),
            ),
            title: Text(filteredmovies[index]["title"],
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
                style: TextStyle(color: Colors.white),
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
