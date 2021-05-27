import 'package:expance/app/modules/chart/controllers/chart_controller.dart';
import 'package:expance/app/modules/home/controllers/home_controller.dart';
import 'package:expance/app/modules/setting/controllers/setting_controller.dart';
import 'package:expance/app/modules/tasks/controllers/tasks_controller.dart';
import 'package:get/get.dart';

import 'package:expance/app/modules/tabHome/controllers/tab_home_controller.dart';

class TabHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TabHomeController());
    Get.put(HomeController());
    Get.put(TasksController());
    Get.put(ChartController());
    Get.put(SettingController());
  }
}
