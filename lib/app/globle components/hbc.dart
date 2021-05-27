import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeBlockContainer extends StatelessWidget {
  const HomeBlockContainer({
    Key key,
    this.colorList,
    this.type,
    this.text,
    this.hasDynamicSize = true,
    this.icon,
    this.color,
    this.curIcon,
  }) : super(key: key);

  final List<Color> colorList;
  final String type;
  final text;
  final bool hasDynamicSize;
  final Icon icon;
  final Color color;
  final String curIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 7,
            blurRadius: 7,
            offset: Offset(0, 0),
          ),
        ],
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: colorList),
        borderRadius: BorderRadius.circular(20),
      ),
      height: 110,
      width: 130,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Text(
              type.tr,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: type == 'total' ? Colors.white : Colors.black,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Obx(
                      () => Flexible(
                        flex: 6,
                        child: Text(
                          curIcon + text.value.toString(),
                          style: TextStyle(
                            color:
                                type == 'total' ? Colors.white : Colors.black,
                            fontSize: hasDynamicSize
                                ? text.value.toString().length >= 6
                                    ? 14
                                    : 20
                                : 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(child: Container()),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: icon,
                  ),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
