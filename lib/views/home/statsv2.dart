import 'dart:ffi';

import 'package:auto_ecole_app/models/user.dart';
import 'package:auto_ecole_app/utils/colors.dart';
import 'package:auto_ecole_app/views/home/controller/stats.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:get_storage/get_storage.dart';

class ThirdBarChartWidget extends StatefulWidget {
  const ThirdBarChartWidget({Key? key});

  @override
  State<ThirdBarChartWidget> createState() => _ThirdBarChartWidgetState();
}

class _ThirdBarChartWidgetState extends State<ThirdBarChartWidget> {
  final shadowColor = const Color(0xFFCCCCCC);
  late GetStorage boxs;
  User? conuser;

  double NbexamCode = 0;
  double NbexamsConduit = 0;
  double NbCondidats = 0;
  List<_ColorData> colorList = [];

  final barWidth = 3;

  final iconSize = 20;

  final titleTextSize = 10.0;

  final chartPadding = 4.0;
  final bottomTitlesMargin = 20.0;

  int touchedGroupIndex = -1;

  @override
  void initState() {
    super.initState();
    boxs = GetStorage();
    conuser = boxs.read('connectedUser');

    NbexamCode = (boxs.read('NbexamsCode') ?? 0).toDouble();
    NbexamsConduit = (boxs.read('NbexamsConduit') ?? 0).toDouble();
    NbCondidats = (boxs.read('Nbcandidat') ?? 0).toDouble();
    print(NbCondidats);
    colorList = [
      _ColorData(AppColors.blueGreen, NbCondidats, NbCondidats),
      _ColorData(AppColors.prussianBlue, NbexamCode, NbexamCode),
      _ColorData(AppColors.selectiveYellow, NbexamsConduit, NbexamsConduit),
    ];
  }

  Future<void> _fetchStats(User user) async {
    try {
      await GetStats.GetStatsCount(user);
    } catch (error) {
      print('Error fetching categories: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(chartPadding), // Apply chartPadding
      child: BarChart(chartData),
    );
  }

  BarChartData get chartData => BarChartData(
        alignment: BarChartAlignment.spaceBetween,
        borderData: borderData,
        gridData: gridData,
        barTouchData: barTouchData,
        titlesData: titlesData,
        barGroups: colorList.asMap().entries.map((e) {
          final index = e.key;
          final data = e.value;
          return generateBarGroupData(
            index,
            data.color,
            data.value,
            data.shadowValue,
          );
        }).toList(),
        maxY: 30,
      );

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border.symmetric(
          horizontal: BorderSide(
            color: Colors.grey[300]!,
            width: 2,
          ),
        ),
      );

  FlGridData get gridData => FlGridData(
        show: true,
        drawVerticalLine: false,
        getDrawingHorizontalLine: (value) => FlLine(
          color: Colors.grey[300]!,
          strokeWidth: 2,
        ),
      );

  BarTouchData get barTouchData => BarTouchData(
        enabled: true,
        handleBuiltInTouches: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipMargin: 0,
          getTooltipItem: (BarChartGroupData group, int groupIndex,
              BarChartRodData rod, int rodIndex) {
            return BarTooltipItem(
              rod.toY.toString(),
              TextStyle(
                fontWeight: FontWeight.bold,
                color: rod.color,
                fontSize: 12,
                shadows: const [
                  Shadow(
                    color: Colors.black26,
                    blurRadius: 12,
                  ),
                ],
              ),
            );
          },
        ),
        touchCallback: (event, response) {
          if (event.isInterestedForInteractions &&
              response != null &&
              response.spot != null) {
            setState(() {
              touchedGroupIndex = response.spot!.touchedBarGroupIndex;
            });
          } else {
            setState(() {
              touchedGroupIndex = -1;
            });
          }
        },
      );

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        leftTitles: AxisTitles(
          drawBelowEverything: true,
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 20, // Adjust reservedSize for left titles
            getTitlesWidget: (value, meta) {
              return Text(
                value.toInt().toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: titleTextSize, // Use titleTextSize variable
                ),
                textAlign: TextAlign.left,
              );
            },
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize:
                bottomTitlesMargin, // Adjust reservedSize for bottom titles
            getTitlesWidget: (value, meta) {
              final index = value.toInt();
              return SideTitleWidget(
                axisSide: meta.axisSide,
                child: IconWidget(
                  index: index,
                  isSelected: touchedGroupIndex == index,
                ),
              );
            },
          ),
        ),
      );

  BarChartGroupData generateBarGroupData(
    int x,
    Color color,
    double value,
    double shadowValue,
  ) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: value,
          color: color,
          width: 3,
        ),
        BarChartRodData(
          toY: shadowValue,
          color: shadowColor,
          width: 3,
        ),
      ],
      showingTooltipIndicators: touchedGroupIndex == x ? [0] : [],
    );
  }
}

class IconWidget extends StatelessWidget {
  const IconWidget({
    Key? key,
    required this.index,
    required this.isSelected,
  }) : super(key: key);

  final int index;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    Color iconColor;
    switch (index) {
      case 0:
        iconColor = AppColors.blueGreen; // Change to blueGreen
        break;
      case 1:
        iconColor = AppColors.prussianBlue; // Change to prussianBlue
        break;
      case 2:
        iconColor = AppColors.selectiveYellow; // Change to selectiveYellow
        break;
      default:
        iconColor = Colors.black;
    }

    IconData iconData;
    switch (index) {
      case 1:
        iconData = Icons.email;
        break;
      case 2:
        iconData = Icons.directions_car;
        break;
      default:
        iconData = Icons.face;
    }

    return Icon(
      iconData,
      color: isSelected ? Colors.blue : iconColor, // Use iconColor
      size: 20,
    );
  }
}

class _ColorData {
  const _ColorData(
    this.color,
    this.value,
    this.shadowValue,
  );
  final Color color;
  final double value;
  final double shadowValue;
}
