import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/models/weather_model.dart';
import 'package:lottie/lottie.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard({super.key, required this.weather});
  final Weather weather;

  String formatTime(int timestamp, int timezone) {
    final date = DateTime.fromMillisecondsSinceEpoch(
      (timestamp + timezone) * 1000,
      isUtc: true,
    );
    return DateFormat('hh:mm a').format(date);
  }

  String getAnimationAsset() {
    final desc = weather.description.toLowerCase();

    if (desc.contains('rain')) {
      return 'assets/rain.json';
    } else if (desc.contains('clear')) {
      return 'assets/sunny.json';
    } else if (desc.contains('cloud') || desc.contains('overcast')) {
      return 'assets/cloudy.json';
    } else if (desc.contains('snow')) {
      return 'assets/snowfall.json';
    } else {
      return 'assets/sunny.json'; // fallback
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.2),
            Colors.white.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(getAnimationAsset(), height: 150, width: 150),

          const SizedBox(height: 12),

          Text(
            '${weather.cityName}, ${weather.country}',
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black38,
                  blurRadius: 4,
                  offset: Offset(2, 2),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          Text(
            '${weather.temperature.toStringAsFixed(1)}°C',
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black38,
                  blurRadius: 6,
                  offset: Offset(2, 2),
                ),
              ],
            ),
          ),

          const SizedBox(height: 6),

          // Weather Description
          Text(
            weather.description.toUpperCase(),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white70,
              letterSpacing: 1.1,
            ),
          ),

          const SizedBox(height: 20),

          // Humidity & Wind
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const Icon(
                    Icons.water_drop,
                    color: Color.fromARGB(204, 7, 59, 83),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${weather.humidity}%",
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    "Humidity",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const Icon(Icons.air, color: Colors.white),
                  const SizedBox(height: 4),
                  Text(
                    "${weather.windSpeed} m/s",
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    "Wind",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Sunrise & Sunset
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const Icon(
                    Icons.wb_sunny_outlined,
                    color: Colors.yellowAccent,
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Sunrise",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    formatTime(weather.sunrise, weather.timezone),
                    style: const TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const Icon(
                    Icons.nights_stay_outlined,
                    color: Color.fromARGB(178, 0, 0, 0),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Sunset",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    formatTime(weather.sunset, weather.timezone),
                    style: const TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
