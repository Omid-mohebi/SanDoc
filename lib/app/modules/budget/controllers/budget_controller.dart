import 'package:expance/theme/AppColors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BudgetController extends GetxController {
  List<dynamic> list = [];
  DatabaseReference databaseReference = FirebaseDatabase.instance.reference();
  User get getuser => FirebaseAuth.instance.currentUser;
  TextEditingController textEditingController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController initialText = TextEditingController();
  TextEditingController initialamount = TextEditingController();
  var formatted;
  var arg = Get.arguments;
  var key;
  var selectedDate = DateTime.now();
  final count = 0.obs;
  var total = 0.obs;
  selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light().copyWith(
            primary: AppColors.darkBlue,
          )),
          child: child,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      Future.delayed(Duration.zero, () async {
        formatted.value = DateFormat.yMMMd().format(selectedDate);
      });
    }
  }

  var val = ''.obs;
  @override
  void onInit() async {
    super.onInit();
    key = arg['key'];
    await databaseReference
        .child(getuser.uid)
        .child('tasks')
        .child(key)
        .child('currency')
        .once()
        .then((DataSnapshot snapshot) {
      val.value = snapshot.value;
    });
    print(val.value.toString());
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
