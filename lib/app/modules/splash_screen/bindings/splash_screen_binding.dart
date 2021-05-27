import 'package:get/get.dart';

import 'package:expance/app/modules/splash_screen/controllers/splash_screen_controller.dart';

class SplashScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashScreenController(),
    );
  }
}
