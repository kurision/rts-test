import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rts_test/home/controller/home_controller.dart';

class SecondTableScreen extends ConsumerWidget {
  const SecondTableScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tableData = ref.watch(weatherTableFromFileControllerProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Second Table"),
      ),
      body: tableData.when(
        data: (data) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
                border: TableBorder.all(),
                columnSpacing: 10,
                columns: const [
                  DataColumn(label: Text('Time')),
                  DataColumn(label: Text('Air Temperature')),
                  DataColumn(label: Text('Relative Humidity')),
                  DataColumn(label: Text('Wind Speed')),
                  DataColumn(label: Text('Wind Direction')),
                ],
                rows: data.entries.map((entry) {
                  var date = entry.key;
                  var values = entry.value;
                  return DataRow(
                    cells: [
                      DataCell(Text(date)),
                      DataCell(Text(values['Air Temperature'])),
                      DataCell(Text(values['Relative Humidity'])),
                      DataCell(Text(values['Wind Speed'])),
                      DataCell(Text(values['Wind Direction'])),
                    ],
                  );
                }).toList()),
          );
        },
        error: (err, stack) => Text('Error: $err'),
        loading: () => const CircularProgressIndicator(),
      ),
    );
  }
}
