import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';

const apiKey = '02e117575f5c48628bb112453262103';
const weatherApiURL = 'https://api.weatherapi.com/v1/current.json';

void main() => runApp(const Clima());

class Clima extends StatelessWidget {
  const Clima({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const WeatherScreen(),
    );
  }
}

class WeatherModel {
  String getWeatherIcon(int code) {
    if (code == 1000) return '☀️';
    if (code <= 1009) return '☁️';
    if (code <= 1195) return '☔️';
    if (code <= 1225) return '❄️';
    return '🌫';
  }

  String getMessage(int temp) {
    if (temp > 25) return 'Thời gian cho 🍦';
    if (temp > 20) return 'Thời tiết đẹp cho 👕';
    return 'Hãy mang theo 🧥';
  }
}

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherModel weather = WeatherModel();

  int temperature = 0;
  String weatherIcon = '';
  String cityName = 'Đang tải...';
  String weatherMessage = '';

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    initialDataFetch();
  }

  Future<void> initialDataFetch() async {
    if (!isLoading) setState(() => isLoading = true);

    try {
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.deniedForever ||
          permission == LocationPermission.denied) {
        await getWeatherData('q=Da Nang');
        return;
      }

      Position? position = await Geolocator.getLastKnownPosition();

      position ??= await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
        timeLimit: const Duration(seconds: 6),
      );

      await getWeatherData(
        'q=${position.latitude.toStringAsFixed(2)},${position.longitude.toStringAsFixed(2)}',
      );
    } catch (e) {
      print('GPS lỗi: $e');
      await getWeatherData('q=Da Nang');
    }
  }

  Future<void> getCityWeather(String cityName) async {
    if (!isLoading) setState(() => isLoading = true);
    await getWeatherData('q=$cityName');
  }

  Future<void> getWeatherData(String query) async {
    try {
      var url = Uri.parse('$weatherApiURL?key=$apiKey&$query&aqi=no');

      final response = await http
          .get(url)
          .timeout(const Duration(seconds: 6));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data == null || data['current'] == null) {
          throw Exception('Dữ liệu lỗi');
        }

        updateUI(data);
      } else {
        throw Exception('API lỗi');
      }
    } catch (e) {
      print('API lỗi: $e');
      updateErrorUI();
    }
  }

  void updateUI(dynamic data) {
    setState(() {
      isLoading = false;

      temperature = data['current']['temp_c'].toInt();
      cityName = data['location']['name'];

      int conditionCode = data['current']['condition']['code'];
      weatherIcon = weather.getWeatherIcon(conditionCode);

      weatherMessage = weather.getMessage(temperature);
    });
  }

  void updateErrorUI() {
    setState(() {
      isLoading = false;
      cityName = 'Không có dữ liệu';
      weatherIcon = '❌';
      weatherMessage = 'Thử lại sau';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        child: SafeArea(
          child: isLoading && temperature == 0
              ? const Center(
            child: CircularProgressIndicator(color: Colors.white),
          )
              : RefreshIndicator(
            onRefresh: initialDataFetch,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: buildUIContent(),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildUIContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: initialDataFetch,
                icon: const Icon(Icons.near_me, size: 50),
              ),
              IconButton(
                onPressed: () async {
                  var typedName = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CityScreen(),
                    ),
                  );

                  if (typedName != null && typedName != '') {
                    getCityWeather(typedName);
                  }
                },
                icon: const Icon(Icons.location_city, size: 50),
              ),
            ],
          ),

          const SizedBox(height: 100),

          Row(
            children: [
              Text(
                '$temperature°',
                style: const TextStyle(
                    fontSize: 80, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 10),
              Text(
                weatherIcon,
                style: const TextStyle(fontSize: 80),
              ),
            ],
          ),

          const SizedBox(height: 50),

          Text(
            "$weatherMessage tại $cityName!",
            textAlign: TextAlign.right,
            style: const TextStyle(
                fontSize: 40, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 36),
          const Text(
            'Nguyễn Thái Nguyên • 23IT.B142',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.white70),
          ),
        ],
      ),
    );
  }
}

class CityScreen extends StatefulWidget {
  const CityScreen({super.key});

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String cityName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back_ios,
                      size: 40, color: Colors.white),
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Nhập thành phố (vd: Hanoi)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) => cityName = value,
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  if (cityName.isNotEmpty) {
                    Navigator.pop(context, cityName);
                  }
                },
                child: const Text('Lấy Thời Tiết',
                    style: TextStyle(fontSize: 20)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
