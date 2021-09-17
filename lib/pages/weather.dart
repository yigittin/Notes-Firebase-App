import 'package:flutter/material.dart';
import 'package:notes_app/controller/data_service.dart';
import 'package:notes_app/models/models.dart';

class Weather extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  final _cityTextController = TextEditingController();
  final _dataService = DataService();

  WeatherResponse? _response;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios_outlined),
            ),
            if (_response != null)
              Column(
                children: [
                  Image.network(
                    _response!.iconUrl,
                  ),
                  Text(
                    '${_response!.tempInfo.temperature}°',
                    style: TextStyle(fontSize: 40),
                  ),
                  Text(_response!.weatherInfo.description)
                ],
              ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 50),
              child: SizedBox(
                width: 150,
                child: TextField(
                    controller: _cityTextController,
                    decoration: InputDecoration(labelText: 'City'),
                    textAlign: TextAlign.center),
              ),
            ),
            ElevatedButton(onPressed: _search, child: Text('Search'))
          ],
        ),
      ),
    ));
  }

  void _search() async {
    final response = await _dataService.getWeather(_cityTextController.text);
    setState(() => _response = response);
  }
}
