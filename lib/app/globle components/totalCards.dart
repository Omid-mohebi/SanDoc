import 'package:expance/app/modules/total/controllers/total_controller.dart';
import 'package:expance/app/routes/app_pages.dart';
import 'package:expance/theme/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ExpandedContainer extends StatelessWidget {
  const ExpandedContainer({
    Key key,
    @required this.controller,
    this.type,
    this.currency,
    this.goto,
  }) : super(key: key);

  final TotalController controller;
  final String type;
  final String currency;
  final VoidCallback goto;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GestureDetector(
          onTap: goto,
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
                color:
                    type == 'budget' ? AppColors.darkBlue : AppColors.chartBlue,
                borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(type.tr,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: type == 'budget' ? Colors.white : Colors.black,
                    )),
                StreamBuilder(
                  stream: controller.databaseReference
                      .child(controller.getuser.uid)
                      .child('tasks')
                      .child(controller.key1)
                      .child(type)
                      .onValue,
                  builder: (context, snapshot) {
                    Future.delayed(Duration.zero, () async {
                      type == 'budget'
                          ? controller.btotal.value = 0
                          : controller.stotal.value = 0;
                    });

                    Future.delayed(Duration.zero, () async {
                      controller.selects[0].value = true;
                    });
                    if (snapshot.data != null &&
                        snapshot.data.snapshot.value != null) {
                      snapshot.data.snapshot.value.forEach(
                        (key, val) {
                          if ('${controller.months[0]} 2021' ==
                              DateFormat.yMMM().format(
                                  DateTime.fromMicrosecondsSinceEpoch(
                                      val['date'] * 1000000))) {
                            Future.delayed(
                              Duration.zero,
                              () async {
                                type == 'budget'
                                    ? controller.btotal.value =
                                        controller.btotal.value + val['amount']
                                    : controller.stotal.value =
                                        controller.stotal.value + val['amount'];
                              },
                            );
                            Future.delayed(Duration.zero, () async {
                              controller.total.value = controller.btotal.value -
                                  controller.stotal.value;
                            });
                          }
                        },
                      );

                      return Obx(() => Text(
                            type == 'budget'
                                ? currency + controller.btotal.value.toString()
                                : currency + controller.stotal.value.toString(),
                            style: TextStyle(
                              fontSize: 30,
                              color: type == 'budget'
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ));
                    } else {
                      return Obx(
                        () => Text(
                          type == 'budget'
                              ? currency + controller.btotal.value.toString()
                              : currency + controller.stotal.value.toString(),
                          style: TextStyle(
                            fontSize: 30,
                            color:
                                type == 'budget' ? Colors.white : Colors.black,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
