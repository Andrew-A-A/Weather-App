import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:iclub/Model/WeatherInfo.dart';

Future<WeatherInfo> fetchWeather() async {
  final response = await
  http.get(Uri.parse('http://api.weatherapi.com/v1/current.json?key=d1db04cf06794f8993242019230209&q=Egypt&aqi=no'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return WeatherInfo.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load weather');
  }
}