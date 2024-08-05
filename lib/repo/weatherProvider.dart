import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rts_test/model/weather.dart';

final weatherProvider = Provider((ref) => WeatherRepository());

class WeatherRepository {
  final Map<String, Map<String, String>> transformedData = {};

  //for reading and writing to file
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/dummy_data_2.json');
  }
  Future<File> writeJson(String json) async {
    final file = await _localFile;
    return file.writeAsString(json);
  }
  Future<String> readFile() async {
    try {
      final file = await _localFile;
      // Read the file
      final contents = await file.readAsString();
      return contents;
    } catch (e) {
      log(e.toString());
    }

    throw Exception('Failed to read counter.');
  }

  //for loading dummy_data_2.json
  Future<Map<String,dynamic>> readJsonFromFile() async {
    String sampleData = await readFile();
    return jsonDecode(sampleData);
  }

  Future<List<WeatherModel>> loadTableDataFromAssets() async {
    await Future.delayed(const Duration(seconds: 2));
    final sampleData =
        await rootBundle.loadString('assets/json/dummy_data.json');
    final List<dynamic> jsonData = json.decode(sampleData);
    List<WeatherModel> tableData =
        jsonData.map((e) => WeatherModel.fromJson(e)).toList();
    return tableData;
  }

  //function to convert dummy_data.json to dummy_data_2.json
  void convertJson() async {
    final sampleData =
        await rootBundle.loadString('assets/json/dummy_data.json');
    final List<dynamic> originalData = json.decode(sampleData);

    for (var model in originalData) {
      final name = model['name'];
      for (var datum in model['data']) {
        final time = datum['time'];
        final value = datum['value'];
        if (!transformedData.containsKey(time)) {
          transformedData[time] = {};
        }
        transformedData[time]![name] = value;
      }
    }
    final jsonString = jsonEncode(transformedData);
    writeJson(jsonString);
  }
}
