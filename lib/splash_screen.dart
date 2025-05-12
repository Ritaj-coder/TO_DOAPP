import 'dart:async';

import 'package:flutter/material.dart';
import 'package:to_do_app1/app_Colors.dart';
import 'package:to_do_app1/home/auth/login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "Splash";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Duration of the splash screen (e.g., 3 seconds)
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, LoginScreen.routename);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Column(
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  fit: BoxFit.fill,
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
