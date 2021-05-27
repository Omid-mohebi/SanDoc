import 'dart:async';

import 'package:expance/app/data/google_auth.dart';
import 'package:expance/app/modules/tabHome/controllers/tab_home_controller.dart';
import 'package:expance/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    if (FirebaseAuth.instance.currentUser != null) {
      // Get.put(TabHomeController());
      Timer(
        Duration(seconds: 5),
        () => {Get.offAllNamed(Routes.TAB_HOME)},
      );
    } else {
      Timer(
        Duration(seconds: 5),
        () => {Get.offAllNamed(Routes.SIGN_IN)},
      );
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onReady();
  }

  void increment() => count.value++;
}
