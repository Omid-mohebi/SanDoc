import 'package:get/get.dart';

import 'package:expance/app/modules/total/controllers/total_controller.dart';

class TotalBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TotalController());
  }
}
