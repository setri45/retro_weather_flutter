import 'package:geolocator/geolocator.dart';
import 'package:retro_weather_flutter/models/location_data.dart';

class LocationService {
  Future<LocationData> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Les services de localisation sont désactivés.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('La permission de localisation a été refusée.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('La permission de localisation est refusée définitivement.');
    }

    final position = await Geolocator.getCurrentPosition();
    return LocationData.fromPosition(position);
  }
} 