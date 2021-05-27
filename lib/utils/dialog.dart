import 'dart:io';

import 'package:expance/app/lang/LocalizationServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

DatabaseReference databaseReference = FirebaseDatabase.instance.reference();
User get getuser => FirebaseAuth.instance.currentUser;
showChangeLangDialog({langChangedCallBack(String languge)}) {
  Get.defaultDialog(
    title: "change_languge".tr,
    content: Column(
      children: [
        SizedBox(height: 15),
        Column(
            children: LocalizationService.langs.map(
          (l) {
            return Column(
              children: [
                l == 'English' ? Container() : Divider(),
                ListTile(
                  title: Center(child: Text(l)),
                  onTap: () async {
                    try {
                      await InternetAddress.lookup('google.com');
                      databaseReference
                          .child(getuser.uid)
                          .update({'lang': '$l'}).then((value) {
                        Get.back();
                        if (langChangedCallBack != null) langChangedCallBack(l);
                        LocalizationService().changeLocale(l);
                      });
                    } catch (e) {
                      Get.back();
                      Get.defaultDialog(
                        title: 'Oops'.tr,
                        middleText: 'somethingWrong'.tr,
                      );
                    }
                  },
                ),
              ],
            );
          },
        ).toList()),
      ],
    ),
  );
}
