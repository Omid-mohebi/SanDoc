import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Homeblocks extends StatelessWidget {
  const Homeblocks({
    Key key,
    this.colorList,
    this.text,
    this.type,
    this.hasDynamicSize = true,
    this.flex,
    this.icon,
    this.color,
    this.curIcon,
  }) : super(key: key);

  final List<Color> colorList;
  final String type;
  final text;
  final bool hasDynamicSize;
  final int flex;
  final Icon icon;
  final Color color;
  final String curIcon;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
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
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: colorList),
          borderRadius: BorderRadius.circular(20),
        ),
        height: 110,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Text(
                type.tr,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(
                    () => Text(
                      curIcon + text.value.toString(),
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                         fontSize: hasDynamicSize
                            ? text.value.toString().length >= 6
                                ? 14
                                : 20
                            : 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
