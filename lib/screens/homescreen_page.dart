import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/models/models.dart';
import 'package:netflix_clone/netflixdata/netflixdata.dart';
import 'package:netflix_clone/widgets/Previews.dart';
import 'package:netflix_clone/widgets/content_header.dart';
import 'package:netflix_clone/widgets/content_list.dart';
import 'package:netflix_clone/widgets/customappbar.dart';

class HomeScreenPage extends StatefulWidget{
  HomeScreenPageState createState()=> HomeScreenPageState(sintelContent);

}


class HomeScreenPageState extends State<HomeScreenPage>{
   final Content sintelContent;
   HomeScreenPageState(this.sintelContent);

  double _scrollOffset=0.0;

   late ScrollController _scrollController;
  @override
  void initState(){
    _scrollController= ScrollController()..addListener(() {
      setState(() {
        _scrollOffset= _scrollController.offset;
      });
    });
    super.initState();
  }

  void dispose(){
    _scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final Size  screenSize= MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[850],
        child: Icon(Icons.cast),
        onPressed: ()=> print("Cast"),
      ),
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width,50.0),
        child: CustomAppBar(_scrollOffset),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: ContentHeader(featuredContent:sintelContent ),
          ),
          SliverPadding(padding: const EdgeInsets.only(top: 20.0),
            sliver: SliverToBoxAdapter(
              child: Previews(title: 'Previews', contentList: previews,),
            ),
          ),
          SliverToBoxAdapter(
            child: ContentList(
              title: "My List",
              contentList:myList,
            ),
          ),
          SliverToBoxAdapter(
            child: ContentList(
              title: "Netflix Originals",
              contentList:originals,
              isOriginals:true

            ),
          ),
          SliverToBoxAdapter(
            child: ContentList(
              title: "Trending",
              contentList:trending,
            ),
          ),
        ],
      ),
    );

  }
}