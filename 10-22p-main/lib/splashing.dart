import 'dart:async';

import 'package:flutter/material.dart';
import 'package:untitled/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

    _animationController.forward();

    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyApp()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            left: 90,
            top: 150,
            child: Center(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Hero(
                  tag: 'splashed',
                  child: Image.asset(
                    'images/main_screen_logo.png',
                    height: 311,
                    width: 253,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Image.asset(
                'images/bottom_image.png',
                width: 430,
                height: 328,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
