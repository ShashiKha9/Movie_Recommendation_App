import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_clone/cubit/appbar_cubit.dart';
import 'package:netflix_clone/models/api.dart';
import 'package:netflix_clone/models/models.dart';
import 'package:netflix_clone/netflixdata/netflixdata.dart';
import 'package:netflix_clone/widgets/Previews.dart';
import 'package:netflix_clone/widgets/content_header.dart';
import 'package:netflix_clone/widgets/content_list.dart';
import 'package:netflix_clone/widgets/customappbar.dart';

class HomeScreenPage extends StatefulWidget{
  const HomeScreenPage({Key? key}) : super(key: key);

  HomeScreenPageState createState()=> HomeScreenPageState(sintelContent);

}

class HomeScreenPageState extends State<HomeScreenPage>{
  List images=[];
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
    return
       Scaffold(
    //      appBar:PreferredSize(
    //     preferredSize: Size.fromHeight(25.0), // Set your preferred height here
    // child: AppBar(
    // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    // // Other AppBar properties go here
    // ),

         // drawer: Drawer(
         //   backgroundColor: Colors.red,
         //   child: ListView(
         //     children: [
         //       DrawerHeader(
         //         decoration: BoxDecoration(
         //             color: Theme.of(context).primaryColor
         //         ),
         //
         //         child: Text("Hey"),
         //       ),
         //       ListTile(
         //         title: const Text('Home'),
         //         // selected: _selectedIndex == 0,
         //         onTap: () {
         //           // Update the state of the app
         //           // _onItemTapped(0);
         //           // Then close the drawer
         //           Navigator.pop(context);
         //         },
         //       ),
         //     ],
         //   ),
         // ),


        backgroundColor: Theme.of(context).primaryColor,
        extendBodyBehindAppBar: true,
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: Colors.grey[850],
        //   child: Icon(Icons.cast),
        //   onPressed: ()=> print("Cast"),
        // ),
      //   appBar: PreferredSize(
      //     preferredSize: Size(screenSize.width,50.0),
      //     child: BlocBuilder<AppBarCubit,double>(
      //       builder: (context,_scrollOffset){
      //         return   CustomAppBar(scrollOffset: _scrollOffset);
      // },
      //     )
      //   ),
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: ContentList(
                futuredata: getTopRated(),
                title: "",
                isCarousel: true,
                futuredata1: getTopRated(),
              ),
              // child: CarouselSlider(
              //     options: CarouselOptions(
              //       height: 400.0,
              //       enlargeCenterPage: true,
              //       autoPlay: true,
              //       aspectRatio: 16 / 9,
              //       autoPlayCurve: Curves.fastOutSlowIn,
              //       enableInfiniteScroll: true,
              //       viewportFraction: 0.8,
              //     ), items: [
              //
              //
              //         ContentList(
              //           futuredata: getTopRated(),
              //           title: "",
              //
              //       )
              // ],),
            ),
            // SliverToBoxAdapter(
            //   child: SizedBox(
            //     width: double.infinity,
            //     child: CarouselSlider.builder(
            //       itemCount: 10,
            //         options: CarouselOptions(
            //           height: 200,
            //           autoPlay: true,
            //           aspectRatio: 16/9,
            //           enlargeCenterPage: true,
            //           pageSnapping: true,
            //           autoPlayCurve: Curves.fastOutSlowIn,
            //           viewportFraction: 0.55
            //         ),
            //     itemBuilder: (context,index,realIndex) {
            //           return ClipRRect(
            //             borderRadius: BorderRadius.circular(12),
            //             child: Container(
            //               height: 200,
            //               width: 300,
            //               child: ContentList(futuredata: getTopRated(), title: "",),
            //
            //             ),
            //           );
            //
            //     }),
            //   ),
            // ),
            // SliverToBoxAdapter(
            //   child: ContentHeader(featuredContent:sintelContent ),
            // ),
            // SliverPadding(padding: const EdgeInsets.only(top: 20.0),
            //   sliver: SliverToBoxAdapter(
            //     child: Previews(
            //       key: PageStorageKey("previews"),
            //       title: 'Previews', contentList: previews,),
            //   ),
            // ),
            SliverToBoxAdapter(
              child: ContentList(
                key: PageStorageKey("myList"),
                title: "Latest",
                futuredata: getLatest(),
              ),
            ),
            SliverToBoxAdapter(
              child: ContentList(
                  key: PageStorageKey("originals"),
                  title: "Popular",
                futuredata: getUpcoming(),
                isOriginals:true,

              ),
            ),
            SliverPadding(padding: EdgeInsets.only(bottom: 20.0),
            sliver:SliverToBoxAdapter(
              child: ContentList(
                key: PageStorageKey("trending"),
                title: "Trending",
                futuredata: getPopular(),
              ),
            ),
            ),
          ],
        ),

    );

  }
}