// Create a basic weather app that fetches weather data from a public API and displays it.

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: WeatherApp(),
  ));
}

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  final TextEditingController _controller = TextEditingController();
  String city = '';
  Map<String, dynamic>? weatherData;
  bool isLoading = false;
  bool hasError = false;

  final String apiKey = "c2267ecdd71ace0c9ad79068f16dd8de";

  Future<void> fetchWeather(String cityName) async {
    setState(() {
      isLoading = true;
      hasError = false;
    });

    final url =
        "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric";

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          weatherData = data;
          isLoading = false;
        });
      } else {
        setState(() {
          hasError = true;
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        hasError = true;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather App"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: "Enter City Name",
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    final input = _controller.text.trim();
                    if (input.isNotEmpty) {
                      fetchWeather(input);
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            if (isLoading)
              CircularProgressIndicator()
            else if (hasError)
              Text(
                "Could not fetch weather. Try again!",
                style: TextStyle(color: Colors.red),
              )
            else if (weatherData != null)
                buildWeatherInfo()
              else
                Text("Search for a city to get weather"),
          ],
        ),
      ),
    );
  }

  Widget buildWeatherInfo() {
    return Card(
      margin: const EdgeInsets.only(top: 20),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              weatherData!['name'],
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "${weatherData!['main']['temp']} °C",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              weatherData!['weather'][0]['description']
                  .toString()
                  .toUpperCase(),
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text("Humidity: ${weatherData!['main']['humidity']}%"),
            Text("Wind: ${weatherData!['wind']['speed']} m/s"),
          ],
        ),
      ),
    );
  }
}