import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gieco_west/UiLayer/AuthScreens/LoginScreen/login_screen.dart';
import 'package:gieco_west/UiLayer/HomeScreen/home_screen.dart';
import 'package:gieco_west/Utils/const.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "SplashScreen";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      FirebaseAuth.instance.currentUser?.uid == null
          ?
          // userProvider.currentUser == null
          {Navigator.of(context).pushReplacementNamed(LoginPage.routeName)}
          : {Navigator.of(context).pushReplacementNamed(HomeScreen.routeName)};
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(
            flex: 1,
          ),
          FadeInDownBig(
            child: Image.asset(
              Const.splashLogo,
              fit: BoxFit.fill,
              width: double.infinity,
              height: 100.h,
            ),
          ),
          const Spacer(
            flex: 1,
          ),
        ],
      ),
    );
  }
}
