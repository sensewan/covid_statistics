// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:covid_statistics/main.dart';
import 'package:xml/xml.dart';

void main() {
  final bookshelfXml =
    '''
      <response>
          <header>
              <resultCode>00</resultCode>
              <resultMsg>NORMAL SERVICE.</resultMsg>
          </header>
          <body>
              <items>
                  <item>
                      <accDefRate>1.9250533145</accDefRate>
                      <accExamCnt>12404977</accExamCnt>
                      <accExamCompCnt>11784297</accExamCompCnt>
                      <careCnt>27457</careCnt>
                      <clearCnt>197224</clearCnt>
                      <createDt>2021-08-17 09:34:16.236</createDt>
                      <deathCnt>2173</deathCnt>
                      <decideCnt>226854</decideCnt>
                      <examCnt>620680</examCnt>
                      <resutlNegCnt>11557443</resutlNegCnt>
                      <seq>606</seq>
                      <stateDt>20210817</stateDt>
                      <stateTime>00:00</stateTime>
                      <updateDt>null</updateDt>
                  </item>
                  <item>
                      <accDefRate>1.9144980213</accDefRate>
                      <accExamCnt>12372777</accExamCnt>
                      <accExamCompCnt>11777552</accExamCompCnt>
                      <careCnt>27116</careCnt>
                      <clearCnt>196198</clearCnt>
                      <createDt>2021-08-16 09:37:05.069</createDt>
                      <deathCnt>2167</deathCnt>
                      <decideCnt>225481</decideCnt>
                      <examCnt>595225</examCnt>
                      <resutlNegCnt>11552071</resutlNegCnt>
                      <seq>605</seq>
                      <stateDt>20210816</stateDt>
                      <stateTime>00:00</stateTime>
                      <updateDt>null</updateDt>
                  </item>
              </items>
              <numOfRows>10</numOfRows>
              <pageNo>1</pageNo>
              <totalCount>8</totalCount>
          </body>
      </response>
    ''';

  testWidgets('코로나 전체 통계', (WidgetTester tester) async {
    final document = XmlDocument.parse(bookshelfXml);
    final items = document.findAllElements('item');

    var covid19Statics = <Covid19Model> [];

    items.forEach((node) {
      // print(node);
      // node.findAllElements('accDefRate').map((e) => e.text).forEach(print);
      covid19Statics.add(Covid19Model.fromXml(node));
    });
    // titles.map((node) => node.text).forEach(print);
    print(covid19Statics.length);
    covid19Statics.forEach((covid19) {
      print("${covid19.stateDt} : ${covid19.decideCnt}");
    });
  });

} // main() 끝


// 모델 클래스
class Covid19Model{
  String? accDefRate;
  String? accExamCnt;
  String? accExamCompCnt;
  String? careCnt;
  String? clearCnt;
  String? createDt;
  String? deathCnt;
  String? decideCnt;
  String? examCnt;
  String? resutlNegCnt;
  String? seq;
  String? stateDt;
  String? stateTime;
  String? updateDt;

  // 생성자
  Covid19Model({
    this.accDefRate,
    this.accExamCnt,
    this.accExamCompCnt,
    this.careCnt,
    this.clearCnt,
    this.createDt,
    this.deathCnt,
    this.decideCnt,
    this.examCnt,
    this.resutlNegCnt,
    this.seq,
    this.stateDt,
    this.stateTime,
    this.updateDt,
  });

  factory Covid19Model.fromXml(XmlElement xml){
    return Covid19Model(
        accDefRate : XmlUtils.searchResult(xml, "accDefRate"),
        accExamCnt : XmlUtils.searchResult(xml, "accExamCnt"),
        accExamCompCnt : XmlUtils.searchResult(xml, "accExamCompCnt"),
        careCnt : XmlUtils.searchResult(xml, "careCnt"),
        clearCnt : XmlUtils.searchResult(xml, "clearCnt"),
        createDt : XmlUtils.searchResult(xml, "createDt"),
        deathCnt : XmlUtils.searchResult(xml, "deathCnt"),
        decideCnt : XmlUtils.searchResult(xml, "decideCnt"),
        examCnt : XmlUtils.searchResult(xml, "examCnt"),
        resutlNegCnt : XmlUtils.searchResult(xml, "resutlNegCnt"),
        seq : XmlUtils.searchResult(xml, "seq"),
        stateDt : XmlUtils.searchResult(xml, "stateDt"),
        stateTime : XmlUtils.searchResult(xml, "stateTime"),
        updateDt : XmlUtils.searchResult(xml, "updateDt"),
    );
  }

}



class XmlUtils{
  static String searchResult(XmlElement xml, String element){
    return xml.findAllElements(element).map((e) => e.text).isEmpty
    ? ""
    : xml.findAllElements(element).map((e) => e.text).first;
    // ↳ element 이름의 요소의 text만 찾아서 반복함 (first 첫번째것만)
  }
}