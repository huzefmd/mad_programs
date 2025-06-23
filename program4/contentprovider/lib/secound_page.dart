import 'package:flutter/material.dart';

class SecoundPage extends StatelessWidget {
  const SecoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Secound Page")),
      body: Center(
        child: Text(
          "This is an Explicit Intent  Screen",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
