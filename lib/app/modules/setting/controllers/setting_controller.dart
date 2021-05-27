import 'package:expance/app/data/google_auth.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  FireBaseController fireBaseController = FireBaseController();
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
