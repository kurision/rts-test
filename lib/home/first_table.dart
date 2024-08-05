import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rts_test/home/controller/home_controller.dart';
import 'package:rts_test/model/weather.dart';

class FirstTableScreen extends ConsumerWidget {
  const FirstTableScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tableData = ref.watch(weatherTableControllerProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Table"),
      ),
      body: tableData.when(
        data: (data) {
          List<DateTime> uniqueDates = dateExtract(data);
          List<DataColumn> columns = columnExtract(uniqueDates);
          List<DataRow> rows = rowExtract(uniqueDates, data);

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: [
                DataTable(
                  columnSpacing: 10,
                  columns: columns,
                  rows: rows,
                  border: TableBorder.all(),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
        },
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  List<DataRow> rowExtract(
      List<DateTime> uniqueDates, List<WeatherModel> data) {
    final rows = data.map((weatherModel) {
      final cells = [
        DataCell(Text(weatherModel.name)),
        ...uniqueDates.map((date) {
          final datum = weatherModel.data.firstWhere(
            (datum) => datum.time == date,
            orElse: () => Datum(time: date, value: 'N/A'),
          );
          return DataCell(Text(datum.value));
        }),
      ];
      return DataRow(cells: cells);
    }).toList();
    return rows;
  }

  List<DataColumn> columnExtract(List<DateTime> uniqueDates) {
    final columns = [
      const DataColumn(label: Text('Parameter')),
      ...uniqueDates.map((date) =>
          DataColumn(label: Text(date.toLocal().toString().split(' ')[0]))),
    ];
    return columns;
  }

  List<DateTime> dateExtract(List<WeatherModel> data) {
    final uniqueDates = data
        .expand((weatherModel) => weatherModel.data)
        .map((datum) => datum.time)
        .toSet()
        .toList()
      ..sort();
    return uniqueDates;
  }
}
