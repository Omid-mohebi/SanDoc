import 'package:get/get.dart';

import 'package:expance/app/modules/tasks/controllers/tasks_controller.dart';

class TasksBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TasksController());
  }
}
