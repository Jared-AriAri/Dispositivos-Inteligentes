class Weather {
  final String city;
  final int temperature;
  final String condition;
  final String description;
  final int humidity;
  final double windSpeed;

  Weather({
    required this.city,
    required this.temperature,
    required this.condition,
    required this.description,
    required this.humidity,
    required this.windSpeed,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    if (!json.containsKey('main') || !json.containsKey('weather')) {
      throw const FormatException('Respuesta API incompleta');
    }

    final weatherList = json['weather'] as List;
    if (weatherList.isEmpty) {
      throw const FormatException('Sin datos de clima');
    }

    final temp = json['main']['temp'];
    if (temp is! num) {
      throw const FormatException('Temperatura inválida');
    }

    return Weather(
      city: json['name'] ?? 'Desconocido',
      temperature: temp.toInt(),
      condition: weatherList[0]['main'] ?? 'Desconocido',
      description: weatherList[0]['description'] ?? '',
      humidity: (json['main']['humidity'] ?? 0) as int,
      windSpeed: ((json['wind']?['speed']) ?? 0).toDouble(),
    );
  }

  @override
  String toString() =>
      'Weather($city: ${temperature}°C, $condition, $humidity%, ${windSpeed}m/s)';
}
