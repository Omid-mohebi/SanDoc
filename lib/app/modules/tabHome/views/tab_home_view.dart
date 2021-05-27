import 'package:expance/app/globle%20components/step.dart';
import 'package:expance/theme/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

import 'package:expance/app/modules/tabHome/controllers/tab_home_controller.dart';
import 'package:lottie/lottie.dart';

class TabHomeView extends GetView<TabHomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: TabBarView(
          controller: controller.pageController,
          physics: NeverScrollableScrollPhysics(),
          // physics: BouncingScrollPhysics(),
          children: controller.screens,
        ),
        // PageView(
        //   onPageChanged: (index) {
        //     controller.pageChanged(index);
        //   },
        //   controller: controller.pageController,
        //   children: controller.screens,
        // ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
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
            height: 80,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(
                    () => Column(
                      children: [
                        IconButton(
                            icon: Icon(
                              Foundation.home,
                              size: 30,
                              color: controller.currentTab.value == 0
                                  ? AppColors.darkBlue
                                  : AppColors.chartBlue,
                            ),
                            onPressed: () {
                              controller.currentTab.value = 0;
                              controller
                                  .pageChanged(controller.currentTab.value);
                              controller.pageController.animateTo(0,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease);
                            }),
                        AnimatedContainer(
                          decoration: BoxDecoration(
                              color: AppColors.darkBlue,
                              borderRadius: BorderRadius.circular(10)),
                          duration: Duration(milliseconds: 300),
                          height: 6,
                          width: controller.w1.value,
                          curve: Curves.fastOutSlowIn,
                        )
                      ],
                    ),
                  ),
                  Obx(
                    () => Column(
                      children: [
                        IconButton(
                          icon: Icon(
                            Entypo.newsletter,
                            size: 25,
                            color: controller.currentTab.value == 1
                                ? AppColors.darkBlue
                                : AppColors.chartBlue,
                          ),
                          onPressed: () {
                            controller.currentTab.value = 1;
                            controller.pageChanged(controller.currentTab.value);
                            controller.pageController.animateTo(1,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease);
                          },
                        ),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                              color: AppColors.darkBlue,
                              borderRadius: BorderRadius.circular(10)),
                          height: 6,
                          width: controller.w2.value,
                          curve: Curves.fastOutSlowIn,
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 70,
                    width: 70,
                    child: FloatingActionButton(
                        child: Icon(
                          Icons.add,
                          size: 40,
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
                                  vertical: 30,
                                ),
                                child: StreamBuilder<Object>(
                                  stream: controller.databaseReference
                                      .child(controller.getuser.uid)
                                      .child('tasks')
                                      .onValue,
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (snapshot.data != null &&
                                        snapshot.data.snapshot.value != null) {
                                      controller.droplist.clear();
                                      controller.itemsMap.clear();
                                      snapshot.data.snapshot.value.forEach(
                                        (key, val) {
                                          controller.itemsMap.add(
                                            {'itemKey': key, 'itemValue': val},
                                          );

                                          controller.itemsMap.sort(
                                            (a, b) {
                                              return b['itemValue']['taskTime']
                                                  .compareTo(a['itemValue']
                                                      ['taskTime']);
                                            },
                                          );
                                        },
                                      );
                                      controller.droplist =
                                          controller.itemsMap.map((e) {
                                        return e['itemValue']['name']
                                            .toString();
                                      }).toList();
                                      print('ddddddddddd');

                                      print(controller.droplist);
                                      controller.dropdownValue.value =
                                          controller.droplist[0];
                                      print(controller.dropdownValue.value);

                                      print('ddddddd');
                                      print(controller.droplist);

                                      return SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'addBoth'.tr,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: AppColors
                                                            .specialBlackText),
                                                  ),
                                                  Expanded(child: Container()),
                                                  IconButton(
                                                      color:
                                                          AppColors.blueLight,
                                                      icon: Icon(Icons.close),
                                                      onPressed: () {
                                                        Get.back();
                                                      })
                                                ],
                                              ),
                                            ),
                                            Obx(
                                              () => MyStepper(
                                                steps: [
                                                  MyStep(
                                                    title: Text(
                                                      'category'.tr,
                                                    ),
                                                    isActive: true,
                                                    state: controller
                                                                .currentStep
                                                                .value ==
                                                            0
                                                        ? MyStepState.indexed
                                                        : MyStepState.complete,
                                                    content:
                                                        StreamBuilder<Object>(
                                                      stream: controller
                                                          .databaseReference
                                                          .child(controller
                                                              .getuser.uid)
                                                          .child('tasks')
                                                          .onValue,
                                                      builder:
                                                          (BuildContext context,
                                                              AsyncSnapshot
                                                                  snapshot) {
                                                        if (snapshot.data !=
                                                                null &&
                                                            snapshot
                                                                    .data
                                                                    .snapshot
                                                                    .value !=
                                                                null) {
                                                          if (controller
                                                                  .droplist !=
                                                              null) {
                                                            controller.droplist
                                                                .clear();
                                                          }
                                                          if (controller
                                                                  .itemsMap !=
                                                              null) {
                                                            controller.itemsMap
                                                                .clear();
                                                          }

                                                          snapshot.data.snapshot
                                                              .value
                                                              .forEach(
                                                                  (key, val) {
                                                            controller.itemsMap
                                                                .add(
                                                              {
                                                                'itemKey': key,
                                                                'itemValue': val
                                                              },
                                                            );

                                                            controller.itemsMap
                                                                .sort((a, b) {
                                                              return b['itemValue']
                                                                      [
                                                                      'taskTime']
                                                                  .compareTo(a[
                                                                          'itemValue']
                                                                      [
                                                                      'taskTime']);
                                                            });
                                                          });

                                                          var tmp = controller
                                                              .itemsMap
                                                              .map((e) {
                                                            return e['itemValue']
                                                                    ['name']
                                                                .toString();
                                                          }).toList();

                                                          if (tmp != null) {
                                                            controller.droplist
                                                                .addAll(tmp);
                                                          }

                                                          if (controller
                                                                  .dropdownValue
                                                                  .value ==
                                                              '') {
                                                            controller
                                                                    .dropdownValue
                                                                    .value =
                                                                controller
                                                                    .droplist[0];
                                                          }
                                                          return Column(
                                                            children: [
                                                              Container(
                                                                height: 60,
                                                                child: Obx(
                                                                  () => DropdownButtonFormField<
                                                                      String>(
                                                                    isExpanded:
                                                                        true,
                                                                    value: controller
                                                                        .dropdownValue
                                                                        .value,
                                                                    icon: Icon(
                                                                      AntDesign
                                                                          .caretdown,
                                                                      size: 10,
                                                                      color: Colors
                                                                          .grey,
                                                                    ),
                                                                    iconSize:
                                                                        24,
                                                                    elevation:
                                                                        16,
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'IranSans',
                                                                        color: Colors
                                                                            .black),
                                                                    onChanged:
                                                                        (String
                                                                            newValue) {
                                                                      controller
                                                                          .dropdownValue
                                                                          .value = newValue;
                                                                      print(controller
                                                                          .droplist
                                                                          .indexOf(controller
                                                                              .dropdownValue
                                                                              .value));
                                                                      print(controller
                                                                          .dropdownValue
                                                                          .value);
                                                                    },
                                                                    items: controller
                                                                        .droplist
                                                                        .map<
                                                                            DropdownMenuItem<
                                                                                String>>((String
                                                                            value) {
                                                                      return DropdownMenuItem<
                                                                          String>(
                                                                        value:
                                                                            value,
                                                                        child:
                                                                            Text(
                                                                          value,
                                                                          style:
                                                                              TextStyle(fontFamily: 'IranSans'),
                                                                        ),
                                                                      );
                                                                    }).toList(),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                        } else {
                                                          return Column(
                                                            children: [
                                                              Text('noCatYet'
                                                                  .tr),
                                                              SizedBox(
                                                                height: 7,
                                                              ),
                                                            ],
                                                          );
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                  MyStep(
                                                    isActive: controller
                                                                .currentStep
                                                                .value >=
                                                            1
                                                        ? true
                                                        : false,
                                                    state: controller
                                                                .currentStep
                                                                .value ==
                                                            1
                                                        ? MyStepState.editing
                                                        : controller.currentStep
                                                                    .value >
                                                                1
                                                            ? controller.amountcontroller
                                                                            .text ==
                                                                        '' ||
                                                                    int.parse(controller
                                                                            .amountcontroller
                                                                            .text) <=
                                                                        0
                                                                ? MyStepState
                                                                    .error
                                                                : MyStepState
                                                                    .complete
                                                            : MyStepState
                                                                .indexed,
                                                    title: Text('amount'.tr),
                                                    content: Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  bottom: 10,
                                                                  left: 20,
                                                                  right: 20,
                                                                  top: 0),
                                                          child: TextField(
                                                            maxLength: 6,
                                                            maxLengthEnforced:
                                                                true,
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            decoration:
                                                                InputDecoration(
                                                                    hintText:
                                                                        'amounthint'
                                                                            .tr),
                                                            controller: controller
                                                                .amountcontroller,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  MyStep(
                                                    isActive: controller
                                                                .currentStep
                                                                .value >=
                                                            2
                                                        ? true
                                                        : false,
                                                    state: controller
                                                                .currentStep
                                                                .value ==
                                                            2
                                                        ? MyStepState.editing
                                                        : controller.currentStep
                                                                    .value >
                                                                2
                                                            ? controller.amountcontroller
                                                                        .text ==
                                                                    ''
                                                                ? MyStepState
                                                                    .error
                                                                : MyStepState
                                                                    .complete
                                                            : MyStepState
                                                                .indexed,
                                                    title: Text('title'.tr),
                                                    content: Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  bottom: 10,
                                                                  left: 20,
                                                                  right: 20,
                                                                  top: 0),
                                                          child: TextField(
                                                            maxLength: 20,
                                                            maxLengthEnforced:
                                                                true,
                                                            decoration:
                                                                InputDecoration(
                                                                    hintText:
                                                                        'titlehint'
                                                                            .tr),
                                                            controller: controller
                                                                .titlecontroller,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  MyStep(
                                                    isActive: controller
                                                                .currentStep
                                                                .value >=
                                                            3
                                                        ? true
                                                        : false,
                                                    state: controller
                                                                .currentStep
                                                                .value ==
                                                            3
                                                        ? MyStepState.indexed
                                                        : controller.currentStep
                                                                    .value >
                                                                3
                                                            ? MyStepState
                                                                .complete
                                                            : MyStepState
                                                                .indexed,
                                                    title: Text('type'.tr),
                                                    content: Column(
                                                      children: [
                                                        Container(
                                                          height: 60,
                                                          child:
                                                              DropdownButtonFormField<
                                                                  String>(
                                                            value: controller
                                                                .sdropdownValue
                                                                .value,
                                                            icon: Icon(
                                                              AntDesign
                                                                  .caretdown,
                                                              size: 10,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                            iconSize: 24,
                                                            elevation: 16,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'IranSans',
                                                                color: Colors
                                                                    .black),
                                                            onChanged: (String
                                                                newValue) {
                                                              controller
                                                                  .sdropdownValue
                                                                  .value = newValue;
                                                              print(controller
                                                                  .sdropdownValue
                                                                  .value);
                                                            },
                                                            items: [
                                                              'spend'.tr,
                                                              'budget'.tr
                                                            ].map<
                                                                DropdownMenuItem<
                                                                    String>>((String
                                                                value) {
                                                              return DropdownMenuItem<
                                                                  String>(
                                                                value: value,
                                                                child:
                                                                    Text(value),
                                                              );
                                                            }).toList(),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                                contText: 'Continue'.tr,
                                                cancleText: 'cancle'.tr,
                                                currentStep: controller
                                                    .currentStep.value,
                                                onStepContinue: controller.next,
                                                onStepCancel: controller.cancel,
                                                onStepTapped: (step) =>
                                                    controller.goTo(step),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else {
                                      return ListView(
                                        children: [
                                          Text('noCatYet'.tr,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              )),
                                          TextButton(
                                            onPressed: () {
                                              Get.back();
                                              controller.pageChanged(1);
                                              controller.pageController
                                                  .animateTo(1,
                                                      duration: Duration(
                                                          milliseconds: 500),
                                                      curve: Curves.ease);
                                            },
                                            child: Text(
                                              'addNewCategory'.tr,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.darkBlue,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: Lottie.asset(
                                                'assets/lot/10687-not-found.json',
                                                height: 270),
                                          ),
                                        ],
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  Obx(
                    () => Column(
                      children: [
                        IconButton(
                          icon: Icon(
                            MaterialIcons.insert_chart,
                            size: 30,
                            color: controller.currentTab.value == 2
                                ? AppColors.darkBlue
                                : AppColors.chartBlue,
                          ),
                          onPressed: () {
                            controller.currentTab.value = 2;
                            controller.pageChanged(controller.currentTab.value);
                            controller.pageController.animateTo(2,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease);
                          },
                        ),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                              color: AppColors.darkBlue,
                              borderRadius: BorderRadius.circular(10)),
                          height: 6,
                          width: controller.w3.value,
                          curve: Curves.fastOutSlowIn,
                        )
                      ],
                    ),
                  ),
                  Obx(
                    () => Column(
                      children: [
                        IconButton(
                          icon: Icon(
                            Ionicons.ios_settings,
                            size: 30,
                            color: controller.currentTab.value == 3
                                ? AppColors.darkBlue
                                : AppColors.chartBlue,
                          ),
                          onPressed: () {
                            controller.currentTab.value = 3;
                            controller.pageChanged(controller.currentTab.value);
                            controller.pageController.animateTo(3,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease);
                          },
                        ),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                              color: AppColors.darkBlue,
                              borderRadius: BorderRadius.circular(10)),
                          height: 6,
                          width: controller.w4.value,
                          curve: Curves.fastOutSlowIn,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
        // BottomAppBar(
        //   elevation: 0,
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        //     child: Container(
        //       decoration: BoxDecoration(
        //         color: Colors.white,
        //         borderRadius: BorderRadius.circular(20),
        //         boxShadow: [
        //           BoxShadow(
        //             color: Colors.grey.withOpacity(0.2),
        //             spreadRadius: 7,
        //             blurRadius: 7,
        //             offset: Offset(0, 0),
        //           ),
        //         ],
        //       ),
        //       height: 80,
        //       child: Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           crossAxisAlignment: CrossAxisAlignment.center,
        //           children: <Widget>[
        //             Obx(
        //               () => Column(
        //                 children: [
        //                   IconButton(
        //                       icon: Icon(
        //                         Foundation.home,
        //                         size: 30,
        //                         color: controller.currentTab.value == 0
        //                             ? AppColors.darkBlue
        //                             : AppColors.chartBlue,
        //                       ),
        //                       onPressed: () {
        //                         controller.currentTab.value = 0;
        //                         controller.pageController.animateTo(0,
        //                             duration: Duration(milliseconds: 500),
        //                             curve: Curves.ease);
        //                       }),
        //                   AnimatedContainer(
        //                     decoration: BoxDecoration(
        //                         color: AppColors.darkBlue,
        //                         borderRadius: BorderRadius.circular(10)),
        //                     duration: Duration(milliseconds: 300),
        //                     height: 6,
        //                     width: controller.w1.value,
        //                     curve: Curves.fastOutSlowIn,
        //                   )
        //                 ],
        //               ),
        //             ),
        //             Obx(
        //               () => Column(
        //                 children: [
        //                   IconButton(
        //                     icon: Icon(
        //                       Entypo.newsletter,
        //                       size: 25,
        //                       color: controller.currentTab.value == 1
        //                           ? AppColors.darkBlue
        //                           : AppColors.chartBlue,
        //                     ),
        //                     onPressed: () {
        //                       controller.currentTab.value = 1;
        //                       controller.pageController.animateTo(1,
        //                           duration: Duration(milliseconds: 500),
        //                           curve: Curves.ease);
        //                     },
        //                   ),
        //                   AnimatedContainer(
        //                     duration: Duration(milliseconds: 300),
        //                     decoration: BoxDecoration(
        //                         color: AppColors.darkBlue,
        //                         borderRadius: BorderRadius.circular(10)),
        //                     height: 6,
        //                     width: controller.w2.value,
        //                     curve: Curves.fastOutSlowIn,
        //                   )
        //                 ],
        //               ),
        //             ),
        //             Container(
        //               height: 70,
        //               width: 70,
        //               child: FloatingActionButton(
        //                   child: Icon(
        //                     Icons.add,
        //                     size: 40,
        //                   ),
        //                   backgroundColor: AppColors.darkBlue,
        //                   onPressed: () {
        //                     Get.bottomSheet(
        //                       Container(
        //                         child: Container(
        //                           decoration: BoxDecoration(
        //                             color: Colors.white,
        //                             borderRadius: BorderRadius.only(
        //                               topLeft: Radius.circular(20),
        //                               topRight: Radius.circular(20),
        //                             ),
        //                           ),
        //                           padding: EdgeInsets.symmetric(
        //                             vertical: 30,
        //                           ),
        //                           child: StreamBuilder<Object>(
        //                             stream: controller.databaseReference
        //                                 .child(controller.getuser.uid)
        //                                 .child('tasks')
        //                                 .onValue,
        //                             builder: (BuildContext context,
        //                                 AsyncSnapshot snapshot) {
        //                               if (snapshot.data != null &&
        //                                   snapshot.data.snapshot.value != null) {
        //                                 controller.droplist.clear();
        //                                 controller.itemsMap.clear();
        //                                 snapshot.data.snapshot.value.forEach(
        //                                   (key, val) {
        //                                     controller.itemsMap.add(
        //                                       {'itemKey': key, 'itemValue': val},
        //                                     );

        //                                     controller.itemsMap.sort(
        //                                       (a, b) {
        //                                         return b['itemValue']['taskTime']
        //                                             .compareTo(a['itemValue']
        //                                                 ['taskTime']);
        //                                       },
        //                                     );
        //                                   },
        //                                 );
        //                                 controller.droplist =
        //                                     controller.itemsMap.map((e) {
        //                                   return e['itemValue']['name']
        //                                       .toString();
        //                                 }).toList();
        //                                 print('ddddddddddd');

        //                                 print(controller.droplist);
        //                                 controller.dropdownValue.value =
        //                                     controller.droplist[0];
        //                                 print(controller.dropdownValue.value);

        //                                 print('ddddddd');
        //                                 print(controller.droplist);

        //                                 return SingleChildScrollView(
        //                                   child: Column(
        //                                     children: [
        //                                       Padding(
        //                                         padding:
        //                                             const EdgeInsets.symmetric(
        //                                                 horizontal: 20),
        //                                         child: Row(
        //                                           children: [
        //                                             Text(
        //                                               'addBoth'.tr,
        //                                               style: TextStyle(
        //                                                   fontSize: 15,
        //                                                   fontWeight:
        //                                                       FontWeight.bold,
        //                                                   color: AppColors
        //                                                       .specialBlackText),
        //                                             ),
        //                                             Expanded(child: Container()),
        //                                             IconButton(
        //                                                 color:
        //                                                     AppColors.blueLight,
        //                                                 icon: Icon(Icons.close),
        //                                                 onPressed: () {
        //                                                   Get.back();
        //                                                 })
        //                                           ],
        //                                         ),
        //                                       ),
        //                                       Obx(
        //                                         () => MyStepper(
        //                                           steps: [
        //                                             MyStep(
        //                                               title: Text(
        //                                                 'category'.tr,
        //                                               ),
        //                                               isActive: true,
        //                                               state: controller
        //                                                           .currentStep
        //                                                           .value ==
        //                                                       0
        //                                                   ? MyStepState.indexed
        //                                                   : MyStepState.complete,
        //                                               content:
        //                                                   StreamBuilder<Object>(
        //                                                 stream: controller
        //                                                     .databaseReference
        //                                                     .child(controller
        //                                                         .getuser.uid)
        //                                                     .child('tasks')
        //                                                     .onValue,
        //                                                 builder:
        //                                                     (BuildContext context,
        //                                                         AsyncSnapshot
        //                                                             snapshot) {
        //                                                   if (snapshot.data !=
        //                                                           null &&
        //                                                       snapshot
        //                                                               .data
        //                                                               .snapshot
        //                                                               .value !=
        //                                                           null) {
        //                                                     if (controller
        //                                                             .droplist !=
        //                                                         null) {
        //                                                       controller.droplist
        //                                                           .clear();
        //                                                     }
        //                                                     if (controller
        //                                                             .itemsMap !=
        //                                                         null) {
        //                                                       controller.itemsMap
        //                                                           .clear();
        //                                                     }

        //                                                     snapshot.data.snapshot
        //                                                         .value
        //                                                         .forEach(
        //                                                             (key, val) {
        //                                                       controller.itemsMap
        //                                                           .add(
        //                                                         {
        //                                                           'itemKey': key,
        //                                                           'itemValue': val
        //                                                         },
        //                                                       );

        //                                                       controller.itemsMap
        //                                                           .sort((a, b) {
        //                                                         return b['itemValue']
        //                                                                 [
        //                                                                 'taskTime']
        //                                                             .compareTo(a[
        //                                                                     'itemValue']
        //                                                                 [
        //                                                                 'taskTime']);
        //                                                       });
        //                                                     });

        //                                                     var tmp = controller
        //                                                         .itemsMap
        //                                                         .map((e) {
        //                                                       return e['itemValue']
        //                                                               ['name']
        //                                                           .toString();
        //                                                     }).toList();

        //                                                     if (tmp != null) {
        //                                                       controller.droplist
        //                                                           .addAll(tmp);
        //                                                     }

        //                                                     if (controller
        //                                                             .dropdownValue
        //                                                             .value ==
        //                                                         '') {
        //                                                       controller
        //                                                               .dropdownValue
        //                                                               .value =
        //                                                           controller
        //                                                               .droplist[0];
        //                                                     }
        //                                                     return Column(
        //                                                       children: [
        //                                                         Container(
        //                                                           height: 60,
        //                                                           child: Obx(
        //                                                             () => DropdownButtonFormField<
        //                                                                 String>(
        //                                                               isExpanded:
        //                                                                   true,
        //                                                               value: controller
        //                                                                   .dropdownValue
        //                                                                   .value,
        //                                                               icon: Icon(
        //                                                                 AntDesign
        //                                                                     .caretdown,
        //                                                                 size: 10,
        //                                                                 color: Colors
        //                                                                     .grey,
        //                                                               ),
        //                                                               iconSize:
        //                                                                   24,
        //                                                               elevation:
        //                                                                   16,
        //                                                               style: TextStyle(
        //                                                                   fontFamily:
        //                                                                       'IranSans',
        //                                                                   color: Colors
        //                                                                       .black),
        //                                                               onChanged:
        //                                                                   (String
        //                                                                       newValue) {
        //                                                                 controller
        //                                                                     .dropdownValue
        //                                                                     .value = newValue;
        //                                                                 print(controller
        //                                                                     .droplist
        //                                                                     .indexOf(controller
        //                                                                         .dropdownValue
        //                                                                         .value));
        //                                                                 print(controller
        //                                                                     .dropdownValue
        //                                                                     .value);
        //                                                               },
        //                                                               items: controller
        //                                                                   .droplist
        //                                                                   .map<
        //                                                                       DropdownMenuItem<
        //                                                                           String>>((String
        //                                                                       value) {
        //                                                                 return DropdownMenuItem<
        //                                                                     String>(
        //                                                                   value:
        //                                                                       value,
        //                                                                   child:
        //                                                                       Text(
        //                                                                     value,
        //                                                                     style:
        //                                                                         TextStyle(fontFamily: 'IranSans'),
        //                                                                   ),
        //                                                                 );
        //                                                               }).toList(),
        //                                                             ),
        //                                                           ),
        //                                                         ),
        //                                                       ],
        //                                                     );
        //                                                   } else {
        //                                                     return Column(
        //                                                       children: [
        //                                                         Text('noCatYet'
        //                                                             .tr),
        //                                                         SizedBox(
        //                                                           height: 7,
        //                                                         ),
        //                                                       ],
        //                                                     );
        //                                                   }
        //                                                 },
        //                                               ),
        //                                             ),
        //                                             MyStep(
        //                                               isActive: controller
        //                                                           .currentStep
        //                                                           .value >=
        //                                                       1
        //                                                   ? true
        //                                                   : false,
        //                                               state: controller
        //                                                           .currentStep
        //                                                           .value ==
        //                                                       1
        //                                                   ? MyStepState.editing
        //                                                   : controller.currentStep
        //                                                               .value >
        //                                                           1
        //                                                       ? controller.amountcontroller
        //                                                                       .text ==
        //                                                                   '' ||
        //                                                               int.parse(controller
        //                                                                       .amountcontroller
        //                                                                       .text) <=
        //                                                                   0
        //                                                           ? MyStepState
        //                                                               .error
        //                                                           : MyStepState
        //                                                               .complete
        //                                                       : MyStepState
        //                                                           .indexed,
        //                                               title: Text('amount'.tr),
        //                                               content: Column(
        //                                                 children: [
        //                                                   Padding(
        //                                                     padding:
        //                                                         EdgeInsets.only(
        //                                                             bottom: 10,
        //                                                             left: 20,
        //                                                             right: 20,
        //                                                             top: 0),
        //                                                     child: TextField(
        //                                                       maxLength: 6,
        //                                                       maxLengthEnforced:
        //                                                           true,
        //                                                       keyboardType:
        //                                                           TextInputType
        //                                                               .number,
        //                                                       decoration:
        //                                                           InputDecoration(
        //                                                               hintText:
        //                                                                   'amounthint'
        //                                                                       .tr),
        //                                                       controller: controller
        //                                                           .amountcontroller,
        //                                                     ),
        //                                                   ),
        //                                                 ],
        //                                               ),
        //                                             ),
        //                                             MyStep(
        //                                               isActive: controller
        //                                                           .currentStep
        //                                                           .value >=
        //                                                       2
        //                                                   ? true
        //                                                   : false,
        //                                               state: controller
        //                                                           .currentStep
        //                                                           .value ==
        //                                                       2
        //                                                   ? MyStepState.editing
        //                                                   : controller.currentStep
        //                                                               .value >
        //                                                           2
        //                                                       ? controller.amountcontroller
        //                                                                   .text ==
        //                                                               ''
        //                                                           ? MyStepState
        //                                                               .error
        //                                                           : MyStepState
        //                                                               .complete
        //                                                       : MyStepState
        //                                                           .indexed,
        //                                               title: Text('title'.tr),
        //                                               content: Column(
        //                                                 children: [
        //                                                   Padding(
        //                                                     padding:
        //                                                         EdgeInsets.only(
        //                                                             bottom: 10,
        //                                                             left: 20,
        //                                                             right: 20,
        //                                                             top: 0),
        //                                                     child: TextField(
        //                                                       maxLength: 20,
        //                                                       maxLengthEnforced:
        //                                                           true,
        //                                                       decoration:
        //                                                           InputDecoration(
        //                                                               hintText:
        //                                                                   'titlehint'
        //                                                                       .tr),
        //                                                       controller: controller
        //                                                           .titlecontroller,
        //                                                     ),
        //                                                   ),
        //                                                 ],
        //                                               ),
        //                                             ),
        //                                             MyStep(
        //                                               isActive: controller
        //                                                           .currentStep
        //                                                           .value >=
        //                                                       3
        //                                                   ? true
        //                                                   : false,
        //                                               state: controller
        //                                                           .currentStep
        //                                                           .value ==
        //                                                       3
        //                                                   ? MyStepState.indexed
        //                                                   : controller.currentStep
        //                                                               .value >
        //                                                           3
        //                                                       ? MyStepState
        //                                                           .complete
        //                                                       : MyStepState
        //                                                           .indexed,
        //                                               title: Text('type'.tr),
        //                                               content: Column(
        //                                                 children: [
        //                                                   Container(
        //                                                     height: 60,
        //                                                     child:
        //                                                         DropdownButtonFormField<
        //                                                             String>(
        //                                                       value: controller
        //                                                           .sdropdownValue
        //                                                           .value,
        //                                                       icon: Icon(
        //                                                         AntDesign
        //                                                             .caretdown,
        //                                                         size: 10,
        //                                                         color:
        //                                                             Colors.grey,
        //                                                       ),
        //                                                       iconSize: 24,
        //                                                       elevation: 16,
        //                                                       style: TextStyle(
        //                                                           fontFamily:
        //                                                               'IranSans',
        //                                                           color: Colors
        //                                                               .black),
        //                                                       onChanged: (String
        //                                                           newValue) {
        //                                                         controller
        //                                                             .sdropdownValue
        //                                                             .value = newValue;
        //                                                         print(controller
        //                                                             .sdropdownValue
        //                                                             .value);
        //                                                       },
        //                                                       items: [
        //                                                         'spend'.tr,
        //                                                         'budget'.tr
        //                                                       ].map<
        //                                                           DropdownMenuItem<
        //                                                               String>>((String
        //                                                           value) {
        //                                                         return DropdownMenuItem<
        //                                                             String>(
        //                                                           value: value,
        //                                                           child:
        //                                                               Text(value),
        //                                                         );
        //                                                       }).toList(),
        //                                                     ),
        //                                                   ),
        //                                                 ],
        //                                               ),
        //                                             ),
        //                                           ],
        //                                           contText: 'Continue'.tr,
        //                                           cancleText: 'cancle'.tr,
        //                                           currentStep: controller
        //                                               .currentStep.value,
        //                                           onStepContinue: controller.next,
        //                                           onStepCancel: controller.cancel,
        //                                           onStepTapped: (step) =>
        //                                               controller.goTo(step),
        //                                         ),
        //                                       ),
        //                                     ],
        //                                   ),
        //                                 );
        //                               } else {
        //                                 return ListView(
        //                                   children: [
        //                                     Text('noCatYet'.tr,
        //                                         textAlign: TextAlign.center,
        //                                         style: TextStyle(
        //                                           fontWeight: FontWeight.bold,
        //                                           fontSize: 18,
        //                                         )),
        //                                     TextButton(
        //                                       onPressed: () {
        //                                         Get.back();
        //                                         controller.pageChanged(1);
        //                                         controller.pageController
        //                                             .animateTo(1,
        //                                                 duration: Duration(
        //                                                     milliseconds: 500),
        //                                                 curve: Curves.ease);
        //                                       },
        //                                       child: Text(
        //                                         'addNewCategory'.tr,
        //                                         style: TextStyle(
        //                                           fontWeight: FontWeight.bold,
        //                                           color: AppColors.darkBlue,
        //                                         ),
        //                                       ),
        //                                     ),
        //                                     Container(
        //                                       child: Lottie.asset(
        //                                           'assets/lot/10687-not-found.json',
        //                                           height: 270),
        //                                     ),
        //                                   ],
        //                                 );
        //                               }
        //                             },
        //                           ),
        //                         ),
        //                       ),
        //                     );
        //                   }),
        //             ),
        //             Obx(
        //               () => Column(
        //                 children: [
        //                   IconButton(
        //                     icon: Icon(
        //                       MaterialIcons.insert_chart,
        //                       size: 30,
        //                       color: controller.currentTab.value == 2
        //                           ? AppColors.darkBlue
        //                           : AppColors.chartBlue,
        //                     ),
        //                     onPressed: () {
        //                       controller.currentTab.value = 2;
        //                       controller.pageController.animateTo(2,
        //                           duration: Duration(milliseconds: 500),
        //                           curve: Curves.ease);
        //                     },
        //                   ),
        //                   AnimatedContainer(
        //                     duration: Duration(milliseconds: 300),
        //                     decoration: BoxDecoration(
        //                         color: AppColors.darkBlue,
        //                         borderRadius: BorderRadius.circular(10)),
        //                     height: 6,
        //                     width: controller.w3.value,
        //                     curve: Curves.fastOutSlowIn,
        //                   )
        //                 ],
        //               ),
        //             ),
        //             Obx(
        //               () => Column(
        //                 children: [
        //                   IconButton(
        //                     icon: Icon(
        //                       Ionicons.ios_settings,
        //                       size: 30,
        //                       color: controller.currentTab.value == 3
        //                           ? AppColors.darkBlue
        //                           : AppColors.chartBlue,
        //                     ),
        //                     onPressed: () {
        //                       controller.currentTab.value = 3;
        //                       controller.pageController.animateTo(3,
        //                           duration: Duration(milliseconds: 500),
        //                           curve: Curves.ease);
        //                     },
        //                   ),
        //                   AnimatedContainer(
        //                     duration: Duration(milliseconds: 300),
        //                     decoration: BoxDecoration(
        //                         color: AppColors.darkBlue,
        //                         borderRadius: BorderRadius.circular(10)),
        //                     height: 6,
        //                     width: controller.w4.value,
        //                     curve: Curves.fastOutSlowIn,
        //                   )
        //                 ],
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        );
  }
}
