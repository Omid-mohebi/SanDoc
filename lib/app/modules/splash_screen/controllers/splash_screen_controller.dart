import 'dart:async';
import 'package:expance/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  final databaseReference = FirebaseDatabase.instance.reference();
  User get getuser => FirebaseAuth.instance.currentUser;
  final count = 0.obs;
  @override
  void onInit() async {
    super.onInit();
    if (FirebaseAuth.instance.currentUser != null) {
      // Get.put(TabHomeController());
      if (databaseReference.once() != null) {
        await databaseReference.once().then((DataSnapshot snapshot) {
          print('Data : ${snapshot.value}');
        });
        Get.offAllNamed(Routes.TAB_HOME);
      } else {
        print('nonononononn');
      }
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
