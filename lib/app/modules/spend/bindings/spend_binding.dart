import 'package:get/get.dart';

import 'package:expance/app/modules/spend/controllers/spend_controller.dart';

class SpendBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SpendController());
  }
}
