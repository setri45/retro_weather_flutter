class CitySuggestion {
  final String name;
  final String country;
  final double lat;
  final double lon;
  final String? region;

  CitySuggestion({
    required this.name,
    required this.country,
    required this.lat,
    required this.lon,
    this.region,
  });

  factory CitySuggestion.fromJson(Map<String, dynamic> json) {
    return CitySuggestion(
      name: json['name'],
      country: json['country'],
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
      region: json['region'],
    );
  }
} 