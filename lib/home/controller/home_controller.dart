import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rts_test/model/weather.dart';
import 'package:rts_test/repo/weatherProvider.dart';

final weatherTableControllerProvider =
    FutureProvider.autoDispose<List<WeatherModel>>(
        (ref) => ref.read(weatherProvider).loadTableDataFromAssets());

final weatherTableFromFileControllerProvider =
    FutureProvider.autoDispose<Map<String, dynamic>>(
        (ref) => ref.read(weatherProvider).readJsonFromFile());
