import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retro_weather_flutter/models/weather_data.dart';
import 'package:retro_weather_flutter/viewmodels/weather_viewmodel.dart';
import 'package:retro_weather_flutter/widgets/forecast_tile.dart';

class VingtQuatreHPage extends StatelessWidget {
  const VingtQuatreHPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<WeatherViewModel>();
    List<HourlyForecast> forecasts = vm.weatherData?.hourlyForecasts ?? [];
    DateTime now = DateTime.now();
    // Générer les prévisions pour les 18 prochaines heures
    List<HourlyForecast> next24h = [];
    if (forecasts.isNotEmpty) {
      for (int i = 1; i <= 24; i++) {
        final targetHour = (now.hour + i) % 24;
        final forecast = forecasts
            .where((f) => f.time.isAfter(now))
            .firstWhere(
              (f) => f.time.hour == targetHour,
              orElse: () => forecasts.last,
            );
        next24h.add(forecast);
      }
    }

    return Center(
      child:
          vm.error != null
              ? Text(vm.error!, style: const TextStyle(color: Colors.red))
              : vm.isLoading
              ? const CircularProgressIndicator()
              : vm.weatherData == null
              ? const CircularProgressIndicator()
              : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 32),
                    // Ville et pays
                    Column(
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
                    const SizedBox(height: 32),
                    // Bloc neumorphic des prévisions (16 prochaines heures)
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 24.0),
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
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
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 16,
                                  crossAxisSpacing: 16,
                                  childAspectRatio:
                                      0.6, // Ajuste la hauteur des tuiles
                                ),
                            itemCount: next24h.length,
                            itemBuilder: (context, index) {
                              final forecast = next24h[index];
                              final label = '+${index + 1}H';
                              return ForecastTile(
                                time: label,
                                temp: '${forecast.tempC.round()}°',
                                code: forecast.conditionCode,
                                isDay: forecast.isDay,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
    );
  }
}
