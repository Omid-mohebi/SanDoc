import 'dart:io';
import 'package:expance/app/globle%20components/add.dart';
import 'package:expance/app/globle%20components/curIcon.dart';
import 'package:expance/app/routes/app_pages.dart';
import 'package:expance/theme/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:expance/app/modules/tasks/controllers/tasks_controller.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:lottie/lottie.dart';

class TasksView extends GetView<TasksController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'categories'.tr,
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: AppColors.specialBlackText),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              color: AppColors.blueLight,
              size: 30,
            ),
            onPressed: () {
              Get.bottomSheet(
                Container(
                  color: Color(0xFF757575),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 30,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'addNewCategory'.tr,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Text(
                                'currency'.tr,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              Expanded(child: Container()),
                              Directionality(
                                textDirection: TextDirection.ltr,
                                child: LiteRollingSwitch(
                                  value: true,
                                  textOn: 'Afghani'.tr,
                                  textOff: 'Dollar'.tr,
                                  colorOn: AppColors.darkBlue,
                                  colorOff: Colors.purple,
                                  iconOn: CurIcon.afn,
                                  iconOff: CurIcon.dollar,
                                  textSize: 16.0,
                                  onChanged: (bool state) {
                                    state
                                        ? controller.curr = 'afn'
                                        : controller.curr = 'dollar';
                                    print(controller.curr);
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextField(
                            maxLength: 20,
                            maxLengthEnforced: true,
                            controller: controller.textEditingController,
                            style: TextStyle(),
                            autofocus: true,
                            decoration: InputDecoration(
                                hintText: 'enterYourCategory'.tr),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Get.back();
                                  controller.textEditingController.clear();
                                },
                                child: Text(
                                  'cancle'.tr,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Add.addTask(
                                      textEditingController:
                                          controller.textEditingController,
                                      curr: controller.curr);
                                },
                                child: Text(
                                  'add'.tr,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: StreamBuilder(
                stream:
                    databaseReference.child(getuser.uid).child('tasks').onValue,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data != null &&
                      snapshot.data.snapshot.value != null) {
                    List<Map<dynamic, dynamic>> itemsMap = [];

                    snapshot.data.snapshot.value.forEach((key, val) {
                      itemsMap.add(
                        {'itemKey': key, 'itemValue': val},
                      );

                      itemsMap.sort((a, b) {
                        return b['itemValue']['taskTime']
                            .compareTo(a['itemValue']['taskTime']);
                      });
                    });

                    return Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 7,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 0),
                                  ),
                                ],
                              ),
                              child: ListView.builder(
                                itemCount: itemsMap.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Container(
                                          height: 65,
                                          child: ListTile(
                                            onTap: () {
                                              Get.toNamed(Routes.TOTAL,
                                                  arguments: {
                                                    'key': itemsMap[index]
                                                        ['itemKey'],
                                                    'map': snapshot
                                                        .data.snapshot.value,
                                                    'currency': itemsMap[index]
                                                            ['itemValue']
                                                        ['currency'],
                                                    'name': itemsMap[index]
                                                        ['itemValue']['name'],
                                                  });
                                            },
                                            title: Text(
                                              itemsMap[index]['itemValue']
                                                  ['name'],
                                              style: TextStyle(),
                                            ),
                                            trailing: IconButton(
                                              color: AppColors.blueLight,
                                              icon: Icon(Icons.edit),
                                              onPressed: () {
                                                Get.defaultDialog(
                                                    title: '',
                                                    content: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .stretch,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      15),
                                                          child: Text(
                                                              'deleteOrEdit'.tr,
                                                              textAlign:
                                                                  TextAlign
                                                                      .start),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            TextButton(
                                                                onPressed: () {
                                                                  Get.back();
                                                                  controller
                                                                      .curr = itemsMap[
                                                                              index]
                                                                          [
                                                                          'itemValue']
                                                                      [
                                                                      'currency'];
                                                                  controller
                                                                          .initialText =
                                                                      TextEditingController(
                                                                          text: itemsMap[index]['itemValue']
                                                                              [
                                                                              'name']);
                                                                  Get.bottomSheet(
                                                                    Container(
                                                                      color: Color(
                                                                          0xFF757575),
                                                                      child:
                                                                          Container(
                                                                        child:
                                                                            SingleChildScrollView(
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.stretch,
                                                                            children: [
                                                                              Text(
                                                                                'editCategory'.tr,
                                                                                textAlign: TextAlign.start,
                                                                                style: TextStyle(
                                                                                  fontSize: 20,
                                                                                  fontWeight: FontWeight.bold,
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                height: 15,
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  Text(
                                                                                    'currency'.tr,
                                                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                                                  ),
                                                                                  Expanded(child: Container()),
                                                                                  Directionality(
                                                                                    textDirection: TextDirection.ltr,
                                                                                    child: LiteRollingSwitch(
                                                                                      value: controller.curr == 'afn' ? true : false,
                                                                                      textOn: 'Afghani'.tr,
                                                                                      textOff: 'Dollar'.tr,
                                                                                      colorOn: AppColors.darkBlue,
                                                                                      colorOff: Colors.purple,
                                                                                      iconOn: CurIcon.afn,
                                                                                      iconOff: CurIcon.dollar,
                                                                                      textSize: 16.0,
                                                                                      onChanged: (bool state) {
                                                                                        state ? controller.curr = 'afn' : controller.curr = 'dollar';
                                                                                        print(controller.curr);
                                                                                      },
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              TextField(
                                                                                maxLength: 20,
                                                                                maxLengthEnforced: true,
                                                                                controller: controller.initialText,
                                                                                autofocus: true,
                                                                              ),
                                                                              SizedBox(
                                                                                height: 20,
                                                                              ),
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment.end,
                                                                                children: [
                                                                                  TextButton(
                                                                                      onPressed: () {
                                                                                        Get.back();
                                                                                      },
                                                                                      child: Text(
                                                                                        'cancle'.tr,
                                                                                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                                                                                      )),
                                                                                  TextButton(
                                                                                      onPressed: () async {
                                                                                        if (controller.initialText.text == '') {
                                                                                          Get.snackbar('Oops'.tr, "categoryCantEmpty".tr);
                                                                                          return;
                                                                                        }
                                                                                        try {
                                                                                          await InternetAddress.lookup('google.com');

                                                                                          databaseReference.child(getuser.uid).child('tasks').child(itemsMap[index]['itemKey']).update({
                                                                                            'name': controller.initialText.text,
                                                                                            'currency': controller.curr,
                                                                                          }).then((value) => Get.back());
                                                                                        } catch (e) {
                                                                                          Get.back();
                                                                                          controller.initialText.clear();

                                                                                          Get.defaultDialog(
                                                                                            title: 'Oops'.tr,
                                                                                            middleText: 'somethingWrong'.tr,
                                                                                          );
                                                                                        }
                                                                                      },
                                                                                      child: Text(
                                                                                        'update'.tr,
                                                                                        style: TextStyle(fontWeight: FontWeight.bold),
                                                                                      )),
                                                                                ],
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        padding:
                                                                            EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              40,
                                                                          vertical:
                                                                              30,
                                                                        ),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Colors.white,
                                                                          borderRadius:
                                                                              BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(20),
                                                                            topRight:
                                                                                Radius.circular(20),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                                child: Text(
                                                                    'edit'.tr,
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .black))),
                                                            TextButton(
                                                                onPressed: () {
                                                                  Get.back();
                                                                  Get.defaultDialog(
                                                                      title: '',
                                                                      content: Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.stretch,
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.symmetric(horizontal: 15),
                                                                            child:
                                                                                Text(
                                                                              'areYouSureYouWantToDeleteTheCategory'.tr,
                                                                              textAlign: TextAlign.start,
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.end,
                                                                            children: [
                                                                              TextButton(
                                                                                  onPressed: () {
                                                                                    Get.back();
                                                                                  },
                                                                                  child: Text(
                                                                                    'cancle'.tr,
                                                                                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                                                                                  )),
                                                                              TextButton(
                                                                                onPressed: () async {
                                                                                  try {
                                                                                    await InternetAddress.lookup('google.com');
                                                                                    databaseReference.child(getuser.uid).child('tasks').child(itemsMap[index]['itemKey']).remove().then((value) => Get.back());
                                                                                  } catch (e) {
                                                                                    Get.back();

                                                                                    Get.defaultDialog(
                                                                                      title: 'Oops'.tr,
                                                                                      middleText: 'somethingWrong'.tr,
                                                                                    );
                                                                                  }
                                                                                },
                                                                                child: Text(
                                                                                  'OK'.tr,
                                                                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ));
                                                                },
                                                                child: Text(
                                                                  'delete'.tr,
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .red),
                                                                ))
                                                          ],
                                                        )
                                                      ],
                                                    ));
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      Divider(),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'noCatYet'.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Container(
                            child:
                                Lottie.asset('assets/lot/10687-not-found.json',
                                    height: 270),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
