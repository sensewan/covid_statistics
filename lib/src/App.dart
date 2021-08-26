import 'package:covid_statistics/src/canvas/arrow_clip_path.dart';
import 'package:covid_statistics/src/components/CovidBarChart.dart';
import 'package:covid_statistics/src/components/CovidStatisticsView.dart';
import 'package:covid_statistics/src/controller/CovidStatisticsController.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends GetView<CovidStatisticsController> {
  App({Key? key}) : super(key: key);

  late double safeAreaSize;  // 맨 위 safeArea 부분의 크기
  late double appBarSize;    // 앱바 크기
  late double headerTopZone;  // 위에거 다 합친 크

  Widget infoWidget(String title, String value){
    return
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
            Text(" : $value", style: TextStyle(fontSize: 15),),
          ],
        ),
      );
  }

  // 백그라운드 배경, 코로나 이미지, 메인 확진자 수 나타내
  List<Widget> _background(){
    return [
      // 백그라운드 배경 그라데이션 주기 위한 Container
      Container(
            decoration: BoxDecoration(
              // ↱그라데이션 주기
              gradient: LinearGradient(
                begin: Alignment .centerRight,
                end: Alignment.centerLeft,
                colors:[
                  Colors.grey,
                  Colors.blue,
                ],
              ),
            ),
          ),

          // 바이러스 이미지 부분
          Positioned(
            left: -110,
            top: headerTopZone + 40,
            child: Container(
              child: Image.asset(
                "assets/covid_img.png",
                width: Get.size.width * 0.7,
              ),
            ),
          ),

          // 기준날짜 부분
          Positioned(
            top: headerTopZone + 10,
            // left 0, righht 0 잡은 후 -> 아래 container를 center로 감싸면 -> 가운데 정렬 완성
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xff195f68),
                ),
                child: Obx(()=>
                  Text(
                  controller.todayData.standardDayString,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                ),),
              ),
            ),
          ),

          // 대표 확진자, 증가수, 총 확진자수 보여주기
          Positioned(
            top: headerTopZone+60,
            right: 40,
            child: Obx(()=>CovidStatisticsView(
              title: "확진자",
              addedCount: controller.todayData.calcDecideCnt!,
              totalCount: controller.todayData.decideCnt ?? 0,
              upDown: controller.calculrateUpDown(controller.todayData.calcDecideCnt!),
              titleColor: Colors.white,
              subValueColor: Colors.white,
            ),),
          ),
    ];
  }

  // 격리해제, 검사중, 사망자 나타내기
  Widget _todayStatistics(){
    return Obx(()=>
      Row(
      children: [
        Expanded(
          child: CovidStatisticsView(
            title: "격리해제",
            addedCount: controller.todayData.calcClearCnt!,
            totalCount: controller.todayData.clearCnt ?? 0,
            upDown: controller.calculrateUpDown(controller.todayData.calcClearCnt!),
            dense: true,
          ),
        ),
        // 간격마자 세로 줄 만들기
        Container(
          height: 60,
          child: VerticalDivider(color: Color(0xffc7c7c7),),
        ),
        Expanded(
          child: CovidStatisticsView(
            title: "검사중",
            addedCount: controller.todayData.calcExamCnt!,
            totalCount: controller.todayData.examCnt ?? 0,
            upDown: controller.calculrateUpDown(controller.todayData.calcExamCnt!),
            dense: true,
          ),
        ),
        Container(
          height: 60,
          child: VerticalDivider(color: Color(0xffc7c7c7),),
        ),
        Expanded(
          child: CovidStatisticsView(
            title: "사망자",
            addedCount: controller.todayData.calcDeathCnt!,
            totalCount: controller.todayData.deathCnt ?? 0,
            upDown: controller.calculrateUpDown(controller.todayData.calcDeathCnt!),
            dense: true,
          ),
        ),
      ],
    ),);
  }


  // 차트 위젯
  Widget _covidTrendsChart(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch, // 왼쪽 정렬 효과
      children: [
        Text(
          "확진자 추이",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),

        // ↱차트 부분
        AspectRatio(
          aspectRatio: 1.7,
          child: Obx(()=>
            controller.weekDays.length == 0
            ? Container()
            : CovidBarChart(
              covidDatas: controller.weekDays,
              maxY: controller.maxDecideValue,
            ),
          ),
        ),

      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    safeAreaSize = Get.mediaQuery.padding.top;   // 핸드폰 맨 위의 safearea의 크기를 구할 수 있음(시간 등등의 부분)기
    appBarSize = AppBar().preferredSize.height;  // 앱바 사이즈 구하기
    headerTopZone = safeAreaSize + appBarSize;

    return Scaffold(
      appBar: AppBar(
        // ↱AppBar 배경을 투명하게 만듦
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Icon(Icons.menu, color: Colors.white,),
        title: Text("코로나 일별 현황", style: TextStyle(color: Colors.white),),
        centerTitle: true,
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Icon(
              Icons.notifications,
              color: Colors.white,
            ),
          ),
        ],
      ),
      // ↱ AppBar 부분을 body가 침범하도록 함
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          ..._background(),
          Positioned(
            top: headerTopZone + 200, left: 0, right: 0, bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    children: [
                      _todayStatistics(),
                      SizedBox(height: 20,),
                      _covidTrendsChart(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
