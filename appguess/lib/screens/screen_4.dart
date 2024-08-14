import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import '../main.dart';

void main() {
  runApp(Screen4());
}

class Screen4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'City to Lat/Lon Conversion',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController _cityController = TextEditingController();
  String _weatherInfo = 'Enter a city name to get weather info';
  late Map<String, dynamic> _citiesData;
  @override
  void initState() {
    super.initState();
    _loadCitiesData();
  }

  Future<void> _loadCitiesData() async {
    final String jsonString = await rootBundle.loadString('assets/cities.json');
    setState(() {
      _citiesData = json.decode(jsonString);
    });
  }

  Future<void> _fetchWeather(String cityName) async {
    cityName = cityName.toLowerCase();
    Map<String, dynamic>? city = _citiesData[cityName];

    if (city != null) {
      String latitude = city['lat'];
      String longitude = city['lng'];
      final gridUrl = 'https://api.weather.gov/points/$latitude,$longitude';

      try {
        final gridResponse = await http.get(
          Uri.parse(gridUrl),
          headers: {'User-Agent': 'appguess (twinkiedomo@gmail.com)'},
        );

        if (gridResponse.statusCode == 200) {
          final gridData = json.decode(gridResponse.body);
          final forecastUrl = gridData['properties']['forecast'];

          final forecastResponse = await http.get(
            Uri.parse(forecastUrl),
            headers: {'User-Agent': '(appguess twinkiedomo@gmail.com)'},
          );

          if (forecastResponse.statusCode == 200) {
            final forecastData = json.decode(forecastResponse.body);
            final periods = forecastData['properties']['periods'];
            final firstPeriod = periods[0];

            setState(() {
              _weatherInfo =
                  'Temperature: ${firstPeriod['temperature']}°F\nForecast: ${firstPeriod['detailedForecast']}';
            });
          } else {
            setState(() {
              _weatherInfo = 'Error: Unable to fetch weather forecast';
            });
          }
        } else {
          setState(() {
            _weatherInfo = 'Error: Location not found';
          });
        }
      } catch (e) {
        setState(() {
          _weatherInfo = 'Error fetching weather data';
        });
      }
    } else {
      setState(() {
        _weatherInfo = 'Error: City not found in database';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Information'),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
                (Route<dynamic> route) => false,
              );
            },
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: 'Enter City Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _fetchWeather(_cityController.text);
              },
              child: Text('Get Weather'),
            ),
            SizedBox(height: 20),
            Text(
              _weatherInfo,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
