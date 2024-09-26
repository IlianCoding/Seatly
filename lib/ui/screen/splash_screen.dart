import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:seatly/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Lottie.asset('assets/raw/splashAnimation.json',
            onLoaded: (composition){
              Future.delayed(Duration(milliseconds: composition.duration.inMilliseconds), (){
                navigatorKey.currentState!.pushReplacementNamed('/home');
              });
            }),
      ),
    );
  }
}