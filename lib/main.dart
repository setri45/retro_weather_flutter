import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:retro_weather_flutter/widgets/weather_icon_painter.dart';
import 'package:retro_weather_flutter/widgets/weather_info_tile.dart';
import 'package:retro_weather_flutter/widgets/forecast_tile.dart';
import 'package:retro_weather_flutter/views/weather_home_page_view.dart';
import 'package:provider/provider.dart';
import 'package:retro_weather_flutter/viewmodels/weather_viewmodel.dart';
import 'views/main_navigation_view.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => WeatherViewModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Retro Weather',
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.grey[200],
        fontFamily: 'Audiowide',
      ),
      home: const MainNavigationView(),
    );
  }
}
