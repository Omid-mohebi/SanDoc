import 'package:expance/app/modules/tabHome/controllers/tab_home_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  TextEditingController initialText = TextEditingController();
  bool isChanged = false;
  String curr = '';
  TabHomeController tabHomeController = TabHomeController();
  List<Map<dynamic, dynamic>> itemsMap = [];
  var btotal = 0.obs;
  var stotal = 0.obs;
  var total = 0.obs;
  var cur = ''.obs;
  DatabaseReference databaseReference = FirebaseDatabase.instance.reference();
  User get getuser => FirebaseAuth.instance.currentUser;
  var taskName = ''.obs;
  var myIndex = 0.obs;
  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
