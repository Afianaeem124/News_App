import 'dart:async';

import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_application_1/Routes/routes_name.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 10), () => Navigator.pushNamed(context, RoutesName.homescreen));
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'assets/splash_pic.jpg',
                height: height * 0.45,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: height * .04,
            ),
            Center(child: AnimatedTextKit(totalRepeatCount: 2, animatedTexts: [TyperAnimatedText('TOP HEADLINES', textStyle: GoogleFonts.lemon(fontSize: height * 0.05))])),
            SizedBox(
              height: height * .04,
            ),
            SpinKitChasingDots(
              color: AppColors.loadingbColor,
              size: 40,
            )
          ],
        ),
      ),
    );
  }
}
