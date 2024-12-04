import 'package:flutter/material.dart';
import 'package:flutter_weather_api/main/view/weather.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'open weather api',
      home: WeatherScreen(),
    );
  }
}