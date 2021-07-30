import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:open_weather_api/models/currentWeatherModel.dart';
import 'package:open_weather_api/models/oneCallApiModel.dart';
import 'package:open_weather_api/shared/variables.dart';
 class getClass {
   var client = http.Client();

   // for current weather
   Future<CurrentWeatherModel> getCurrentWeather(city) async {
     var getCurrentWeather = null;

     try{
       var response = await client.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${apiKey}'));
       var jsonResult = jsonDecode(response.body);
       print(response.body);
       if(response.statusCode == 200 ){
         getCurrentWeather = CurrentWeatherModel.fromJson(jsonResult);
         print(getCurrentWeather);
       }
     } catch(e){
       print(e.toString());
     }
     return getCurrentWeather;
   }

   // current weather with one call api
   Future<OneCallApiModel> getCurrentWeatherOneCallApi(lon,lat) async {
     var getCurrentWeatherOneCallApi = null;

     try{
       var response = await client.get(Uri.parse('https://api.openweathermap.org/data/2.5/onecall?lat=${lat}&lon=${lon}&appid=${apiKey}&units=metric'));
       var jsonResult = jsonDecode(response.body);
       print(response.body);
       if(response.statusCode == 200 ){
         getCurrentWeatherOneCallApi = OneCallApiModel.fromJson(jsonResult);
         print(getCurrentWeatherOneCallApi);
       }
     } catch(e){
       print(e.toString());
     }
     return getCurrentWeatherOneCallApi;
   }
 }