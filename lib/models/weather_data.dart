import 'daily_forecast.dart';

class WeatherData {
  final String city;
  final String country;
  final double tempC;
  final double feelsLikeC;
  final int conditionCode;
  final String conditionText;
  final bool isDay;
  final double windKph;
  final double visKm;
  final double minTempC;
  final double maxTempC;
  final List<HourlyForecast> hourlyForecasts;
  final List<DailyForecast> dailyForecasts;

  WeatherData({
    required this.city,
    required this.country,
    required this.tempC,
    required this.feelsLikeC,
    required this.conditionCode,
    required this.conditionText,
    required this.isDay,
    required this.windKph,
    required this.visKm,
    required this.minTempC,
    required this.maxTempC,
    required this.hourlyForecasts,
    required this.dailyForecasts,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    final forecastDays = json['forecast']?['forecastday'] as List<dynamic>?;
    final forecastDay = forecastDays != null && forecastDays.isNotEmpty ? forecastDays[0] : null;
    final day = forecastDay?['day'];
    final hours = forecastDay?['hour'] as List<dynamic>?;
    return WeatherData(
      city: json['location']['name'],
      country: json['location']['country'],
      tempC: (json['current']['temp_c'] as num).toDouble(),
      feelsLikeC: (json['current']['feelslike_c'] as num).toDouble(),
      conditionCode: json['current']['condition']['code'],
      conditionText: json['current']['condition']['text'],
      isDay: json['current']['is_day'] == 1,
      windKph: (json['current']['wind_kph'] as num).toDouble(),
      visKm: (json['current']['vis_km'] as num).toDouble(),
      minTempC: day != null ? (day['mintemp_c'] as num).toDouble() : 0.0,
      maxTempC: day != null ? (day['maxtemp_c'] as num).toDouble() : 0.0,
      hourlyForecasts: hours != null
          ? hours.map((h) => HourlyForecast.fromJson(h)).toList()
          : [],
      dailyForecasts: forecastDays != null
          ? forecastDays.map((d) => DailyForecast.fromJson(d)).toList()
          : [],
    );
  }
}

class HourlyForecast {
  final DateTime time;
  final double tempC;
  final int conditionCode;
  final bool isDay;

  HourlyForecast({
    required this.time,
    required this.tempC,
    required this.conditionCode,
    required this.isDay,
  });

  factory HourlyForecast.fromJson(Map<String, dynamic> json) {
    return HourlyForecast(
      time: DateTime.parse(json['time']),
      tempC: (json['temp_c'] as num).toDouble(),
      conditionCode: json['condition']['code'],
      isDay: json['is_day'] == 1,
    );
  }
} 