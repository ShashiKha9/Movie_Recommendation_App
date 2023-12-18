import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:excel/excel.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:netflix_clone/models/topRatedModel.dart';

import 'movie.dart';
import 'movieModel.dart';

final latestUrl= Uri.parse(
    "https://api.themoviedb.org/3/movie/now_playing?api_key=cbe53c92b7ca5adb0d70ed0f27fd9432");

final popularUrl=Uri.parse(
    "https://api.themoviedb.org/3/movie/popular?api_key=cbe53c92b7ca5adb0d70ed0f27fd9432");

final upcomingUrl= Uri.parse(
    "https://api.themoviedb.org/3/movie/upcoming?api_key=cbe53c92b7ca5adb0d70ed0f27fd9432");

final topRatedUrl=Uri.parse(
    "https://api.themoviedb.org/3/movie/top_rated?api_key=cbe53c92b7ca5adb0d70ed0f27fd9432");

final fetchPoster =Uri.parse("https://api.themoviedb.org/3/movie/{}?api_key=cbe53c92b7ca5adb0d70ed0f27fd9432");

final reviews =Uri.parse("https://api.themoviedb.org/3/movie/299054/reviews?api_key=cbe53c92b7ca5adb0d70ed0f27fd9432");





getLatest() async {
  final response = await http.get(latestUrl);
  Map<String,dynamic> map = json.decode(response.body);
  List<dynamic>data=map["results"];
  print(data);
  return data;
  // final response = await http.get(latestUrl);
  // Map<String,dynamic> map = json.decode(response.body);
  // List<dynamic>data=map["results"];
  // print(data[11]["original_title"]);
}


getPopular() async {
  final response = await http.get(popularUrl);
  Map<String,dynamic> map = json.decode(response.body);
  List<dynamic>data=map["results"];
  // print(data);
  return data;
}
getUpcoming() async {
  final response = await http.get(upcomingUrl);
  Map<String,dynamic> map = json.decode(response.body);
  List<dynamic>data=map["results"];
  // print(data);
  return data;
}
 Future<TopRatedModel>getTopRated() async {
   print("shashi 1: ");
  final response = await http.get(topRatedUrl);
   print("shashi 3: ");
  // Map<String,dynamic> map = json.decode(response.body);
   print("shashi 4: ");
   Map<String, dynamic> json = jsonDecode(response.body);

  // TopRatedModel data=response.body as TopRatedModel;
   print("shashi 5: ");

  print("shashi 2: $json");
  return TopRatedModel.fromJson(json);
}


getWeather() async {
  final response= await http.get(Uri.parse("http://www.7timer.info/bin/api.pl?lon=113.17&lat=23.09&product=astro&output=jsonri"));
 Map<String,dynamic> map = json.decode(response.body);
 List<dynamic> data = map["dataseries"];
 print(data[0]["timepoint"]);
 return data;
}

getReviews(int movieId) async {
  
    final response = await http.get(Uri.parse("https://api.themoviedb.org/3/movie/$movieId/reviews?api_key=cbe53c92b7ca5adb0d70ed0f27fd9432"));
    Map<String,dynamic> map = json.decode(response.body);
    List<dynamic>data=map["results"];
    print("shashi $data");
    return data;
  }


    getPoster(String movieId) async {
  final response= await http.get(Uri.parse("https://api.themoviedb.org/3/movie/$movieId?api_key=cbe53c92b7ca5adb0d70ed0f27fd9432"));
  Map<String,dynamic> map = json.decode(response.body);

  print("shashi ${map["poster_path"]}");

  return map["poster_path"];





}
// List<String> dropdownItems = [];
//
//  void loadExcel() async {
//   ByteData data = await rootBundle.load('assets/flutterexceldata.xlsx');
//   print("ashish 1:${data}");
//   List<int> bytes = data.buffer.asUint8List();
//   print("ashish 2:${bytes}");
//   var excel = Excel.decodeBytes(bytes);
//   print("ashish 3:${excel}");
//   int columnIndex = 0; // Change this to the desired column index
//   var cellValue;
//
//   print("ashish 8:${excel.tables.keys}");
//   for (var table in excel.tables.keys) {
//     print("ashish 3:${table.length}");
//     print("ashish 4:${excel.tables[table]!.maxColumns}");
//     print("ashish 5:${excel.tables[table]!.rows.length}");
//     print("ashish 6:${excel.tables[table]!.sheetName}");
//     // print(excel.tables[table].d);
//
//     print("ashish 9:${excel.tables[table]!.rows.length}");
//     for (var row in excel.tables[table]!.rows) {
//       // Access the value in the specified column
//        cellValue = row[columnIndex];
//        dropdownItems.add(cellValue);
//       print("ashish 7:${cellValue.value.toString()}");
//     }
//   }
// }



// Specify the column index (0-based) that you want to retrieve data from
int columnIndex = 0; // Change this to the desired column index


// Future loadCSV() async {
//   String csvData = await rootBundle.loadString('assets/movies.csv');
//
//   List<List<dynamic>> csvTable = CsvToListConverter().convert(csvData);
//   // print("movie: $csvTable");
//
//
//   // Assuming the CSV file has a header and "original_title" is a column name
//   int originalTitleIndex = csvTable[0].indexOf("original_title");
//
//   print("movie: ${csvTable[0][44]}");
//   for (int i = 1; i <= csvTable.length; i++) {
//     originalTitles.add(csvTable[i][originalTitleIndex]);
//     // print("movie: ${originalTitles}");
//
//
//   }
// }

//
// Future<List<List<dynamic>>> readMovieData() async {
//   String data = await rootBundle.loadString('assets/movies.csv');
//   List<List<dynamic>> rowsAsListOfValues = const CsvToListConverter().convert(data);
//   return rowsAsListOfValues;
// }
//
// Future<List<Movie>> getMovies() async {
//   List<List<dynamic>> movieData = await readMovieData();
//   print("movie: ${movieData}");
//
//   List<Movie> movies = [];
//   // print(movieData);
//
//   for (var row in movieData) {
//     movies.add(Movie(title: row[6]));
//     // print("movie: ${row[6]}");
//   }
//
//   return movies;
// }

Future<String?> getRecommend(String title) async {
  // final response = await http.get(Uri.parse("http://10.0.2.2:8000/movie?title=$title"), duration: Duration(seconds: 10),
  // );
  // try {
  //   var  response = await http.get(Uri.parse("http://10.0.2.2:8000/movie?title=$title"));

    // Process the response
  try {
    print("shashi 1");
    var  response = await http.get(Uri.parse("http://10.0.2.2:8000/movie?title=avatar"));
    print("shashi 2': ${response.body}");


    List<Map<String, dynamic>> jsonData = (json.decode(response.body) )
            .cast<Map<String, dynamic>>();
    print("shashi 3': $jsonData");


    List<MovieModel> movies = jsonData.map((map) => MovieModel.fromJson(map)).toList();
    print("shashi 4': ${movies[0].name}");

    return response.body.toString();
  } catch (e) {
    print("abc failed");
    return null;
  }



    // Cast each map to a Movie object
    // print('Response: ${response.body}');
 /* } on TimeoutException catch (e) {
    // Handle timeout exception
    print('Timeout: $e');

  } on SocketException catch (e) {
    // Handle socket exception
    print('Socket Exception: $e');

  } catch (e) {
    // Handle other exceptions
    print('Error: $e');

  }*/


  // print("abc"+  response.body);
  // List<MovieModel> test = response as List<MovieModel>;
  // List<Map<String, dynamic>> data  = json.decode(response.body);
  // List<Map<String, dynamic>> jsonList = [

  //   {
  //     "Genres": "['Action', 'Adventure', 'Fantasy']",
  //     "Id": "19995",
  //     "Name": "avatar"
  //   },
  //   // ... (add other movie entries here)
  // ];
  // List<MovieModel> movies = data.map((json) => MovieModel.fromJson(json)).toList();






  // print("shashi+ ${getPoster(movies[0].id)}");
  // final response = await http.get(latestUrl);
  // Map<String,dynamic> map = json.decode(response.body);
  // List<dynamic>data=map["results"];
  // print(data[11]["original_title"]);
}