import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TasksController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  String inputData() {
    final User user = auth.currentUser;
    return user.email;
  }

  String curr;
  TextEditingController initialText;
  final taskCollection = FirebaseFirestore.instance;
  TextEditingController textEditingController = TextEditingController();
  final databaseReference = FirebaseDatabase.instance.reference();
  User get getuser => FirebaseAuth.instance.currentUser;
  List<dynamic> list = [];

  @override
  void onInit() {
    super.onInit();
    databaseReference.child(getuser.uid).child('tasks').once().then(
      (value) {
        if (value != null) {
          Map<dynamic, dynamic> val = value.value;
          val.forEach(
            (key, values) {
              if (value != null) list.add(values);
            },
          );
        }
      },
    );
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
