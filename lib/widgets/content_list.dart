import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/models/models.dart';

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
        child: ListView.builder(
          padding: EdgeInsets.symmetric(
            vertical: 12.0,
            horizontal: 16.0
          ),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context,index){
            final Content content = contentList[index];
            return GestureDetector(
              onTap: ()=> print(content.name),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                height: isOriginals ? 400.0 :200.0,
                width: isOriginals ? 200.0 :130.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(content.imageUrl),
                    fit: BoxFit.cover
                  )
                ),
              ),
            );

            }),
      )
    ]
  )
    );
  }
}