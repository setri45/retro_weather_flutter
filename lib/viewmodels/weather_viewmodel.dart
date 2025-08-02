import 'package:flutter/material.dart';
import 'package:retro_weather_flutter/models/weather_data.dart';
import 'package:retro_weather_flutter/services/location_service.dart';
import 'package:retro_weather_flutter/services/weather_api_service.dart';

import '../models/daily_forecast.dart';

class WeatherViewModel extends ChangeNotifier {
  final LocationService _locationService = LocationService();
  final WeatherApiService _weatherApiService = WeatherApiService();

  bool isLoading = false;
  WeatherData? weatherData;
  String? error;

  List<DailyForecast> get dailyForecasts => weatherData?.dailyForecasts ?? [];

  Future<void> loadWeather() async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      final location = await _locationService.getCurrentLocation();
      final data = await _weatherApiService.fetchCurrentWeather(
        latitude: location.latitude,
        longitude: location.longitude,
      );
      weatherData = data;
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadWeatherByCoordinates({
    required double latitude,
    required double longitude,
  }) async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      final data = await _weatherApiService.fetchCurrentWeather(
        latitude: latitude,
        longitude: longitude,
      );
      weatherData = data;
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
