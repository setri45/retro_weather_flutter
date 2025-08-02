import 'package:flutter/material.dart';

class WeatherInfoTile extends StatelessWidget {
  final String label;
  final String value;

  const WeatherInfoTile({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontFamily: 'Audiowide',
            color: Colors.black54,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontFamily: 'Audiowide',
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
} 