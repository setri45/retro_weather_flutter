// weather_condition.dart

/// Enum représentant les conditions météo de WeatherAPI.
/// Chaque valeur contient le code, l'icône, la description jour et nuit.
enum WeatherCondition {
  sunny(1000, 113, 'Sunny', 'Clear'),
  partlyCloudy(1003, 116, 'Partly Cloudy', 'Partly Cloudy'),
  cloudy(1006, 119, 'Cloudy', 'Cloudy'),
  overcast(1009, 122, 'Overcast', 'Overcast'),
  mist(1030, 143, 'Mist', 'Mist'),
  patchyRainNearby(1063, 176, 'Patchy rain nearby', 'Patchy rain nearby'),
  patchySnowNearby(1066, 179, 'Patchy snow nearby', 'Patchy snow nearby'),
  patchySleetNearby(1069, 182, 'Patchy sleet nearby', 'Patchy sleet nearby'),
  patchyFreezingDrizzleNearby(
    1072,
    185,
    'Patchy freezing drizzle nearby',
    'Patchy freezing drizzle nearby',
  ),
  thunderyOutbreaksNearby(
    1087,
    200,
    'Thundery outbreaks in nearby',
    'Thundery outbreaks in nearby',
  ),
  blowingSnow(1114, 227, 'Blowing snow', 'Blowing snow'),
  blizzard(1117, 230, 'Blizzard', 'Blizzard'),
  fog(1135, 248, 'Fog', 'Fog'),
  freezingFog(1147, 260, 'Freezing fog', 'Freezing fog'),
  patchyLightDrizzle(1150, 263, 'Patchy light drizzle', 'Patchy light drizzle'),
  lightDrizzle(1153, 266, 'Light drizzle', 'Light drizzle'),
  freezingDrizzle(1168, 281, 'Freezing drizzle', 'Freezing drizzle'),
  heavyFreezingDrizzle(
    1171,
    284,
    'Heavy freezing drizzle',
    'Heavy freezing drizzle',
  ),
  patchyLightRain(1180, 293, 'Patchy light rain', 'Patchy light rain'),
  lightRain(1183, 296, 'Light rain', 'Light rain'),
  moderateRainAtTimes(
    1186,
    299,
    'Moderate rain at times',
    'Moderate rain at times',
  ),
  moderateRain(1189, 302, 'Moderate rain', 'Moderate rain'),
  heavyRainAtTimes(1192, 305, 'Heavy rain at times', 'Heavy rain at times'),
  heavyRain(1195, 308, 'Heavy rain', 'Heavy rain'),
  lightFreezingRain(1198, 311, 'Light freezing rain', 'Light freezing rain'),
  moderateOrHeavyFreezingRain(
    1201,
    314,
    'Moderate or heavy freezing rain',
    'Moderate or heavy freezing rain',
  ),
  lightSleet(1204, 317, 'Light sleet', 'Light sleet'),
  moderateOrHeavySleet(
    1207,
    320,
    'Moderate or heavy sleet',
    'Moderate or heavy sleet',
  ),
  patchyLightSnow(1210, 323, 'Patchy light snow', 'Patchy light snow'),
  lightSnow(1213, 326, 'Light snow', 'Light snow'),
  patchyModerateSnow(1216, 329, 'Patchy moderate snow', 'Patchy moderate snow'),
  moderateSnow(1219, 332, 'Moderate snow', 'Moderate snow'),
  patchyHeavySnow(1222, 335, 'Patchy heavy snow', 'Patchy heavy snow'),
  heavySnow(1225, 338, 'Heavy snow', 'Heavy snow'),
  icePellets(1237, 350, 'Ice pellets', 'Ice pellets'),
  lightRainShower(1240, 353, 'Light rain shower', 'Light rain shower'),
  moderateOrHeavyRainShower(
    1243,
    356,
    'Moderate or heavy rain shower',
    'Moderate or heavy rain shower',
  ),
  torrentialRainShower(
    1246,
    359,
    'Torrential rain shower',
    'Torrential rain shower',
  ),
  lightSleetShowers(1249, 362, 'Light sleet showers', 'Light sleet showers'),
  moderateOrHeavySleetShowers(
    1252,
    365,
    'Moderate or heavy sleet showers',
    'Moderate or heavy sleet showers',
  ),
  lightSnowShowers(1255, 368, 'Light snow showers', 'Light snow showers'),
  moderateOrHeavySnowShowers(
    1258,
    371,
    'Moderate or heavy snow showers',
    'Moderate or heavy snow showers',
  ),
  lightShowersOfIcePellets(
    1261,
    374,
    'Light showers of ice pellets',
    'Light showers of ice pellets',
  ),
  moderateOrHeavyShowersOfIcePellets(
    1264,
    377,
    'Moderate or heavy showers of ice pellets',
    'Moderate or heavy showers of ice pellets',
  ),
  patchyLightRainThunder(
    1273,
    386,
    'Patchy light rain in area with thunder',
    'Patchy light rain in area with thunder',
  ),
  moderateOrHeavyRainThunder(
    1276,
    389,
    'Moderate or heavy rain in area with thunder',
    'Moderate or heavy rain in area with thunder',
  ),
  patchyLightSnowThunder(
    1279,
    392,
    'Patchy light snow in area with thunder',
    'Patchy light snow in area with thunder',
  ),
  moderateOrHeavySnowThunder(
    1282,
    395,
    'Moderate or heavy snow in area with thunder',
    'Moderate or heavy snow in area with thunder',
  );

  /// Code météo WeatherAPI
  final int code;

  /// Numéro d'icône associé
  final int icon;

  /// Description pour la journée
  final String day;

  /// Description pour la nuit
  final String night;

  const WeatherCondition(this.code, this.icon, this.day, this.night);

  /// Permet de retrouver une condition à partir du code météo.
  static WeatherCondition? fromCode(int code) {
    return WeatherCondition.values.firstWhere(
      (e) => e.code == code,
      orElse:
          () => throw ArgumentError('No WeatherCondition found for code $code'),
    );
  }
}
