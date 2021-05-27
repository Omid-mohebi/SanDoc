import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:expance/app/modules/splash_screen/controllers/splash_screen_controller.dart';
import 'package:lottie/lottie.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset('assets/lot/43792-yoga-se-hi-hoga.json'),
            SizedBox(
              height: 30,
            ),
            Text(
              'patient'.tr,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
