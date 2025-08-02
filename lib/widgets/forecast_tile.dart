import 'package:flutter/material.dart';
import 'package:retro_weather_flutter/widgets/weather_icon_painter.dart';

class ForecastTile extends StatelessWidget {
  final String time;
  final String temp;
  final int code;
  final bool isDay;

  const ForecastTile({
    super.key,
    required this.time,
    required this.temp,
    required this.code,
    required this.isDay,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Heure
        Text(
          time,
          style: const TextStyle(
            fontSize: 14,
            fontFamily: 'Audiowide',
            color: Colors.black54,
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 12),
        // Icône météo
        Container(
          width: 60,
          height: 42,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CustomPaint(
              painter: WeatherIconPainter(
                code: code,
                isDay: isDay,
              ),
              child: Container(),
            ),
          ),
        ),
        const SizedBox(height: 8),
        // Température
        Text(
          temp,
          style: const TextStyle(
            fontSize: 16,
            fontFamily: 'Audiowide',
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
} 