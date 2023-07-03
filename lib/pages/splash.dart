import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

import '../../theme/theme.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      FirebaseAuth.instance.currentUser !=null ?
      Navigator.pushNamed(context, '/bottomBar'):
      Navigator.pushNamed(context, '/onboarding');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(
                "assets/splash/car.png",
                height: size.height * 0.35,
                width: double.maxFinite,
                fit: BoxFit.fill,
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.6, 0.7, 0.8, 1.0],
                colors: [
                  primaryColor,
                  primaryColor.withOpacity(0.8),
                  primaryColor.withOpacity(0.6),
                  whiteColor.withOpacity(0),
                ],
              ),
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/splash/icon-park-outline_parking.png",
                  height: 50,
                  width: 50,
                ),
                heightSpace,
                Text(
                  "Quick parking",
                  style: semibold26Black,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
