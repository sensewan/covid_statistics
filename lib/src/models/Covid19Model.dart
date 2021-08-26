import 'package:covid_statistics/src/utils/DataUtils.dart';
import 'package:covid_statistics/src/utils/XmlUtils.dart';
import 'package:xml/xml.dart';

// 모델 클래스
class Covid19Model{
  double? accDefRate;
  double? accExamCnt;
  double? accExamCompCnt;
  double? careCnt;
  double? resutlNegCnt;
  double? seq;

  double? deathCnt;
  double? calcDeathCnt = 0;    // 계산된 사망자 수

  double? decideCnt;            // 총확진자 수
  double? calcDecideCnt = 0;    // 금일 확진자 수

  double? clearCnt;
  double? calcClearCnt = 0;   // 계산된 격리해제 수

  double? examCnt;
  double? calcExamCnt = 0;     // 계산된 검사중 수

  String? createDt;
  DateTime? stateDt;
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

  // 투테이 코로나 데이터 빈값인 경우 -> 빈객체 주기
  factory Covid19Model.empty(){
    return Covid19Model();
  }


  factory Covid19Model.fromXml(XmlElement xml){
    return Covid19Model(
      accDefRate : XmlUtils.searchResultForDouble(xml, "accDefRate"),
      accExamCnt : XmlUtils.searchResultForDouble(xml, "accExamCnt"),
      accExamCompCnt : XmlUtils.searchResultForDouble(xml, "accExamCompCnt"),
      careCnt : XmlUtils.searchResultForDouble(xml, "careCnt"),
      clearCnt : XmlUtils.searchResultForDouble(xml, "clearCnt"),
      deathCnt : XmlUtils.searchResultForDouble(xml, "deathCnt"),
      decideCnt : XmlUtils.searchResultForDouble(xml, "decideCnt"),
      examCnt : XmlUtils.searchResultForDouble(xml, "examCnt"),
      resutlNegCnt : XmlUtils.searchResultForDouble(xml, "resutlNegCnt") ,
      seq : XmlUtils.searchResultForDouble(xml, "seq"),
      createDt : XmlUtils.searchResultForString(xml, "createDt"),
      // ↱문자열 날짜를 데이트 형식으로 변경
      stateDt : XmlUtils.searchResultForString(xml, "stateDt") != ''
                ?  DateTime.parse(XmlUtils.searchResultForString(xml, "stateDt"))
                : null,
      stateTime : XmlUtils.searchResultForString(xml, "stateTime"),
      updateDt : XmlUtils.searchResultForString(xml, "updateDt"),
    );
  }

  void updateCalcAboutYesterday(Covid19Model yesterDayData){
    _updateCalcClearCnt(yesterDayData.clearCnt!);
    _updateCalcDecideCnt(yesterDayData.decideCnt!);
    _updateCalcDethCnt(yesterDayData.deathCnt!);
    _updateCalcExamCnt(yesterDayData.examCnt!);

  }

  // 금일 확진자 수 구하기
  void _updateCalcDecideCnt(double beforeCnt){
    calcDecideCnt = decideCnt! - beforeCnt;
  }

  // 검사중인 환자 수 계산
  void _updateCalcExamCnt(double beforeCnt){
    calcExamCnt = examCnt! - beforeCnt;
  }

  // 사망자수 계산
  void _updateCalcDethCnt(double beforeCnt){
    calcDeathCnt = deathCnt! - beforeCnt;
  }

  // 격리헤제 계산하기
  void _updateCalcClearCnt(double beforeCnt){
    calcClearCnt = clearCnt! - beforeCnt;
  }


  // 날짜 기준 스트링 반환
 String get standardDayString => stateDt == null
    ? ''
    : "${DataUtils.simpleDayFormat(stateDt!)} $stateTime 기준";


}
