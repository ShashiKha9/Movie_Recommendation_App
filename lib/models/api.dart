import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;

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
 getTopRated() async {
  final response = await http.get(topRatedUrl);
  Map<String,dynamic> map = json.decode(response.body);
  List<dynamic>data=map["results"];
  // print(data);
  return data;
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


  Future<String> getPoster(String movieId) async {
  final response= await http.get(Uri.parse("https://api.themoviedb.org/3/movie/$movieId?api_key=cbe53c92b7ca5adb0d70ed0f27fd9432"));
  Map<String,dynamic> map = json.decode(response.body);

  print("shashi ${map["poster_path"]}");

  return map["poster_path"];





}

Future<List<MovieModel>> getRecommend(String title) async {
  // final response = await http.get(Uri.parse("http://10.0.2.2:8000/movie?title=$title"), duration: Duration(seconds: 10),
  // );
  try {
    var  response = await http.get(Uri.parse("http://10.0.2.2:8000/movie?title=$title"))
        .timeout(const Duration(seconds: 2),
    onTimeout: (){
          return http.Response('sError',408);
    });
    // Process the response

    List<Map<String, dynamic>> jsonData = (json.decode(response.body) )
        .cast<Map<String, dynamic>>();

    List<MovieModel> movies = jsonData.map((map) => MovieModel.fromJson(map)).toList();

    return movies;


    // Cast each map to a Movie object
    print('Response: ${response.body}');
  } on TimeoutException catch (e) {
    // Handle timeout exception
    print('Timeout: $e');

  } on SocketException catch (e) {
    // Handle socket exception
    print('Socket Exception: $e');

  } catch (e) {
    // Handle other exceptions
    print('Error: $e');

  }


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






return null!;
  // print("shashi+ ${getPoster(movies[0].id)}");
  // final response = await http.get(latestUrl);
  // Map<String,dynamic> map = json.decode(response.body);
  // List<dynamic>data=map["results"];
  // print(data[11]["original_title"]);
}