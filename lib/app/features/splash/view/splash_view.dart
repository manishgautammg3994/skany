import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/config/routes/app_pages.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 2), () {
      // Navigator.of(context)
      //     .pushReplacement(MaterialPageRoute(builder: (_) => HomePage()));
      Get.offAllNamed(Routes.home);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/icon.jpg",
              height: 157,
            ),
            SizedBox(
              height: 40,
            ),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
