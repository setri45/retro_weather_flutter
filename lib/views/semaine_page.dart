import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retro_weather_flutter/viewmodels/weather_viewmodel.dart';
import 'package:retro_weather_flutter/widgets/daily_forecast_tile.dart';

class SemainePage extends StatelessWidget {
  const SemainePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<WeatherViewModel>();
    if (vm.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (vm.error != null) {
      return Center(
        child: Text(vm.error!, style: const TextStyle(color: Colors.red)),
      );
    }
    final forecasts = vm.dailyForecasts;
    if (forecasts.isEmpty) {
      return const Center(child: Text("Aucune donnée météo disponible."));
    }
    return SingleChildScrollView(
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
          // Bloc neumorphic des prévisions 7 jours
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24.0),
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 16.0,
            ),
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
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.0,
              ),
              itemCount: forecasts.length,
              itemBuilder: (context, index) {
                return DailyForecastTile(forecast: forecasts[index]);
              },
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
