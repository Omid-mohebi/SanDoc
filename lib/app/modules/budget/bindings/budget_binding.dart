import 'package:get/get.dart';

import 'package:expance/app/modules/budget/controllers/budget_controller.dart';

class BudgetBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BudgetController(),
    );
  }
}
