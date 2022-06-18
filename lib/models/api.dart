import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

final latestUrl= Uri.parse(
    "https://api.themoviedb.org/3/movie/now_playing?api_key=cbe53c92b7ca5adb0d70ed0f27fd9432");

final popularUrl=Uri.parse(
    "https://api.themoviedb.org/3/movie/popular?api_key=cbe53c92b7ca5adb0d70ed0f27fd9432");

final upcomingUrl= Uri.parse(
    "https://api.themoviedb.org/3/movie/upcoming?api_key=cbe53c92b7ca5adb0d70ed0f27fd9432");

final topRatedUrl=Uri.parse(
    "https://api.themoviedb.org/3/movie/top_rated?api_key=cbe53c92b7ca5adb0d70ed0f27fd9432");

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