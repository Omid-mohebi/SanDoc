import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expance/app/globle%20components/add.dart';
import 'package:expance/theme/AppColors.dart';
import 'package:expance/utils/stampChanger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:expance/app/modules/budget/controllers/budget_controller.dart';

class BudgetView extends GetView<BudgetController> {
  @override
  Widget build(BuildContext context) {
    controller.formatted =
        DateFormat.yMMMd().format(controller.selectedDate).obs;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'budget'.tr,
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: AppColors.specialBlackText),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(
                  () => Text(
                    (controller.val.value == 'afn' ? '؋' : '\$') +
                        controller.total.value.toString(),
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: AppColors.specialBlackText),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: AppColors.darkBlue,
        onPressed: () {
          Get.bottomSheet(
            Container(
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
                        'addBudget'.tr,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        maxLength: 20,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        controller: controller.textEditingController,
                        autofocus: true,
                        decoration:
                            InputDecoration(hintText: 'enterBudgetText'.tr),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        maxLength: 6,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        keyboardType: TextInputType.number,
                        controller: controller.amountController,
                        decoration:
                            InputDecoration(hintText: 'enterBudgetAmount'.tr),
                      ),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      TextButton(
                        onPressed: () {
                          controller.selectDate(context);
                        },
                        child: ListTile(
                          title: Text(
                            'selectDate'.tr,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          trailing: Obx(
                            () => Text(
                              controller.formatted.value,
                              style: TextStyle(),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              controller.amountController.clear();
                              controller.textEditingController.clear();
                              controller.selectedDate = DateTime.now();
                              controller.formatted = DateFormat.yMMMd()
                                  .format(controller.selectedDate)
                                  .obs;
                              Get.back();
                            },
                            child: Row(
                              children: [
                                Text(
                                  'cancle'.tr,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              print(controller.amountController.text);
                              if (controller.textEditingController.text == '' ||
                                  controller.amountController.text == '' ||
                                  int.parse(controller.amountController.text) <=
                                      0) {
                                Get.snackbar(
                                    'notifier'.tr, 'amountCantEmpty'.tr);
                                return;
                              }
                              Add.addBudget(
                                  key: controller.key,
                                  amountController: controller.amountController,
                                  textEditingController:
                                      controller.textEditingController,
                                  selectedDate: controller.selectedDate,
                                  type: 'budget');
                              controller.selectedDate = DateTime.now();
                              controller.formatted = DateFormat.yMMMd()
                                  .format(controller.selectedDate)
                                  .obs;
                            },
                            child: Row(
                              children: [
                                Text(
                                  'OK'.tr,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: StreamBuilder(
                stream: controller.databaseReference
                    .child(controller.getuser.uid)
                    .child('tasks')
                    .child(controller.key)
                    .child('budget')
                    .onValue,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data != null &&
                      snapshot.data.snapshot.value != null) {
                    Future.delayed(Duration.zero, () async {
                      controller.total.value = 0;
                    });
                    List<Map<dynamic, dynamic>> itemsMap = [];

                    snapshot.data.snapshot.value.forEach((key, val) {
                      itemsMap.add(
                        {'itemKey': key, 'itemValue': val},
                      );
                      Future.delayed(Duration.zero, () async {
                        controller.total.value =
                            controller.total.value + val['amount'];
                      });

                      itemsMap.sort((a, b) {
                        return b['itemValue']['date']
                            .compareTo(a['itemValue']['date']);
                      });
                    });
                    return Padding(
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
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        child: ListView.builder(
                            itemCount: itemsMap.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      onTap: () {
                                        Get.snackbar(
                                            'notifier'.tr, 'longPress'.tr);
                                      },
                                      onLongPress: () {
                                        Get.defaultDialog(
                                          title: '',
                                          content: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15),
                                                child: Text(
                                                  'deleteOrEdit'.tr,
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Get.back();
                                                      controller.initialText =
                                                          TextEditingController(
                                                              text: itemsMap[
                                                                          index]
                                                                      [
                                                                      'itemValue']
                                                                  ['title']);
                                                      controller.initialamount =
                                                          TextEditingController(
                                                              text: itemsMap[index]
                                                                          [
                                                                          'itemValue']
                                                                      ['amount']
                                                                  .toString());
                                                      controller.selectedDate =
                                                          (DateTime.fromMicrosecondsSinceEpoch(
                                                              itemsMap[index][
                                                                          'itemValue']
                                                                      ['date'] *
                                                                  1000000));
                                                      controller.formatted
                                                          .value = DateFormat
                                                              .yMMMd()
                                                          .format(controller
                                                              .selectedDate);
                                                      Get.bottomSheet(
                                                        Container(
                                                          child: Container(
                                                            child:
                                                                SingleChildScrollView(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .stretch,
                                                                children: [
                                                                  Text(
                                                                    'editBudget'
                                                                        .tr,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          20,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 20,
                                                                  ),
                                                                  TextField(
                                                                    maxLength:
                                                                        20,
                                                                    maxLengthEnforcement:
                                                                        MaxLengthEnforcement
                                                                            .enforced,
                                                                    controller:
                                                                        controller
                                                                            .initialText,
                                                                    autofocus:
                                                                        true,
                                                                    decoration: InputDecoration(
                                                                        hintText:
                                                                            'enterBudgetText'.tr),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  TextField(
                                                                    maxLength:
                                                                        6,
                                                                    maxLengthEnforcement:
                                                                        MaxLengthEnforcement
                                                                            .enforced,
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .number,
                                                                    controller:
                                                                        controller
                                                                            .initialamount,
                                                                    decoration: InputDecoration(
                                                                        hintText:
                                                                            'enterBudgetAmount'.tr),
                                                                  ),
                                                                  TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      controller
                                                                          .selectDate(
                                                                              context);
                                                                    },
                                                                    child:
                                                                        ListTile(
                                                                      title:
                                                                          Text(
                                                                        'selectDate'
                                                                            .tr,
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontWeight: FontWeight.bold),
                                                                      ),
                                                                      trailing:
                                                                          Obx(
                                                                        () =>
                                                                            Text(
                                                                          controller
                                                                              .formatted
                                                                              .value,
                                                                          style:
                                                                              TextStyle(),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          Get.back();
                                                                        },
                                                                        child:
                                                                            Text(
                                                                          'cancle'
                                                                              .tr,
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              color: Colors.black),
                                                                        ),
                                                                      ),
                                                                      TextButton(
                                                                        onPressed:
                                                                            () async {
                                                                          if (controller.initialText.text == '' ||
                                                                              controller.initialamount.text == '' ||
                                                                              int.parse(controller.initialamount.text) <= 0) {
                                                                            Get.defaultDialog(
                                                                                title: 'notifier'.tr,
                                                                                titleStyle: TextStyle(
                                                                                  color: Colors.red,
                                                                                  fontSize: 25,
                                                                                  fontWeight: FontWeight.bold,
                                                                                ),
                                                                                content: Center(
                                                                                  child: Column(
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                                    children: [
                                                                                      Text("amountCantEmpty".tr),
                                                                                      TextButton(
                                                                                          onPressed: () {
                                                                                            Get.back();
                                                                                          },
                                                                                          child: Text('OK'))
                                                                                    ],
                                                                                  ),
                                                                                ));
                                                                            return;
                                                                          }
                                                                          try {
                                                                            await InternetAddress.lookup('google.com');
                                                                            controller.databaseReference.child(controller.getuser.uid).child('tasks').child(controller.key).child('budget').child(itemsMap[index]['itemKey']).update(
                                                                              {
                                                                                'title': controller.initialText.text,
                                                                                'amount': int.parse(controller.initialamount.text),
                                                                                'date': Timestamp.fromDate(controller.selectedDate).seconds,
                                                                              },
                                                                            ).then((value) => Get.back());
                                                                          } catch (e) {
                                                                            Get.back();
                                                                            controller.initialText.clear();
                                                                            controller.initialamount.clear();
                                                                            controller.selectedDate =
                                                                                DateTime.now();
                                                                            Get.defaultDialog(
                                                                              title: 'Oops'.tr,
                                                                              middleText: 'somethingWrong'.tr,
                                                                            );
                                                                          }
                                                                        },
                                                                        child:
                                                                            Text(
                                                                          'update'
                                                                              .tr,
                                                                          style:
                                                                              TextStyle(fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                              horizontal: 40,
                                                              vertical: 30,
                                                            ),
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        20),
                                                                topRight: Radius
                                                                    .circular(
                                                                        20),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: Text(
                                                      'edit'.tr,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      Get.back();
                                                      Get.defaultDialog(
                                                          title: '',
                                                          content: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .stretch,
                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        15),
                                                                child: Text(
                                                                  "areYouSureYouWantToDeleteTheBudget"
                                                                      .tr,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                ),
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      Get.back();
                                                                    },
                                                                    child: Text(
                                                                      'cancle'
                                                                          .tr,
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ),
                                                                  TextButton(
                                                                    onPressed:
                                                                        () async {
                                                                      try {
                                                                        await InternetAddress.lookup(
                                                                            'google.com');
                                                                        controller
                                                                            .databaseReference
                                                                            .child(controller
                                                                                .getuser.uid)
                                                                            .child(
                                                                                'tasks')
                                                                            .child(controller
                                                                                .key)
                                                                            .child(
                                                                                'budget')
                                                                            .child(itemsMap[index][
                                                                                'itemKey'])
                                                                            .remove()
                                                                            .then((value) =>
                                                                                Get.back());
                                                                      } catch (e) {
                                                                        Get.back();

                                                                        Get.defaultDialog(
                                                                          title:
                                                                              'Oops'.tr,
                                                                          middleText:
                                                                              'somethingWrong'.tr,
                                                                        );
                                                                      }
                                                                    },
                                                                    child: Text(
                                                                      'OK'.tr,
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .red,
                                                                          fontWeight:
                                                                              FontWeight.bold),
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
                                                              FontWeight.bold,
                                                          color: Colors.red),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(16),
                                          child: Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    itemsMap[index]['itemValue']
                                                        ['title'],
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    '${DateFormat.yMMMd().format(DateTime.fromMicrosecondsSinceEpoch(itemsMap[index]['itemValue']['date'] * 1000000))}    ${readTimestamp(itemsMap[index]['itemValue']['date'])}',
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                              Expanded(child: Container()),
                                              Text(
                                                (controller.val.value == 'afn'
                                                        ? '؋'
                                                        : '\$') +
                                                    '${itemsMap[index]['itemValue']['amount']}',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Divider(),
                                  ],
                                ),
                              );
                            }),
                      ),
                    );
                  } else {
                    return Center(
                      child: Text(
                        'noBudgetYet'.tr,
                        style: TextStyle(fontSize: 25, color: Colors.grey),
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
