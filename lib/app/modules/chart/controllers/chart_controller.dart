import 'package:expance/theme/AppColors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChartController extends GetxController {
  var cur = ''.obs;
  List<String> curn = [];
  DatabaseReference databaseReference = FirebaseDatabase.instance.reference();
  User get getuser => FirebaseAuth.instance.currentUser;
  bool ischa = false;
  var btotal = 0.obs;
  var stotal = 0.obs;
  var total = 0.obs;
  List<String> droplist = [];
  List<Map<dynamic, dynamic>> itemsMap = [];
  var dropdownValue = ''.obs;
  bool isChanged = false;
  String myval;
  var barGroup1;
  var barGroup2;
  var barGroup3;
  var barGroup4;
  var barGroup5;
  var barGroup6;
  var sbarGroup1;
  var sbarGroup2;
  var sbarGroup3;
  var sbarGroup4;
  var sbarGroup5;
  var sbarGroup6;
  final Color leftBarColor = AppColors.darkBlue;
  final Color rightBarColor = AppColors.chartBlue;
  final double width = 7;
  var a;
  RxList<BarChartGroupData> showingBarGroups = <BarChartGroupData>[].obs;
  RxList<BarChartGroupData> sshowingBarGroups = <BarChartGroupData>[].obs;
  List<double> y1 = List<double>(6);
  List<double> y2 = List<double>(6);
  List<double> sy1 = List<double>(6);
  List<double> sy2 = List<double>(6);

  final count = 0.obs;
  List<String> first = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
  List<String> seconde = ['Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
  List<BarChartGroupData> items = [];
  List<BarChartGroupData> sitems = [];
  void mustChange(AsyncSnapshot snapshot, String choise) {
    if (snapshot.data != null && snapshot.data.snapshot.value != null) {
      snapshot.data.snapshot.value.forEach(
        (key, val) {
          if (val['budget'] != null && val['spend'] != null) {
            for (int i = 0; i < y1.length; i++) {
              y1[i] = 0;
              y2[i] = 0;
              sy1[i] = 0;
              sy2[i] = 0;
            }
            var tmp = itemsMap.map((e) {
              if (e['itemValue']['budget'] != null &&
                  e['itemValue']['spend'] != null)
                return {'budget': e['itemValue']['budget']};
            }).toList();
            tmp.removeWhere((element) => element == null);

            tmp[droplist.indexOf(choise)]['budget'].forEach(
              (bkey, bval) {
                switch (DateFormat.yMMM().format(
                    DateTime.fromMicrosecondsSinceEpoch(
                        bval['date'] * 1000000))) {
                  case 'Jan 2021':
                    y1[0] = y1[0] + bval['amount'];
                    break;
                  case 'Feb 2021':
                    y1[1] = y1[1] + bval['amount'];
                    break;
                  case 'Mar 2021':
                    y1[2] = y1[2] + bval['amount'];
                    break;
                  case 'Apr 2021':
                    y1[3] = y1[3] + bval['amount'];
                    break;
                  case 'May 2021':
                    y1[4] = y1[4] + bval['amount'];
                    break;
                  case 'Jun 2021':
                    y1[5] = y1[5] + bval['amount'];
                    break;
                  case 'Jul 2021':
                    sy1[0] = sy1[0] + bval['amount'];
                    break;
                  case 'Aug 2021':
                    sy1[1] = sy1[1] + bval['amount'];
                    break;
                  case 'Sep 2021':
                    sy1[2] = sy1[2] + bval['amount'];
                    break;
                  case 'Oct 2021':
                    sy1[3] = sy1[3] + bval['amount'];
                    break;
                  case 'Nov 2021':
                    sy1[4] = sy1[4] + bval['amount'];
                    break;
                  case 'Dec 2021':
                    sy1[5] = sy1[5] + bval['amount'];
                    break;
                  default:
                }
              },
            );
          }
          if (val['budget'] != null && val['spend'] != null) {
            var tmp = itemsMap.map((e) {
              if (e['itemValue']['budget'] != null &&
                  e['itemValue']['spend'] != null)
                return {'spend': e['itemValue']['spend']};
            }).toList();
            tmp.removeWhere((element) => element == null);

            tmp[droplist.indexOf(choise)]['spend'].forEach(
              (skey, sval) {
                switch (DateFormat.yMMM().format(
                    DateTime.fromMicrosecondsSinceEpoch(
                        sval['date'] * 1000000))) {
                  case 'Jan 2021':
                    y2[0] = y2[0] + sval['amount'];
                    break;
                  case 'Feb 2021':
                    y2[1] = y2[1] + sval['amount'];
                    break;
                  case 'Mar 2021':
                    y2[2] = y2[2] + sval['amount'];
                    break;
                  case 'Apr 2021':
                    y2[3] = y2[3] + sval['amount'];
                    break;
                  case 'May 2021':
                    y2[4] = y2[4] + sval['amount'];
                    break;
                  case 'Jun 2021':
                    y2[5] = y2[5] + sval['amount'];
                    break;
                  case 'Jul 2021':
                    sy2[0] = sy2[0] + sval['amount'];
                    break;
                  case 'Aug 2021':
                    sy2[1] = sy2[1] + sval['amount'];
                    break;
                  case 'Sep 2021':
                    sy2[2] = sy2[2] + sval['amount'];
                    break;
                  case 'Oct 2021':
                    sy2[3] = sy2[3] + sval['amount'];
                    break;
                  case 'Nov 2021':
                    sy2[4] = sy2[4] + sval['amount'];
                    break;
                  case 'Dec 2021':
                    sy2[5] = sy2[5] + sval['amount'];
                    break;
                  default:
                }
              },
            );
          }
          barGroup1 = makeGroupData(0, y1[0], y2[0]);
          barGroup2 = makeGroupData(1, y1[1], y2[1]);
          barGroup3 = makeGroupData(2, y1[2], y2[2]);
          barGroup4 = makeGroupData(3, y1[3], y2[3]);
          barGroup5 = makeGroupData(4, y1[4], y2[4]);
          barGroup6 = makeGroupData(5, y1[5], y2[5]);
          sbarGroup1 = makeGroupData(0, sy1[0], sy2[0]);
          sbarGroup2 = makeGroupData(1, sy1[1], sy2[1]);
          sbarGroup3 = makeGroupData(2, sy1[2], sy2[2]);
          sbarGroup4 = makeGroupData(3, sy1[3], sy2[3]);
          sbarGroup5 = makeGroupData(4, sy1[4], sy2[4]);
          sbarGroup6 = makeGroupData(5, sy1[5], sy2[5]);
          print(y2);
        },
      );
      items = [
        barGroup1,
        barGroup2,
        barGroup3,
        barGroup4,
        barGroup5,
        barGroup6
      ];
      sitems = [
        sbarGroup1,
        sbarGroup2,
        sbarGroup3,
        sbarGroup4,
        sbarGroup5,
        sbarGroup6
      ];
      showingBarGroups.clear();
      showingBarGroups.addAll(items);
      sshowingBarGroups.clear();
      sshowingBarGroups.addAll(sitems);
    }
  }

  void uiUpdate(List<dynamic> list, int index) {
    Future.delayed(Duration.zero, () async {
      btotal.value = 0;
      stotal.value = 0;
      total.value = 0;
    });
    list[index]['budget'].forEach(
      (key, val) {
        if (val != null) {
          Future.delayed(
            Duration.zero,
            () async {
              btotal = btotal + val['amount'];
            },
          );
        }
      },
    );
    list[index]['spend'].forEach(
      (key, val) {
        if (val != null) {
          Future.delayed(
            Duration.zero,
            () async {
              stotal = stotal + val['amount'];
            },
          );
        }
        Future.delayed(
          Duration.zero,
          () async {
            total.value = btotal.value - stotal.value;
          },
        );
      },
    );
  }

  @override
  void onInit() {
    super.onInit();
    for (int i = 0; i < y1.length; i++) {
      y1[i] = 0;
      y2[i] = 0;
      sy1[i] = 0;
      sy2[i] = 0;
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(barsSpace: 4, x: x, barRods: [
      BarChartRodData(
        y: y1,
        colors: [leftBarColor],
        width: width,
      ),
      BarChartRodData(
        y: y2,
        colors: [rightBarColor],
        width: width,
      ),
    ]);
  }
}
