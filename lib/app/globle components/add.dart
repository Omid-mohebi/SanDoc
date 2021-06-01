import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final databaseReference = FirebaseDatabase.instance.reference();
User get getuser => FirebaseAuth.instance.currentUser;

class Add {
  static addTask(
      {TextEditingController textEditingController, String curr}) async {
    try {
      databaseReference.child(getuser.uid).child('tasks').push().set(
        {
          'name': textEditingController.text,
          'taskTime': ServerValue.timestamp,
          'currency': curr,
        },
      ).then((value) {
        textEditingController.clear();
        Get.back();
      });
    } catch (e) {
      Get.back();
      textEditingController.clear();
      Get.defaultDialog(
        title: 'Oops'.tr,
        middleText: 'somethingWrong'.tr,
      );
    }
  }

  static addBudget(
      {var key,
      TextEditingController amountController,
      TextEditingController textEditingController,
      DateTime selectedDate,
      String type}) async {
    try {
      databaseReference
          .child(getuser.uid)
          .child('tasks')
          .child(key)
          .child(type)
          .push()
          .set({
        'amount': int.parse(amountController.text),
        'title': textEditingController.text,
        'date': Timestamp.fromDate(selectedDate).seconds,
      }).then((value) {
        amountController.clear();
        textEditingController.clear();
        Get.back();
      });
    } catch (e) {
      Get.back();
      textEditingController.clear();
      Get.defaultDialog(
        title: 'Oops'.tr,
        middleText: 'somethingWrong'.tr,
      );
    }
  }
}
