import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class TotalController extends GetxController {
  String selectedMonth = 'All';
  var key1;
  String cur;
  DatabaseReference databaseReference = FirebaseDatabase.instance.reference();
  User get getuser => FirebaseAuth.instance.currentUser;
  var btotal = 0.obs;
  var stotal = 0.obs;
  var total = 0.obs;
  List<dynamic> months = [];
  var selects = [
    true.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
  ];
  var spendTotal = 0.obs;
  String name = '';
  Map<String, dynamic> myMap;

  @override
  void onInit() {
    Get.put(selectedMonth, tag: 'theMonth');
    super.onInit();
    months.add(-1);
    var monthNow = DateTime.now().month - 1;
    for (int i = monthNow; i <= 12; i++) {
      if (i == 12) {
        print('hi');
        for (int k = 0; k < monthNow; k++) {
          months.add(k);
        }
      } else {
        months.add(i);
      }
    }
    print(months);
    for (int i in months) {
      switch (i) {
        case -1:
          months[months.indexOf(-1)] = 'All';
          break;
        case 0:
          months[months.indexOf(0)] = 'Jan';
          break;
        case 1:
          months[months.indexOf(1)] = 'Feb';
          break;
        case 2:
          months[months.indexOf(2)] = 'Mar';
          break;
        case 3:
          months[months.indexOf(3)] = 'Apr';
          break;
        case 4:
          months[months.indexOf(4)] = 'May';
          break;
        case 5:
          months[months.indexOf(5)] = 'Jun';
          break;
        case 6:
          months[months.indexOf(6)] = 'Jul';
          break;
        case 7:
          months[months.indexOf(7)] = 'Aug';
          break;
        case 8:
          months[months.indexOf(8)] = 'Sep';
          break;
        case 9:
          months[months.indexOf(9)] = 'Oct';
          break;
        case 10:
          months[months.indexOf(10)] = 'Nov';
          break;
        case 11:
          months[months.indexOf(11)] = 'Dec';
          break;
        default:
      }
    }
    print(months);
    // selects[0].value = true;
    myMap = Get.arguments;
    key1 = myMap['key'];
    cur = myMap['currency'];
    name = myMap['name'];
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
