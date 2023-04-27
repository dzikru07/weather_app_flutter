// To parse this JSON data, do
//
//     final weatherModels = weatherModelsFromJson(jsonString);

import 'dart:convert';

WeatherModels weatherModelsFromJson(String str) =>
    WeatherModels.fromJson(json.decode(str));

String weatherModelsToJson(WeatherModels data) => json.encode(data.toJson());

class WeatherModels {
  DateTime jamCuaca;
  String kodeCuaca;
  String cuaca;
  String humidity;
  String tempC;
  String tempF;

  WeatherModels({
    required this.jamCuaca,
    required this.kodeCuaca,
    required this.cuaca,
    required this.humidity,
    required this.tempC,
    required this.tempF,
  });

  factory WeatherModels.fromJson(Map<String, dynamic> json) => WeatherModels(
        jamCuaca: DateTime.parse(json["jamCuaca"]),
        kodeCuaca: json["kodeCuaca"],
        cuaca: json["cuaca"],
        humidity: json["humidity"],
        tempC: json["tempC"],
        tempF: json["tempF"],
      );

  Map<String, dynamic> toJson() => {
        "jamCuaca": jamCuaca.toIso8601String(),
        "kodeCuaca": kodeCuaca,
        "cuaca": cuaca,
        "humidity": humidity,
        "tempC": tempC,
        "tempF": tempF,
      };
}
