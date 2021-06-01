import 'dart:io';

import 'package:expance/app/globle%20components/curIcon.dart';
import 'package:expance/app/globle%20components/hbc.dart';
import 'package:expance/theme/AppColors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'package:get/get.dart';

import 'package:expance/app/modules/home/controllers/home_controller.dart';
import 'package:intl/intl.dart' as INTL;
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          INTL.DateFormat.yMMMEd().format(DateTime.now()),
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.specialBlackText),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              child: CircleAvatar(
                  radius: 17,
                  backgroundImage:
                      NetworkImage(FirebaseAuth.instance.currentUser.photoURL)),
            ),
          ),
        ],
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Text(
                          'currenttask'.tr,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontFamily: 'IranSans',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.chartBlue),
                          overflow: TextOverflow.fade,
                        ),
                        Obx(
                          () => Text(
                            controller.taskName.value,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontFamily: 'IranSans',
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppColors.blueLight),
                            overflow: TextOverflow.fade,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(child: Container()),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 200,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          child: Obx(() => HomeBlockContainer(
                                color: Colors.white,
                                curIcon:
                                    controller.cur.value == 'afn' ? '؋' : '\$',
                                colorList: [
                                  AppColors.darkBlue,
                                  AppColors.darkBlue,
                                ],
                                text: controller.total,
                                type: 'total',
                                icon: Icon(
                                  MaterialCommunityIcons.calculator_variant,
                                  color: AppColors.darkBlue,
                                  size: 13,
                                ),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Obx(() => HomeBlockContainer(
                                color: AppColors.darkBlue,
                                curIcon:
                                    controller.cur.value == 'afn' ? '؋' : '\$',
                                colorList: [
                                  Colors.white,
                                  Colors.white,
                                ],
                                text: controller.btotal,
                                type: 'budget',
                                icon: Icon(
                                  AntDesign.arrowdown,
                                  color: Colors.white,
                                  size: 13,
                                ),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          child: Obx(() => HomeBlockContainer(
                                color: AppColors.darkBlue,
                                curIcon:
                                    controller.cur.value == 'afn' ? '؋' : '\$',
                                colorList: [
                                  Colors.white,
                                  Colors.white,
                                ],
                                text: controller.stotal,
                                type: 'spend',
                                icon: Icon(
                                  AntDesign.arrowup,
                                  color: Colors.white,
                                  size: 13,
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 7,
                            blurRadius: 7,
                            offset: Offset(0, 0),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            child: Row(
                              children: [
                                Text('categories'.tr,
                                    style: TextStyle(
                                        fontFamily: 'IranSans',
                                        fontSize: 18,
                                        color: AppColors.specialBlackText,
                                        fontWeight: FontWeight.bold)),
                                IconButton(
                                  icon: Icon(
                                    Icons.info_outline_rounded,
                                    color: AppColors.chartBlue,
                                  ),
                                  onPressed: () {
                                    Get.snackbar('notifier'.tr, 'longPress'.tr);
                                  },
                                ),
                                Expanded(child: Container()),
                                StreamBuilder(
                                  stream: controller.databaseReference
                                      .child(controller.getuser.uid)
                                      .child('tasks')
                                      .onValue,
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    return IconButton(
                                      icon: Icon(
                                        Icons.refresh,
                                        color: AppColors.blueLight,
                                      ),
                                      onPressed: () {
                                        if (snapshot.data != null &&
                                            snapshot.data.snapshot.value !=
                                                null) {
                                          if (!controller.isChanged) {
                                            controller.itemsMap.clear();
                                            Future.delayed(Duration.zero,
                                                () async {
                                              controller.btotal.value = 0;
                                              controller.stotal.value = 0;
                                            });
                                            snapshot.data.snapshot.value
                                                .forEach(
                                              (key, val) {
                                                controller.itemsMap.add(
                                                  {
                                                    'itemKey': key,
                                                    'itemValue': val
                                                  },
                                                );
                                                if (val['budget'] != null) {
                                                  val['budget'].forEach(
                                                    (bkey, bval) {
                                                      Future.delayed(
                                                        Duration.zero,
                                                        () async {
                                                          controller.btotal =
                                                              controller
                                                                      .btotal +
                                                                  bval[
                                                                      'amount'];
                                                        },
                                                      );
                                                    },
                                                  );
                                                }
                                                if (val['spend'] != null) {
                                                  val['spend'].forEach(
                                                    (skey, sval) {
                                                      Future.delayed(
                                                        Duration.zero,
                                                        () async {
                                                          controller.stotal =
                                                              controller
                                                                      .stotal +
                                                                  sval[
                                                                      'amount'];
                                                        },
                                                      );
                                                    },
                                                  );
                                                }
                                                controller.itemsMap.sort(
                                                  (a, b) {
                                                    return b['itemValue']
                                                            ['taskTime']
                                                        .compareTo(
                                                            a['itemValue']
                                                                ['taskTime']);
                                                  },
                                                );
                                              },
                                            );
                                          } else {
                                            controller.itemsMap.clear();
                                            snapshot.data.snapshot.value
                                                .forEach((key, val) {
                                              controller.itemsMap.add(
                                                {
                                                  'itemKey': key,
                                                  'itemValue': val
                                                },
                                              );
                                            });
                                            controller.itemsMap.sort(
                                              (a, b) {
                                                return b['itemValue']
                                                        ['taskTime']
                                                    .compareTo(a['itemValue']
                                                        ['taskTime']);
                                              },
                                            );
                                          }
                                          if (controller.itemsMap.isEmpty) {
                                            Future.delayed(Duration.zero,
                                                () async {
                                              controller.btotal.value = 0;
                                              controller.stotal.value = 0;
                                            });
                                          }
                                        }
                                        controller.stotal.value = 0;
                                        controller.btotal.value = 0;
                                        if (controller.itemsMap.isNotEmpty) {
                                          if (controller.itemsMap[
                                                      controller.myIndex.value]
                                                  ['itemValue']['spend'] !=
                                              null) {
                                            controller.itemsMap[
                                                    controller.myIndex.value]
                                                    ['itemValue']['spend']
                                                .forEach((key, val) {
                                              controller.stotal.value =
                                                  controller.stotal.value +
                                                      val['amount'];
                                            });
                                          }
                                          if (controller.itemsMap[
                                                      controller.myIndex.value]
                                                  ['itemValue']['budget'] !=
                                              null) {
                                            controller.itemsMap[
                                                    controller.myIndex.value]
                                                    ['itemValue']['budget']
                                                .forEach((key, val) {
                                              controller.btotal.value =
                                                  controller.btotal.value +
                                                      val['amount'];
                                            });
                                          }
                                          controller.taskName.value =
                                              controller.itemsMap[controller
                                                  .myIndex
                                                  .value]['itemValue']['name'];
                                        } else {
                                          controller.taskName.value = 'Empty';
                                        }
                                        controller.total.value =
                                            controller.btotal.value -
                                                controller.stotal.value;
                                        print(controller.itemsMap);
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          StreamBuilder(
                            stream: controller.databaseReference
                                .child(controller.getuser.uid)
                                .child('tasks')
                                .onValue,
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.data != null &&
                                  snapshot.data.snapshot.value != null) {
                                if (!controller.isChanged) {
                                  controller.itemsMap.clear();
                                  Future.delayed(Duration.zero, () async {
                                    controller.btotal.value = 0;
                                    controller.stotal.value = 0;
                                    controller.total.value = 0;
                                  });
                                  snapshot.data.snapshot.value.forEach(
                                    (key, val) {
                                      controller.itemsMap.add(
                                        {'itemKey': key, 'itemValue': val},
                                      );
                                    },
                                  );
                                  controller.itemsMap.sort(
                                    (a, b) {
                                      return b['itemValue']['taskTime']
                                          .compareTo(
                                              a['itemValue']['taskTime']);
                                    },
                                  );
                                  print('zzzzzzzz');
                                  if (controller.itemsMap[0]['itemValue']
                                          ['spend'] !=
                                      null) {
                                    controller.itemsMap[0]['itemValue']['spend']
                                        .forEach((key, val) {
                                      Future.delayed(
                                        Duration.zero,
                                        () async {
                                          controller.stotal.value =
                                              controller.stotal.value +
                                                  val['amount'];
                                        },
                                      );
                                    });
                                  }
                                  if (controller.itemsMap[0]['itemValue']
                                          ['budget'] !=
                                      null) {
                                    controller.itemsMap[0]['itemValue']
                                            ['budget']
                                        .forEach((key, val) {
                                      Future.delayed(
                                        Duration.zero,
                                        () async {
                                          controller.btotal.value =
                                              controller.btotal.value +
                                                  val['amount'];
                                        },
                                      );
                                    });
                                  }

                                  Future.delayed(
                                    Duration.zero,
                                    () async {
                                      controller.total.value =
                                          controller.btotal.value -
                                              controller.stotal.value;
                                    },
                                  );
                                  Future.delayed(
                                    Duration.zero,
                                    () async {
                                      controller.taskName.value = controller
                                          .itemsMap[0]['itemValue']['name'];
                                    },
                                  );
                                  Future.delayed(
                                    Duration.zero,
                                    () async {
                                      controller.taskName.value = controller
                                          .itemsMap[0]['itemValue']['name'];
                                    },
                                  );
                                  Future.delayed(
                                    Duration.zero,
                                    () async {
                                      controller.total.value =
                                          controller.btotal.value -
                                              controller.stotal.value;
                                    },
                                  );
                                } else {
                                  controller.itemsMap.clear();
                                  snapshot.data.snapshot.value
                                      .forEach((key, val) {
                                    controller.itemsMap.add(
                                      {'itemKey': key, 'itemValue': val},
                                    );
                                  });
                                  controller.itemsMap.sort(
                                    (a, b) {
                                      return b['itemValue']['taskTime']
                                          .compareTo(
                                              a['itemValue']['taskTime']);
                                    },
                                  );
                                }
                                if (controller.itemsMap.isEmpty) {
                                  Future.delayed(Duration.zero, () async {
                                    controller.btotal.value = 0;
                                    controller.stotal.value = 0;
                                  });
                                }
                                Future.delayed(Duration.zero, () async {
                                  controller.cur.value = controller.itemsMap[0]
                                      ['itemValue']['currency'];
                                });

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: controller.itemsMap.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return GestureDetector(
                                        behavior: HitTestBehavior.translucent,
                                        onTap: () {
                                          controller.myIndex.value = index;
                                          controller.stotal.value = 0;
                                          controller.btotal.value = 0;
                                          controller.total.value = 0;

                                          controller.isChanged = true;
                                          if (controller.itemsMap[index]
                                                  ['itemValue']['spend'] !=
                                              null) {
                                            controller.itemsMap[index]
                                                    ['itemValue']['spend']
                                                .forEach((key, val) {
                                              controller.stotal.value =
                                                  controller.stotal.value +
                                                      val['amount'];
                                            });
                                          }
                                          if (controller.itemsMap[index]
                                                  ['itemValue']['budget'] !=
                                              null) {
                                            controller.itemsMap[index]
                                                    ['itemValue']['budget']
                                                .forEach((key, val) {
                                              controller.btotal.value =
                                                  controller.btotal.value +
                                                      val['amount'];
                                            });
                                          }
                                          controller.total.value =
                                              controller.btotal.value -
                                                  controller.stotal.value;
                                          controller.taskName.value =
                                              controller.itemsMap[index]
                                                  ['itemValue']['name'];
                                          controller.cur.value =
                                              controller.itemsMap[index]
                                                  ['itemValue']['currency'];
                                        },
                                        onLongPress: () {
                                          Get.defaultDialog(
                                            title: '',
                                            content: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
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
                                                          controller.initialText
                                                              .text = controller
                                                                      .itemsMap[
                                                                  index][
                                                              'itemValue']['name'];
                                                          controller
                                                              .curr = controller
                                                                          .itemsMap[
                                                                      index]
                                                                  ['itemValue']
                                                              ['currency'];
                                                          Get.bottomSheet(
                                                              Container(
                                                            color: AppColors
                                                                .lightGrayBlue,
                                                            child: Container(
                                                              child:
                                                                  SingleChildScrollView(
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .stretch,
                                                                  children: [
                                                                    Text(
                                                                      'editCategory'
                                                                          .tr,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            20,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          15,
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                          'currency'
                                                                              .tr,
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 15),
                                                                        ),
                                                                        Expanded(
                                                                            child:
                                                                                Container()),
                                                                        Directionality(
                                                                          textDirection:
                                                                              TextDirection.ltr,
                                                                          child:
                                                                              LiteRollingSwitch(
                                                                            value: controller.curr == 'afn'
                                                                                ? true
                                                                                : false,
                                                                            textOn:
                                                                                'Afghani'.tr,
                                                                            textOff:
                                                                                'Dollar'.tr,
                                                                            colorOn:
                                                                                AppColors.darkBlue,
                                                                            colorOff:
                                                                                Colors.purple,
                                                                            iconOn:
                                                                                CurIcon.afn,
                                                                            iconOff:
                                                                                CurIcon.dollar,
                                                                            textSize:
                                                                                16.0,
                                                                            onChanged:
                                                                                (bool state) {
                                                                              state ? controller.curr = 'afn' : controller.curr = 'dollar';
                                                                              print(controller.curr);
                                                                            },
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    TextField(
                                                                      maxLength:
                                                                          20,
                                                                      maxLengthEnforced:
                                                                          true,
                                                                      controller:
                                                                          controller
                                                                              .initialText,
                                                                      autofocus:
                                                                          true,
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          20,
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
                                                                            'cancle'.tr,
                                                                            style:
                                                                                TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                        TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            if (controller.initialText.text ==
                                                                                '') {
                                                                              Get.snackbar('notifier'.tr, "categoryCantEmpty".tr);
                                                                              return;
                                                                            }
                                                                            controller.databaseReference.child(controller.getuser.uid).child('tasks').child(controller.itemsMap[index]['itemKey']).update(
                                                                              {
                                                                                'name': controller.initialText.text,
                                                                                'currency': controller.curr,
                                                                              },
                                                                            ).then((value) => Get.back());
                                                                          },
                                                                          child:
                                                                              Text(
                                                                            'update'.tr,
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
                                                                color: Colors
                                                                    .white,
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
                                                          ));
                                                        },
                                                        child: Text(
                                                          'edit'.tr,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
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
                                                                    'areYouSureYouWantToDeleteTheCategory'
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
                                                                      child:
                                                                          Text(
                                                                        'cancle'
                                                                            .tr,
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontWeight: FontWeight.bold),
                                                                      ),
                                                                    ),
                                                                    TextButton(
                                                                      onPressed:
                                                                          () async {
                                                                        try {
                                                                          controller
                                                                              .databaseReference
                                                                              .child(controller.getuser.uid)
                                                                              .child('tasks')
                                                                              .child(controller.itemsMap[index]['itemKey'])
                                                                              .remove()
                                                                              .then(
                                                                                (value) => Get.back(),
                                                                              );

                                                                          controller
                                                                              .itemsMap
                                                                              .clear();
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
                                                                      child:
                                                                          Text(
                                                                        'OK'.tr,
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.red,
                                                                            fontWeight: FontWeight.bold),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                        child: Text(
                                                          'delete'.tr,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.red,
                                                          ),
                                                        )),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Column(
                                            children: [
                                              Divider(
                                                color: Colors.grey,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(vertical: 8),
                                                    child: Text(
                                                      controller.itemsMap[index]
                                                          ['itemValue']['name'],
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(
                                      'noCatYet'.tr,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 25,
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
