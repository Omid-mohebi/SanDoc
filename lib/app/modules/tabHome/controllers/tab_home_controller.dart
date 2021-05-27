import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expance/app/globle%20components/step.dart';
import 'package:expance/app/modules/chart/views/chart_view.dart';
import 'package:expance/app/modules/home/views/home_view.dart';
import 'package:expance/app/modules/setting/views/setting_view.dart';
import 'package:expance/app/modules/tasks/views/tasks_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabHomeController extends GetxController
    with SingleGetTickerProviderMixin {
  List<MyStep> steps = [];
  var currentStep = 0.obs;
  var complete = false.obs;
  TabController pageController;
  next() async {
    if (currentStep.value == 0) {
      currentStep.value + 1 != steps.length
          ? goTo(currentStep.value + 1)
          : complete.value = true;
    } else if (currentStep.value == 1) {
      if (amountcontroller.text == '' ||
          amountcontroller.text == '' ||
          int.parse(amountcontroller.text) <= 0) {
        Get.snackbar('notifier'.tr, 'amountCantEmpty'.tr);
        return;
      }
      currentStep.value + 1 != steps.length
          ? goTo(currentStep.value + 1)
          : complete.value = true;
    } else if (currentStep.value == 2) {
      if (titlecontroller.text == '' || titlecontroller.text == null) {
        Get.snackbar('notifier'.tr, 'titleCantEmpty'.tr);
        return;
      }
      currentStep.value + 1 != steps.length
          ? goTo(currentStep.value + 1)
          : complete.value = true;
    } else if (currentStep.value == 3) {
      if (amountcontroller.text == '' ||
          amountcontroller.text == null ||
          titlecontroller.text == '' ||
          titlecontroller.text == null ||
          int.parse(amountcontroller.text) <= 0) {
        Get.snackbar('notifier'.tr, 'amountCantEmpty'.tr);
        return;
      }
      complete.value = false;
      currentStep.value = 0;
      print(dropdownValue.value);
      // try {
      // await InternetAddress.lookup('google.com');
      databaseReference
          .child(getuser.uid)
          .child('tasks')
          .child(itemsMap[droplist.indexOf(dropdownValue.value)]['itemKey'])
          .child(
              sdropdownValue.value == 'مصارف' || sdropdownValue.value == 'Spend'
                  ? 'spend'
                  : 'budget')
          .push()
          .set(
        {
          'amount': int.parse(amountcontroller.text),
          'title': titlecontroller.text,
          'date': Timestamp.fromDate(DateTime.now()).seconds,
        },
      );
      amountcontroller.text = '';
      titlecontroller.text = '';
      dropdownValue.value = droplist[0];
      sdropdownValue.value = 'spend'.tr;
      Get.back();
      // } catch (e) {
      // Get.back();
      // amountcontroller.text = '';
      // titlecontroller.text = '';
      // dropdownValue.value = droplist[0];
      // sdropdownValue.value = 'spend'.tr;
      // Get.defaultDialog(
      //   title: 'Oops'.tr,
      //   middleText: 'somethingWrong'.tr,
      // );
      // }
    }
  }

  cancel() {
    if (currentStep.value > 0) {
      goTo(currentStep.value - 1);
    } else if (currentStep.value == 0) {
      Get.back();
    }
    if (currentStep.value == 0) {
      amountcontroller.clear();
      print('hhhhhhhhhh');
    }
    if (currentStep.value == 1) {
      titlecontroller.clear();
    }
  }

  goTo(int step) {
    currentStep.value = step;
  }

  void pageChanged(int index) {
    currentTab.value = index;
    switch (index) {
      case 0:
        {
          w1.value = 15.0;
          w2.value = 0.0;
          w3.value = 0.0;
          w4.value = 0.0;
          break;
        }
      case 1:
        {
          w1.value = 0.0;
          w2.value = 15.0;
          w3.value = 0.0;
          w4.value = 0.0;
          break;
        }
      case 2:
        {
          w1.value = 0.0;
          w2.value = 0.0;
          w3.value = 15.0;
          w4.value = 0.0;
          break;
        }
      case 3:
        {
          w1.value = 0.0;
          w2.value = 0.0;
          w3.value = 0.0;
          w4.value = 15.0;
          break;
        }
    }
  }

  var w1 = 15.0.obs;
  var w2 = 0.0.obs;
  var w3 = 0.0.obs;
  var w4 = 0.0.obs;
  var currentTab = 0.obs;

  List<Widget> screens;
  final count = 0.obs;
  var dropdownValue = ''.obs;
  var sdropdownValue = 'spend'.tr.obs;
  List<String> droplist = [];
  List<Map<dynamic, dynamic>> itemsMap = [];
  int myindex = 0;
  TextEditingController amountcontroller = TextEditingController();
  TextEditingController titlecontroller = TextEditingController();
  DatabaseReference databaseReference = FirebaseDatabase.instance.reference();
  User get getuser => FirebaseAuth.instance.currentUser;
  @override
  void onInit() {
    super.onInit();
    pageController = TabController(length: 4, vsync: this);
    Widget home = HomeView();
    Widget tasks = TasksView();
    Widget chart = ChartView();
    Widget setting = SettingView();
    screens = [
      home,
      tasks,
      chart,
      setting,
    ];
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
