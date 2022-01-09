import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_clone/cubit/appbar_cubit.dart';
import 'package:netflix_clone/models/models.dart';
import 'package:netflix_clone/netflixdata/netflixdata.dart';
import 'package:netflix_clone/widgets/Previews.dart';
import 'package:netflix_clone/widgets/content_header.dart';
import 'package:netflix_clone/widgets/content_list.dart';
import 'package:netflix_clone/widgets/customappbar.dart';
import 'package:bloc/bloc.dart';

class HomeScreenPage extends StatefulWidget{
  const HomeScreenPage({Key? key}) : super(key: key);

  HomeScreenPageState createState()=> HomeScreenPageState(sintelContent);

}


class HomeScreenPageState extends State<HomeScreenPage>{
   final Content sintelContent;
   HomeScreenPageState(this.sintelContent);


   late ScrollController _scrollController;
  @override
  void initState(){
    _scrollController= ScrollController()..addListener(() {
      BlocProvider.of<AppBarCubit>(context).setOffset(_scrollController.offset);

      setState(() {

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
        child: BlocBuilder<AppBarCubit,double>(
          builder: (context,_scrollOffset){
            return   CustomAppBar(scrollOffset: _scrollOffset,);
    },
        )
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: ContentHeader(featuredContent:sintelContent ),
          ),
          SliverPadding(padding: const EdgeInsets.only(top: 20.0),
            sliver: SliverToBoxAdapter(
              child: Previews(
                key: PageStorageKey("previews"),
                title: 'Previews', contentList: previews,),
            ),
          ),
          SliverToBoxAdapter(
            child: ContentList(
              key: PageStorageKey("myList"),
              title: "My List",
              contentList:myList,
            ),
          ),
          SliverToBoxAdapter(
            child: ContentList(
                key: PageStorageKey("originals"),
                title: "Netflix Originals",
              contentList:originals,
              isOriginals:true

            ),
          ),
          SliverPadding(padding: EdgeInsets.only(bottom: 20.0),
          sliver:SliverToBoxAdapter(
            child: ContentList(
              key: PageStorageKey("trending"),
              title: "Trending",
              contentList:trending,
            ),
          ),
          ),
        ],
      ),
    );

  }
}