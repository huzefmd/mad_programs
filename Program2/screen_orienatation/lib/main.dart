import 'package:flutter/material.dart';

void main() {
  runApp(const OrientationApp());
}

class OrientationApp extends StatelessWidget {
  const OrientationApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const OrientationHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class OrientationHomePage extends StatefulWidget {
  const OrientationHomePage({Key? key}) : super(key: key);

  @override
  State<OrientationHomePage> createState() => _OrientationHomePageState();
}

class _OrientationHomePageState extends State<OrientationHomePage> {
  String _message = "Press the button to check orientation";

  void _showOrientationMessage(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    setState(() {
      _message = orientation == Orientation.portrait
          ? "📱 You're in Portrait Mode!"
          : "🌄 You're in Landscape Mode!";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orientation Detector"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _message,
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _showOrientationMessage(context),
                child: const Text("Check Orientation"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
