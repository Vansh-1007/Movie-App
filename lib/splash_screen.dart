import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, '/home');
          },
          child: Image.asset('assets/movie.jpg'),
        ),
      ),
    );
  }
}
