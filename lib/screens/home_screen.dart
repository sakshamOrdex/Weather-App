import 'package:flutter/material.dart';
import 'package:weather/models/weather_model.dart';
import 'package:weather/services/weather_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WeatherService _weatherService = WeatherService();
  bool isLoading = false;
  Weather? _weather;
  final TextEditingController _city = TextEditingController();

  void _getWeather() async {
    setState(() {
      isLoading = true;
    });

    if (_city.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please enter a city name")));
      return;
    }

    try {
      final weather = await _weatherService.fetchWeather(_city.text);
      setState(() {
        _weather = weather;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }

    _city.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Weather App",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(55, 53, 62, 0.95),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient:
              _weather != null &&
                  _weather!.description.toLowerCase().contains("rain")
              ? const LinearGradient(
                  colors: [Colors.grey, Colors.blueGrey],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
              : _weather != null &&
                    _weather!.description.toLowerCase().contains("clear")
              ? const LinearGradient(
                  colors: [Color(0xFF2193b0), Color(0xFF6dd5ed)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
              : const LinearGradient(
                  colors: [Color.fromRGBO(113, 90, 90, 0.95), Colors.black87],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsGeometry.all(15.0),
            child: Column(
              children: [
                TextField(
                  controller: _city,
                  decoration: InputDecoration(
                    hintText: "Enter city name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: _getWeather ,
                  child: Text(
                    "Get Weather",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(0, 0, 0, 0.8),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                isLoading
                    ? CircularProgressIndicator()
                    : _weather != null
                    ? Column(
                        children: [
                          Text(
                            "${_weather!.cityName}, ${_weather!.country}",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "${_weather!.temperature} °C",
                            style: TextStyle(fontSize: 28, color: Colors.white),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "${_weather!.description}",
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white70,
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Icon(Icons.opacity, color: Colors.white),
                                  SizedBox(height: 5),
                                  Text(
                                    "Humidity",
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                  Text(
                                    "${_weather!.humidity}%",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(Icons.air, color: Colors.white),
                                  SizedBox(height: 5),
                                  Text(
                                    "Wind Speed",
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                  Text(
                                    "${_weather!.windSpeed} m/s",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
