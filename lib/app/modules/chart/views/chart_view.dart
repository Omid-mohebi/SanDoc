import 'package:expance/app/globle%20components/chart.dart';
import 'package:expance/app/globle%20components/homeCards.dart';
import 'package:expance/theme/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'package:get/get.dart';
import 'package:expance/app/modules/chart/controllers/chart_controller.dart';
import 'package:lottie/lottie.dart';

class ChartView extends GetView<ChartController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'graph'.tr,
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: AppColors.specialBlackText),
        ),
        actions: [
          StreamBuilder(
            stream: controller.databaseReference
                .child(controller.getuser.uid)
                .child('tasks')
                .onValue,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data != null &&
                  snapshot.data.snapshot.value != null) {
                for (int i = 0; i < controller.y1.length; i++) {
                  controller.y1[i] = 0;
                  controller.y2[i] = 0;
                  controller.sy1[i] = 0;
                  controller.sy2[i] = 0;
                }
                if (controller.droplist != []) {
                  controller.droplist.clear();
                }
                if (controller.itemsMap != null) {
                  controller.itemsMap.clear();
                }
                snapshot.data.snapshot.value.forEach(
                  (key, val) {
                    controller.itemsMap.add(
                      {'itemKey': key, 'itemValue': val},
                    );

                    controller.itemsMap.sort(
                      (a, b) {
                        return b['itemValue']['taskTime']
                            .compareTo(a['itemValue']['taskTime']);
                      },
                    );
                  },
                );
                var tmp = controller.itemsMap.map((e) {
                  if (e['itemValue']['spend'] != null &&
                      e['itemValue']['budget'] != null) {
                    return e['itemValue'];
                  }
                }).toList();
                tmp.removeWhere((element) => element == null);
                if (tmp.isNotEmpty) {
                  if (tmp[0]['budget'] != null && tmp[0]['spend'] != null) {
                    controller.droplist = controller.itemsMap.map((e) {
                      print(e['itemValue']['spend']);
                      if (e['itemValue']['budget'] != null &&
                          e['itemValue']['spend'] != null) {
                        return e['itemValue']['name'].toString();
                      }
                    }).toList();
                    controller.droplist
                        .removeWhere((element) => element == null);
                    print('ddddddddddd');

                    print(controller.droplist);
                    Future.delayed(Duration.zero, () async {
                      controller.dropdownValue.value = controller.droplist[0];
                    });

                    print(controller.dropdownValue.value);
                    Future.delayed(Duration.zero, () async {
                      controller.mustChange(
                          snapshot, controller.dropdownValue.value);
                    });
                    controller.curn = controller.itemsMap.map((e) {
                      print(e['itemValue']['spend']);
                      if (e['itemValue']['budget'] != null &&
                          e['itemValue']['spend'] != null) {
                        return e['itemValue']['currency'].toString();
                      }
                    }).toList();
                    controller.curn.removeWhere((element) => element == null);
                  }
                }
                return Padding(
                  padding: const EdgeInsets.only(right: 20.0, left: 20),
                  child: Row(
                    children: [
                      IconButton(
                          icon: Icon(
                            Icons.info_outline_rounded,
                            color: AppColors.chartBlue,
                          ),
                          onPressed: () {
                            Get.snackbar('notifier'.tr, 'dropmsg'.tr);
                          }),
                      Padding(
                        padding: const EdgeInsets.only(right: 0.0, left: 0),
                        child: Container(
                          height: 60,
                          width: 100,
                          child: DropdownButtonFormField<String>(
                            isExpanded: true,
                            value: controller.dropdownValue.value,
                            icon: Icon(
                              AntDesign.caretdown,
                              size: 10,
                              color: Colors.grey,
                            ),
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(color: Colors.black),
                            onChanged: (String newValue) {
                              controller.dropdownValue.value = newValue;
                              controller.myval = newValue;
                              controller.mustChange(snapshot, newValue);
                              controller.uiUpdate(
                                  tmp, controller.droplist.indexOf(newValue));
                              controller.cur.value = controller
                                  .curn[controller.droplist.indexOf(newValue)];
                              print(controller.cur.value);
                              controller.isChanged = true;
                            },
                            items: controller.droplist
                                .map<DropdownMenuItem<String>>(
                              (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(
                                        fontFamily: 'IranSans'),
                                  ),
                                );
                              },
                            ).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Container();
              }
            },
          )
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: StreamBuilder(
        stream: controller.databaseReference
            .child(controller.getuser.uid)
            .child('tasks')
            .onValue,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data != null && snapshot.data.snapshot.value != null) {
            print(controller.itemsMap);
            for (int i = 0; i < controller.y1.length; i++) {
              controller.y1[i] = 0;
              controller.y2[i] = 0;
              controller.sy1[i] = 0;
              controller.sy2[i] = 0;
            }
            if (controller.droplist != []) {
              controller.droplist.clear();
            }
            if (controller.itemsMap != null) {
              controller.itemsMap.clear();
            }
            snapshot.data.snapshot.value.forEach(
              (key, val) {
                controller.itemsMap.add(
                  {'itemKey': key, 'itemValue': val},
                );

                controller.itemsMap.sort(
                  (a, b) {
                    return b['itemValue']['taskTime']
                        .compareTo(a['itemValue']['taskTime']);
                  },
                );
                print(controller.itemsMap[0]['itemValue']['currency']);
                controller.cur.value =
                    controller.itemsMap[0]['itemValue']['currency'];
                print(controller.itemsMap);
              },
            );
            var tmp = controller.itemsMap.map((e) {
              if (e['itemValue']['spend'] != null &&
                  e['itemValue']['budget'] != null) {
                return e['itemValue'];
              }
            }).toList();
            tmp.removeWhere((element) => element == null);
            if (tmp.isNotEmpty) {
              if (tmp[0]['budget'] != null && tmp[0]['spend'] != null) {
                controller.droplist = controller.itemsMap.map((e) {
                  if (e['itemValue']['budget'] != null &&
                      e['itemValue']['spend'] != null) {
                    return e['itemValue']['name'].toString();
                  }
                }).toList();
                controller.droplist.removeWhere((element) => element == null);
                controller.dropdownValue.value = controller.droplist[0];
                controller.mustChange(snapshot, controller.dropdownValue.value);

                controller.uiUpdate(tmp, 0);
                return Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 7,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 20),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Incomeschart'.tr,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Expanded(child: Container()),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 11,
                                          width: 11,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(3),
                                            color: AppColors.darkBlue,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          'budget'.tr,
                                          style: TextStyle(
                                            fontSize: 11,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 11,
                                          width: 11,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(3),
                                            color: AppColors.chartBlue,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          'spend'.tr,
                                          style: TextStyle(
                                            fontSize: 11,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Directionality(
                                textDirection: TextDirection.ltr,
                                child: Expanded(
                                  child: PageView(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 15,
                                            left: 20,
                                            right: 20,
                                            top: 10),
                                        child: MyChart(
                                          months: controller.first,
                                          showingBarGroups:
                                              controller.showingBarGroups,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 15,
                                            left: 20,
                                            right: 20,
                                            top: 10),
                                        child: MyChart(
                                          months: controller.seconde,
                                          showingBarGroups:
                                              controller.sshowingBarGroups,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(() => Homeblocks(
                                curIcon:
                                    controller.cur.value == 'afn' ? '؋' : '\$',
                                color: Colors.red,
                                colorList: [
                                  Colors.white, Colors.white
                                ],
                                text: controller.btotal,
                                type: 'budget',
                                flex: 1,
                                icon: Icon(
                                  AntDesign.arrowdown,
                                  color: Colors.white,
                                  size: 12,
                                ),
                              )),
                          SizedBox(
                            width: 18,
                          ),
                          Obx(() => Homeblocks(
                                curIcon:
                                    controller.cur.value == 'afn' ? '؋' : '\$',
                                color: AppColors.green,
                                colorList: [
                                  Colors.white, Colors.white
                                ],
                                text: controller.stotal,
                                type: 'spend',
                                flex: 1,
                                icon: Icon(
                                  AntDesign.arrowup,
                                  color: Colors.white,
                                  size: 12,
                                ),
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Obx(() => Homeblocks(
                              flex: 1,
                              curIcon:
                                  controller.cur.value == 'afn' ? '؋' : '\$',
                              colorList: [
                                Colors.white, Colors.white
                              ],
                              hasDynamicSize: false,
                              text: controller.total,
                              type: 'total',
                              color: AppColors.darkBlue,
                              icon: Icon(
                                MaterialCommunityIcons.calculator_variant,
                                color: Colors.white,
                                size: 15,
                              ),
                            )),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'nosb'.tr,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                      ),
                    ),
                  ),
                );
              }
            } else {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'nosb'.tr,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                    ),
                  ),
                ),
              );
            }
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
                    child: Lottie.asset(
                      'assets/lot/10687-not-found.json',
                      height: 270,
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
