import 'package:expance/app/globle%20components/totalCards.dart';
import 'package:expance/app/routes/app_pages.dart';
import 'package:expance/theme/AppColors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:expance/app/modules/total/controllers/total_controller.dart';
import 'package:intl/intl.dart';

class TotalView extends GetView<TotalController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          controller.name,
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExpandedContainer(
              controller: controller,
              goto: () {
                Get.toNamed(Routes.BUDGET, arguments: {
                  'key': controller.key1,
                  'month': controller.selectedMonth
                });
              },
              type: 'budget',
              currency: controller.cur == 'afn' ? '؋' : '\$',
            ),
            ExpandedContainer(
              controller: controller,
              currency: controller.cur == 'afn' ? '؋' : '\$',
              type: 'spend',
              goto: () {
                Get.toNamed(Routes.SPEND, arguments: {
                  'key': controller.key1,
                  'month': controller.selectedMonth
                });
              },
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 7,
                          blurRadius: 7,
                          offset: Offset(0, 0),
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('total'.tr,
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold)),
                      Obx(
                        () => Text(
                          (controller.cur == 'afn' ? '؋' : '\$') +
                              controller.total.value.toString(),
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 150,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.months.length,
                  itemBuilder: (BuildContext context, int index) {
                    return StreamBuilder(
                      stream: controller.databaseReference
                          .child(controller.getuser.uid)
                          .child('tasks')
                          .child(controller.key1)
                          .child('budget')
                          .onValue,
                      builder: (context, snapshot) {
                        return StreamBuilder(
                          stream: controller.databaseReference
                              .child(controller.getuser.uid)
                              .child('tasks')
                              .child(controller.key1)
                              .child('spend')
                              .onValue,
                          builder: (context, snapshots) {
                            if (snapshot.data != null &&
                                snapshot.data.snapshot.value != null &&
                                snapshots.data != null &&
                                snapshots.data.snapshot.value != null) {
                              if (controller.selects[0].value) {
                                Future.delayed(Duration.zero, () async {
                                  controller.btotal.value = 0;
                                });
                                Future.delayed(Duration.zero, () async {
                                  controller.stotal.value = 0;
                                });
                                Future.delayed(Duration.zero, () async {
                                  controller.total.value = 0;
                                });
                                snapshot.data.snapshot.value
                                    .forEach((key, val) {
                                  Future.delayed(Duration.zero, () async {
                                    controller.btotal.value =
                                        controller.btotal.value + val['amount'];
                                  });
                                });

                                snapshots.data.snapshot.value
                                    .forEach((key, val) {
                                  Future.delayed(Duration.zero, () async {
                                    controller.stotal.value =
                                        controller.stotal.value + val['amount'];
                                  });
                                });
                                Future.delayed(Duration.zero, () async {
                                  controller.total.value =
                                      controller.btotal.value -
                                          controller.stotal.value;
                                });
                              }
                            }
                            // print("llllllll $index");
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 15),
                              child: GestureDetector(
                                onTap: () {
                                  for (int i = 0;
                                      i < controller.selects.length;
                                      i++) {
                                    controller.selects[i].value = false;
                                  }
                                  controller.selects[index].value = true;
                                  if (snapshot.data != null &&
                                      snapshot.data.snapshot.value != null &&
                                      snapshots.data != null &&
                                      snapshots.data.snapshot.value != null) {
                                    controller.btotal.value = 0;
                                    controller.stotal.value = 0;
                                    controller.total.value = 0;
                                    controller.selectedMonth =
                                        controller.months[index];
                                    controller.selectedMonth =
                                        controller.months[index];
                                    if (controller.months[index] == "All" ||
                                        controller.selects[0].value) {
                                      snapshot.data.snapshot.value
                                          .forEach((key, val) {
                                        controller.btotal.value =
                                            controller.btotal.value +
                                                val['amount'];
                                      });
                                      snapshots.data.snapshot.value
                                          .forEach((key, val) {
                                        controller.stotal.value =
                                            controller.stotal.value +
                                                val['amount'];
                                      });
                                      Future.delayed(Duration.zero, () async {
                                        controller.total.value =
                                            controller.btotal.value -
                                                controller.stotal.value;
                                      });
                                      return;
                                    }
                                    snapshot.data.snapshot.value.forEach(
                                      (key, val) {
                                        if ('${controller.months[index]} 2021' ==
                                            DateFormat.yMMM().format(DateTime
                                                .fromMicrosecondsSinceEpoch(
                                                    val['date'] * 1000000))) {
                                          print('holla');
                                          controller.btotal.value =
                                              controller.btotal.value +
                                                  val['amount'];
                                        }
                                      },
                                    );

                                    Future.delayed(Duration.zero, () async {
                                      controller.total.value =
                                          controller.btotal.value -
                                              controller.stotal.value;
                                    });
                                  }
                                  if (snapshots.data != null &&
                                      snapshots.data.snapshot.value != null) {
                                    controller.stotal.value = 0;
                                    snapshots.data.snapshot.value.forEach(
                                      (key, val) {
                                        if ('${controller.months[index]} 2021' ==
                                            DateFormat.yMMM().format(DateTime
                                                .fromMicrosecondsSinceEpoch(
                                                    val['date'] * 1000000))) {
                                          print('holla');
                                          controller.stotal.value =
                                              controller.stotal.value +
                                                  val['amount'];
                                        }
                                      },
                                    );
                                    Future.delayed(Duration.zero, () async {
                                      controller.total.value =
                                          controller.btotal.value -
                                              controller.stotal.value;
                                    });
                                  }
                                },
                                child: Obx(
                                  () => Container(
                                    height: 60,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: controller.selects[index].value
                                          ? AppColors.darkBlue
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.1),
                                          spreadRadius: 7,
                                          blurRadius: 7,
                                          offset: Offset(0, 0),
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Text(
                                        controller.months[index],
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: controller.selects[index].value
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
