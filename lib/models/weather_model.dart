class Weather {
  final String cityName;
  final String country;
  final double temperature;
  final String description;
  final int humidity;
  final double windSpeed;
  final int sunrise;
  final int sunset;
  final int timezone;

  Weather({
    required this.cityName,
    required this.country,
    required this.temperature,
    required this.description,
    required this.humidity,
    required this.windSpeed,
    required this.sunrise,
    required this.sunset,
    required this.timezone
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'] ?? '',
      country: json['sys']['country'] ?? '',
      temperature: (json['main']['temp'] as num).toDouble(),
      description: json['weather'][0]['main'] ?? '',
      humidity: (json['main']['humidity'] as num).toInt(),
      windSpeed: (json['wind']['speed'] as num).toDouble(),
      sunrise: (json['sys']['sunrise'] as num).toInt(),
      sunset: (json['sys']['sunset'] as num).toInt(),
      timezone: (json['timezone'] as num).toInt()
    );
  }
}
