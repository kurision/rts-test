import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rts_test/home/first_table.dart';
import 'package:rts_test/home/second_table.dart';
import 'package:rts_test/repo/weatherProvider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "RTS Test",
      home: Main(),
    );
  }
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("RTS Test"),
      ),
      body: Center(
        child: Column(
          children: [
            _showFirstTable(context),
            const SizedBox(
              height: 20,
            ),
            _showConvertButton(context),
            const SizedBox(
              height: 20,
            ),
            _showSecondScreen(context),
          ],
        ),
      ),
    );
  }

  ElevatedButton _showSecondScreen(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SecondTableScreen()),
          );
        },
        child: const Text("Load the Second Table"));
  }

  ElevatedButton _showConvertButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        WeatherRepository().convertJson();
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                actionsAlignment: MainAxisAlignment.center,
                content: const Text("JSON converted Successfully"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("OK"))
                ],
              );
            });
      },
      child: const Text("Convert the JSON"),
    );
  }

  ElevatedButton _showFirstTable(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FirstTableScreen()),
          );
        },
        child: const Text("Load Json Table"));
  }
}
