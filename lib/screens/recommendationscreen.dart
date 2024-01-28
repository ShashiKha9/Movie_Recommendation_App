import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';


import 'package:excel/excel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:netflix_clone/models/api.dart';
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/movieModel.dart';

class RecommendationScreen extends StatefulWidget {
  @override
  State<RecommendationScreen> createState() => _RecommendationScreenState();
}

class _RecommendationScreenState extends State<RecommendationScreen> {
  final _movieController = TextEditingController();

  List<MovieModel> data = []; // State variable
  List<String> dropdownItems = [];
  String? selectedValue;
  var logger = Logger();


  final List<String> imagez=[
    "/olxpyq9kJAZ2NU1siLshhhXEPR7.jpg",
    '/gh4cZbhZxyTbgxQPxD0dOudNPTn.jpg',
    "/tYfijzolzgoMOtegh1Y7j2Enorg.jpg",
    '/xezeqrrno6ytLyLrbTXRGUk4rdu.jpg',
    '/2nuUjSzHsoYlRvTPmLo7m7gCQry.jpg',
    '/tkzfAUEKoUp4YFNbZV9hfpZOz0z.jpg',
    '/qw2A587Ee61IwcSOLNFRhuOACZZ.jpg',
    '/jIfkQNARYyERqRAq1p1c8xgePp4.jpg',
    '/dGjoPttcbKR5VWg1jQuNFB247KL.jpg',
    '/euVaCiCWz3AALcQXHT6aUqdGUo6.jpg',
    '/yW9gF7rGn8EoV8B8rxOx1xjxVZf.jpg',
    '/tIDC4xT65l7a8qbgg8GvwD5g8c5.jpg',
    '/7Wdc3etyBJA4432TYtz6n9GQd1c.jpg',
    '/6E50WjeOYjDZg9HXgPjYdGtY2jG.jpg',
    '/v55tfjL3QGeabkXAMXPb4olwjL0.jpg',
    '/wDrTeDUuWf7SRQnkVea2ZpOcwnt.jpg',
    '/v6MVBFnQOscITvmAy5N5ras2JKZ.jpg',
    '/f3ldtPF7SESMcyAIyIJHBLlBBkr.jpg',
    '/b5pIUsGll0418NyfNA5eYCI9aoK.jpg',
    '/3Z2f50SKyHMWLLFH8OsV6hFoKLF.jpg'

  ];


  String? value;
  @override
  void initState(){
    super.initState();
    loadExcel();

  }
  Future<void> loadExcel() async {
    ByteData data = await rootBundle.load('assets/flutterexceldata.xlsx');
    print("ashish 1:${data}");
    List<int> bytes = data.buffer.asUint8List();
    print("ashish 2:${bytes}");
    var excel = Excel.decodeBytes(bytes);
    print("ashish 3:${excel}");
    int columnIndex = 0; // Change this to the desired column index
    var cellValue;

    print("ashish 8:${excel.tables.keys}");
    for (var table in excel.tables.keys) {
      print("ashish 3:${table.length}");
      print("ashish 4:${excel.tables[table]!.maxColumns}");
      print("ashish 5:${excel.tables[table]!.rows.length}");
      print("ashish 6:${excel.tables[table]!.sheetName}");
      // print(excel.tables[table].d);

      print("ashish 9:${excel.tables[table]!.rows.length}");
      for (var row in excel.tables[table]!.rows) {
        // Access the value in the specified column
        cellValue = row[columnIndex];
        dropdownItems.add(cellValue.value.toString());
        print("ashish 7:${cellValue.value.toString()}");
      }
    }
    setState(() {

    });
  }



  void fetchData() {
    // Simulating an API call
    Future.delayed(Duration(seconds: 2), () {
      // After the API call is successful
      setState(() {
        // data = "Updated Data"; // Update the state variable
      });
    });
  }

  void recommend(String title) async {
    try {
      print('rec1');
      print("shashi 1");
      stderr.writeln('print me');
      logger.d("kha1_request",time: DateTime.now());


      var response = await http.get(
          Uri.parse("https://flask-deployment-2-ejm8.onrender.com/"));
      print("shashi 2': ${response.body}");
      print('rec2');
      logger.d("kha2_response",time: DateTime.now());




      List<Map<String, dynamic>> jsonData = (json.decode(response.body))
          .cast<Map<String, dynamic>>();
      print("shashi 3': $jsonData");


      List<MovieModel> movies = jsonData.map((map) => MovieModel.fromJson(map))
          .toList();
      print("shashi 4': ${movies[0].name}");



      setState(() {
        data = movies;

      });
    } catch (e) {
      setState(() {
        data = [];
      });
      print("abc failed:" + e.toString());
      return null;
    }
  }








  @override
  Widget build(BuildContext context) {
    return
      SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 130,top: 10),
              child: Text("Recommend's for you",style: GoogleFonts.lato(
                  color: Colors.white38,fontSize: 24),),
            ),
            IconButton(
              icon: Icon(Icons.refresh), // Replace with your custom icon
              onPressed: () {
                recommend("a");
              },
            ),
            Container(
              width: 300,
              decoration: BoxDecoration(
                color: Color(0xff251546),
                borderRadius: BorderRadius.circular(10)
              ),
              child: DropdownButtonHideUnderline(
                child: ButtonTheme(
                  child:
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: DropdownButton<String>(
                    hint: new Text("Select a movie",
                      style: GoogleFonts.lato(color: Colors.white70),),
                    isExpanded: true,
                    dropdownColor: Color(0xff251546),

                    value: dropdownItems.isNotEmpty ? selectedValue: null,
                    onChanged: (String? newValue) {
                      // / Handle dropdown value change
                      print("Selected value: $newValue");
                      setState(() {
                        selectedValue=newValue! ?? "";
                      });
                      recommend(newValue!);
                      print("Current value after setState: $selectedValue");// You can perform additional actions bas
                    },
                    items: dropdownItems.map(( String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,
                            style: TextStyle(color: Colors.white70)),
                      );
                    },).toList(),


                  ),
                ),
              ),
            ),
            ),
            SizedBox(height: 15,),

            data.isNotEmpty ?
            Expanded(
              child: FutureBuilder(

                builder: (context,snapshot) {
                  // var data = snapshot.data as Map;
                 return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  ),
                  itemCount: data.length, // Number of items in the grid
                  itemBuilder: (BuildContext context, int index) {

                  return Container(
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                  image:
                  NetworkImage('http://image.tmdb.org/t/p/w500' + imagez[index]
                  ),
                    fit: BoxFit.cover,



                  ),
                  ),




                  );
                  },
                  );
                  
                }
              )
            ): Center(heightFactor: 12,child: Text("Get recommendations for\nyour favourite movie",
              style: GoogleFonts.lato(color: Colors.white38,fontSize: 18,fontWeight: FontWeight.w400),))
          ],
        ),
    ),
      );
  }

}

