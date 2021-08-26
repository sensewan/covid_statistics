import 'package:covid_statistics/src/models/Covid19Model.dart';
import 'package:covid_statistics/src/utils/DataUtils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CovidBarChart extends StatelessWidget {
  CovidBarChart({Key? key, required this.covidDatas, required this.maxY}) : super(key: key);

  // 차트용 데이터 받기
  final List<Covid19Model> covidDatas;
  final double maxY;

  @override
  Widget build(BuildContext context) {
    int x = 0;
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        // ↱ maxY 즉 y 축의 제일 높은 점을 정하기.. (*1.4를 함으로써 높이가 오버되지 않음)
        maxY: maxY*1.4,
        barTouchData: BarTouchData(
          enabled: false,
          touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.transparent,
            tooltipPadding: const EdgeInsets.all(0),
            tooltipMargin: 8,
            getTooltipItem: (
                BarChartGroupData group,
                int groupIndex,
                BarChartRodData rod,
                int rodIndex,
                ) {
              return BarTooltipItem(
                rod.y.round().toString(),
                TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: SideTitles(
            showTitles: true,
            getTextStyles: (context, value) => const TextStyle(
                color: Color(0xff7589a2), fontWeight: FontWeight.bold, fontSize: 14),
            margin: 20,
            getTitles: (double value) {
              return DataUtils.simpleDayFormat(covidDatas[value.toInt()].stateDt!);
            },
          ),
          leftTitles: SideTitles(showTitles: false),
        ),
        borderData: FlBorderData(
          show: false,
        ),

        // covidDatas 의 값만큼 반복하기
        barGroups: this.covidDatas.map<BarChartGroupData>((covidData) {
           return BarChartGroupData(
              x: x++,
              barRods: [
                BarChartRodData(
                  y: covidData.calcDecideCnt!,
                  colors: [Colors.lightBlueAccent, Colors.greenAccent]
                ),
              ],
              showingTooltipIndicators: [0],
            );
        }).toList(),
      ),
    );
  }
}
