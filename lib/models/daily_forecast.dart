class DailyForecast {
  final DateTime date;
  final double minTempC;
  final double maxTempC;
  final int conditionCode;
  final bool isDay;

  DailyForecast({
    required this.date,
    required this.minTempC,
    required this.maxTempC,
    required this.conditionCode,
    required this.isDay,
  });

  factory DailyForecast.fromJson(Map<String, dynamic> json) {
    return DailyForecast(
      date: DateTime.parse(json['date']),
      minTempC: (json['day']['mintemp_c'] as num).toDouble(),
      maxTempC: (json['day']['maxtemp_c'] as num).toDouble(),
      conditionCode: json['day']['condition']['code'],
      isDay: true, // On considère la prévision du jour
    );
  }
} 