// import 'package:flutter/material.dart';
// import 'package:weather/models/weather_model.dart';
// import 'package:weather/services/weather_service.dart';
// import 'package:weather/widget/weather_card.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final WeatherService _weatherService = WeatherService();
//   bool isLoading = false;
//   Weather? _weather;
//   final TextEditingController _city = TextEditingController();

//   void _getWeather() async {
//     if (_city.text.trim().isEmpty) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text("Please enter a city name")),
//     );
//     return; 
//   }

//     setState(() {
//       isLoading = true;
//     });

//     try {
//       final weather = await _weatherService.fetchWeather(_city.text);
//       setState(() {
//         _weather = weather;
//         isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         isLoading = false;
//       });
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text("Error: $e")));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: const Text(
//       //     "Weather App",
//       //     style: TextStyle(
//       //       fontSize: 28,
//       //       fontWeight: FontWeight.w900,
//       //       color: Colors.white,
//       //     ),
//       //   ),
//       //   centerTitle: true,
//       //   backgroundColor: Color.fromRGBO(55, 53, 62, 0.95),
//       // ),
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: BoxDecoration(
//           gradient:
//               _weather != null &&
//                   _weather!.description.toLowerCase().contains("rain")
//               ? const LinearGradient(
//                   colors: [Colors.grey, Colors.blueGrey],
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                 )
//               : _weather != null &&
//                     _weather!.description.toLowerCase().contains("clear")
//               ? const LinearGradient(
//                   colors: [Colors.orangeAccent, Colors.blueAccent],
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                 )
//               : const LinearGradient(
//                   colors: [Colors.grey, Colors.lightBlueAccent],
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                 ),
//         ),
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 SizedBox(height: 10),
//                 Text(
//                   "Weather App",
//                   style: TextStyle(
//                     fontSize: 32,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 TextField(
//                   controller: _city,
//                   decoration: InputDecoration(
//                     hintText: "Enter city name",
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10.0),
//                       borderSide: BorderSide.none,
//                     ),
//                     filled: true,
//                     fillColor: const Color.fromARGB(174, 255, 255, 255),
//                   ),
//                 ),
//                 const SizedBox(height: 20.0),
//                 ElevatedButton(
//                   onPressed: _getWeather,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color.fromARGB(120, 96, 125, 139),
//                     foregroundColor: Colors.blue,
//                     padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20.0),
//                     ),
//                   ),
//                   child: Text(
//                     "Get Weather",
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w600,
//                       color: const Color.fromARGB(223, 0, 0, 0),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 if (isLoading)
//                   Padding(
//                     padding: EdgeInsets.all(15),
//                     child: CircularProgressIndicator(color: Colors.white),
//                   ),
//                 if (_weather != null) WeatherCard(weather: _weather!),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:weather/models/weather_model.dart';
import 'package:weather/services/weather_service.dart';
import 'package:weather/widget/weather_card.dart';

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
    if (_city.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a city name")),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  LinearGradient _getBackgroundGradient() {
    if (_weather == null) {
      return const LinearGradient(
        colors: [Colors.grey, Colors.lightBlueAccent],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
    }

    String desc = _weather!.description.toLowerCase();
    if (desc.contains('rain')) {
      return const LinearGradient(
        colors: [Colors.grey, Colors.blueGrey],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
    } else if (desc.contains('clear')) {
      return const LinearGradient(
        colors: [Colors.orangeAccent, Colors.blueAccent],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
    } else if (desc.contains('cloud') || desc.contains('overcast')) {
      return const LinearGradient(
        colors: [Colors.grey, Colors.blueGrey],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
    } else if (desc.contains('snow')) {
      return const LinearGradient(
        colors: [Colors.lightBlueAccent, Colors.white],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
    } else {
      return const LinearGradient(
        colors: [Colors.grey, Colors.lightBlueAccent],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: _getBackgroundGradient(),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 40),
                const Text(
                  "Weather App",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _city,
                  decoration: InputDecoration(
                    hintText: "Enter city name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: const Color.fromARGB(174, 255, 255, 255),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _getWeather,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(120, 96, 125, 139),
                    foregroundColor: Colors.blue,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: const Text(
                    "Get Weather",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(213, 0, 0, 0),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                if (isLoading)
                  const Padding(
                    padding: EdgeInsets.all(15),
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                if (_weather != null) WeatherCard(weather: _weather!),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
