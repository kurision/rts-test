// To parse this JSON data, do
//
//     final weatherModel = weatherModelFromJson(jsonString);

import 'dart:convert';

List<WeatherModel> weatherModelFromJson(String str) => List<WeatherModel>.from(
    json.decode(str).map((x) => WeatherModel.fromJson(x)));

String weatherModelToJson(List<WeatherModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WeatherModel {
  String name;
  List<Datum> data;

  WeatherModel({
    required this.name,
    required this.data,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        name: json["name"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  DateTime time;
  String value;

  Datum({
    required this.time,
    required this.value,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        time: DateTime.parse(json["time"]),
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "time":
            "${time.year.toString().padLeft(4, '0')}-${time.month.toString().padLeft(2, '0')}-${time.day.toString().padLeft(2, '0')}",
        "value": value,
      };
}


