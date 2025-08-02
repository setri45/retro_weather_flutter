import 'package:flutter/material.dart';
import 'package:retro_weather_flutter/models/city_suggestion.dart';
import 'package:retro_weather_flutter/services/weather_api_service.dart';
import 'package:retro_weather_flutter/services/location_service.dart';
import 'package:retro_weather_flutter/models/location_data.dart';

class CitySearchViewModel extends ChangeNotifier {
  final WeatherApiService _weatherApiService = WeatherApiService();
  final LocationService _locationService = LocationService();

  List<CitySuggestion> suggestions = [];
  bool isLoading = false;
  String? error;

  Future<void> searchCity(String query) async {
    if (query.isEmpty) {
      suggestions = [];
      notifyListeners();
      return;
    }
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      suggestions = await _weatherApiService.autocompleteCity(query);
    } catch (e) {
      error = e.toString();
      suggestions = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<LocationData?> useGeolocation() async {
    try {
      return await _locationService.getCurrentLocation();
    } catch (e) {
      error = e.toString();
      notifyListeners();
      return null;
    }
  }

  void clearSuggestions() {
    suggestions = [];
    notifyListeners();
  }
} 