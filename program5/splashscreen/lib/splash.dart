import 'package:flutter/material.dart';
import 'package:splashscreen/main.dart';
import 'package:splashscreen/myHomePage.dart';

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({super.key});

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double>
  _animation; // You declared this but forgot to initialize

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    Future.delayed(Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => MyHomePage(title: "Welcome To Bapu College"),
        ),
      );
    });

    _animation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.orange,
        child: Center(
          child: ScaleTransition(
            scale: _animation,
            child: Image.asset(
              'assets/images/loading-logo.png',
              width: 150,
              height: 150,
            ),
          ),
        ),
      ),
    );
  }
}
