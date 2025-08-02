import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retro_weather_flutter/models/weather_data.dart';
import 'package:retro_weather_flutter/viewmodels/weather_viewmodel.dart';
import 'package:retro_weather_flutter/widgets/forecast_tile.dart';
import 'package:retro_weather_flutter/widgets/weather_icon_painter.dart';
import 'package:retro_weather_flutter/widgets/weather_info_tile.dart';
import 'package:retro_weather_flutter/views/city_search_modal.dart';
import 'package:retro_weather_flutter/models/city_suggestion.dart';

class WeatherHomePageView extends StatefulWidget {
  const WeatherHomePageView({super.key});

  @override
  State<WeatherHomePageView> createState() => _WeatherHomePageViewState();
}

class _WeatherHomePageViewState extends State<WeatherHomePageView> {
  @override
  void initState() {
    super.initState();
    // Charger la météo au démarrage
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WeatherViewModel>().loadWeather();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<WeatherViewModel>();
    double iconSize = MediaQuery.of(context).size.width * 0.8;
    iconSize = iconSize > 400 ? 400 : iconSize;

    // Sélection des prévisions horaires réelles (+1h, +5h, +12h)
    List<HourlyForecast> forecasts = vm.weatherData?.hourlyForecasts ?? [];
    DateTime now = DateTime.now();
    HourlyForecast? forecast1h;
    HourlyForecast? forecast5h;
    HourlyForecast? forecast12h;
    if (forecasts.isNotEmpty) {
      forecast1h = forecasts
          .where((f) => f.time.isAfter(now))
          .firstWhere(
            (f) => f.time.hour == (now.hour + 1) % 24,
            orElse: () => forecasts.first,
          );
      forecast5h = forecasts
          .where((f) => f.time.isAfter(now))
          .firstWhere(
            (f) => f.time.hour == (now.hour + 5) % 24,
            orElse: () => forecasts.length > 5 ? forecasts[5] : forecasts.last,
          );
      forecast12h = forecasts
          .where((f) => f.time.isAfter(now))
          .firstWhere(
            (f) => f.time.hour == (now.hour + 12) % 24,
            orElse: () => forecasts.length > 12 ? forecasts[12] : forecasts.last,
          );
    }

    return Scaffold(
      body: SafeArea(
        child: Center(
          child:
              vm.error != null
                  ? Text(vm.error!, style: const TextStyle(color: Colors.red))
                  : vm.isLoading
                  ? const CircularProgressIndicator()
                  : vm.weatherData == null
                  ? const CircularProgressIndicator()
                  : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 32),
                      // Ville et pays
                      Column(
                        children: [
                          InkWell(
                            onTap: () async {
                              await showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) => CitySearchModal(
                                  onCitySelected: (CitySuggestion suggestion) async {
                                    Navigator.of(context).pop();
                                    await vm.loadWeatherByCoordinates(
                                      latitude: suggestion.lat,
                                      longitude: suggestion.lon,
                                    );
                                  },
                                  onGeolocSelected: () async {
                                    Navigator.of(context).pop();
                                    await vm.loadWeather();
                                  },
                                ),
                              );
                            },
                            child: Column(
                        children: [
                          Text(
                            vm.weatherData!.city,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 22,
                              fontFamily: 'Audiowide',
                              letterSpacing: 1.5,
                                    color: Colors.black,
                            ),
                          ),
                          Text(
                            vm.weatherData!.country,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Audiowide',
                              color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Section températures (min, actuelle, max)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Température minimale réelle
                          Column(
                            children: [
                              const Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.black87,
                                size: 48,
                              ),
                              Text(
                                '${vm.weatherData!.minTempC.round()}°',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontFamily: 'Audiowide',
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          // Température actuelle
                          Text(
                            '${vm.weatherData!.tempC.round()}°',
                            style: const TextStyle(
                              fontSize: 64,
                              fontFamily: 'Audiowide',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // Température maximale réelle
                          Column(
                            children: [
                              const Icon(
                                Icons.keyboard_arrow_up,
                                color: Colors.black87,
                                size: 48,
                              ),
                              Text(
                                '${vm.weatherData!.maxTempC.round()}°',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontFamily: 'Audiowide',
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Zone CustomPaint pour l'icône météo
                      Container(
                        width: iconSize,
                        height: iconSize * 0.7,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: CustomPaint(
                            painter: WeatherIconPainter(
                              code: vm.weatherData!.conditionCode,
                              isDay: vm.weatherData!.isDay,
                            ),
                            child: Container(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Bloc neumorphic avec condition météo et infos
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 24.0),
                        padding: const EdgeInsets.all(24.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[400]!,
                              offset: const Offset(8, 8),
                              blurRadius: 15,
                              spreadRadius: 1,
                            ),
                            BoxShadow(
                              color: Colors.white,
                              offset: const Offset(-4, -4),
                              blurRadius: 15,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            // Condition météo
                            Text(
                              vm.weatherData!.conditionText,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 18,
                                fontFamily: 'Audiowide',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 20),
                            // Infos complémentaires
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                WeatherInfoTile(
                                  label: 'RESSENTI',
                                  value:
                                      '${vm.weatherData!.feelsLikeC.round()}°',
                                ),
                                WeatherInfoTile(
                                  label: 'VENT',
                                  value:
                                      '${vm.weatherData!.windKph.round()} KM/H',
                                ),
                                WeatherInfoTile(
                                  label: 'VISIBILITÉ',
                                  value: '${vm.weatherData!.visKm} KM',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Bloc neumorphic des prévisions (vraies données)
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 24.0),
                        padding: const EdgeInsets.all(24.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[400]!,
                              offset: const Offset(8, 8),
                              blurRadius: 15,
                              spreadRadius: 1,
                            ),
                            BoxShadow(
                              color: Colors.white,
                              offset: const Offset(-4, -4),
                              blurRadius: 15,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Text(
                              'PRÉVISIONS',
                              style: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'Audiowide',
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.5,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                if (forecast1h != null)
                                  ForecastTile(
                                    time: '+1H',
                                    temp: '${forecast1h.tempC.round()}°',
                                    code: forecast1h.conditionCode,
                                    isDay: forecast1h.isDay,
                                  ),
                                if (forecast5h != null)
                                  ForecastTile(
                                    time: '+5H',
                                    temp: '${forecast5h.tempC.round()}°',
                                    code: forecast5h.conditionCode,
                                    isDay: forecast5h.isDay,
                                  ),
                                if (forecast12h != null)
                                  ForecastTile(
                                    time: '+12H',
                                    temp: '${forecast12h.tempC.round()}°',
                                    code: forecast12h.conditionCode,
                                    isDay: forecast12h.isDay,
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
        ),
      ),
    );
  }
}
