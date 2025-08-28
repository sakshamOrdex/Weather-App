import 'package:weather/models/weather_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherService {
  final String apiKey = "848cf000db87965f2c1ed25e53fe7aff";

  Future<Weather> fetchWeather(String city) async {
    final url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric",
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      return Weather.fromJson(data);
    } else {
      final data = json.decode(response.body);
      final message = data["message"] ?? "Failed to load weather data";
      throw Exception("Error: $message");
    }
  }
}
