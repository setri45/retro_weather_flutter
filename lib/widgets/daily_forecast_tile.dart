import 'package:flutter/material.dart';
import 'package:retro_weather_flutter/models/daily_forecast.dart';
import 'package:retro_weather_flutter/widgets/weather_icon_painter.dart';

class DailyForecastTile extends StatelessWidget {
  final DailyForecast forecast;

  const DailyForecastTile({Key? key, required this.forecast}) : super(key: key);

  String getDayName(DateTime date) {
    const days = ['Lun.', 'Mar.', 'Mer.', 'Jeu.', 'Ven.', 'Sam.', 'Dim.'];
    return days[date.weekday - 1];
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          height: constraints.maxHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Jour
              Text(
                getDayName(forecast.date),
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'Audiowide',
                  color: Colors.black54,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 8),
              // Icône météo
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: AspectRatio(
                  aspectRatio: 60 / 42,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CustomPaint(
                        painter: WeatherIconPainter(
                          code: forecast.conditionCode,
                          isDay: forecast.isDay,
                        ),
                        child: Container(),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // Températures min/max
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    children: [
                      const Icon(Icons.keyboard_arrow_down, size: 18),
                      Text(
                        '${forecast.minTempC.round()}°',
                        style: const TextStyle(fontSize: 14, fontFamily: 'Audiowide'),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Icon(Icons.keyboard_arrow_up, size: 18),
                      Text(
                        '${forecast.maxTempC.round()}°',
                        style: const TextStyle(fontSize: 14, fontFamily: 'Audiowide'),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
