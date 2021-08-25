import 'package:covid_statistics/src/App.dart';
import 'package:covid_statistics/src/controller/CovidStatisticsController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '코로나19',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),

      // ↱앱 실행 될 때 컨트롤러 생성하기
      initialBinding: BindingsBuilder((){
        Get.put(CovidStatisticsController());
      }),
      home: App(),
    );
  }
}

