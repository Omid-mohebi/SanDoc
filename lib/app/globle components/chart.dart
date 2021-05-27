import 'package:expance/theme/AppColors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyChart extends StatelessWidget {
  const MyChart({
    Key key,
    this.months,
    this.showingBarGroups,
  }) : super(key: key);
  final List<String> months;
  final RxList<BarChartGroupData> showingBarGroups;
  @override
  Widget build(BuildContext context) {
    return Obx(() => BarChart(
          BarChartData(
            barTouchData: BarTouchData(
              touchTooltipData: BarTouchTooltipData(
                tooltipBgColor: Colors.grey,
                getTooltipItem: (_a, _b, _c, _d) => null,
              ),
            ),
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: SideTitles(
                showTitles: true,
                getTextStyles: (value) => const TextStyle(
                    color: AppColors.lightGrayBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
                margin: 20,
                getTitles: (double value) {
                  switch (value.toInt()) {
                    case 0:
                      return months[0];
                    case 1:
                      return months[1];
                    case 2:
                      return months[2];
                    case 3:
                      return months[3];
                    case 4:
                      return months[4];
                    case 5:
                      return months[5];
                    default:
                      return '';
                  }
                },
              ),
              leftTitles: SideTitles(
                showTitles: true,
                getTextStyles: (value) => const TextStyle(
                    color: AppColors.lightGrayBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
                margin: 32,
                reservedSize: 14,
                getTitles: (value) {
                  if (value == 0) {
                    return '0K';
                  } else if (value == 1000) {
                    return '1K';
                  } else if (value == 10000) {
                    return '10K';
                  } else if (value == 100000) {
                    return '100K';
                  } else if (value == 1000000) {
                    return '1000K';
                  } else {
                    return '';
                  }
                },
              ),
            ),
            borderData: FlBorderData(
              show: false,
            ),
            barGroups: showingBarGroups,
          ),
        ));
  }
}
