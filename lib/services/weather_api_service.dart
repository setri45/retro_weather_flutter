import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:retro_weather_flutter/models/weather_data.dart';
import 'package:retro_weather_flutter/models/city_suggestion.dart';

class WeatherApiService {
  static const String _apiKey = '1f4ba314cf86448a89b144256252606';
  static const String _baseUrl = 'https://api.weatherapi.com/v1';

  Future<WeatherData> fetchCurrentWeather({required double latitude, required double longitude}) async {
    final url = Uri.parse('$_baseUrl/forecast.json?key=$_apiKey&q=$latitude,$longitude&lang=fr&days=7');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return WeatherData.fromJson(data);
    } else {
      throw Exception('Erreur lors de la récupération de la météo.');
    }
  }

  Future<List<CitySuggestion>> autocompleteCity(String query) async {
    final url = Uri.parse('$_baseUrl/search.json?key=$_apiKey&q=$query&lang=fr');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => CitySuggestion.fromJson(item)).toList();
    } else {
      throw Exception('Erreur lors de la recherche de ville.');
    }
  }
} 