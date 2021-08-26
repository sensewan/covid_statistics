import 'package:covid_statistics/src/canvas/arrow_clip_path.dart';
import 'package:covid_statistics/src/models/Covid19Model.dart';
import 'package:covid_statistics/src/repository/CovidStatisticsRepository.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CovidStatisticsController extends GetxController{

  late CovidStatisticsRepository _covidStatisticsRepository;
  Rx<Covid19Model> _todayData = Covid19Model().obs;
  RxList<Covid19Model> _weekData = <Covid19Model>[].obs;

  // 차트용 데이터(확진자 추이)
  double maxDecideValue = 0;


  @override
  void onInit() {
    super.onInit();
    // ↱레포지토리 생성하기
    _covidStatisticsRepository = CovidStatisticsRepository();
    fetchCovidState();
  }

  // 코로나 데이터 갖고오기
  void fetchCovidState() async{

    // ↱일주일 전의 날짜를 알아야 함                               ↱7일전의 날짜를 알아내기
    var startDate = DateFormat("yyyyMMdd").format(DateTime.now().subtract(Duration(days: 7)));
    var endDate = DateFormat("yyyyMMdd").format(DateTime.now());;

    var result = await _covidStatisticsRepository.fechCovid19Statistics(startDate: startDate, endDate: endDate);

    if (result.isNotEmpty){
      for(var i = 0; i<result.length; i++){
        if(i < result.length -1){
          result[i].updateCalcAboutYesterday(result[i+1]); // 어제 데이터와 비교하여 금일 현황 계산하기

          // ↱ 차트용...
          if(maxDecideValue < result[i].calcDecideCnt!){
            maxDecideValue = result[i].calcDecideCnt!;
          }
        }
      }
      //                                   ↱마지막 데이터는 필요가 없으므로 제거함
      _weekData.addAll(result.sublist(0, result.length-1).reversed);
      //                                                   ↳ 자료 반대로 넣기

      _todayData(_weekData.last);
    }
  }

  Covid19Model get todayData => _todayData.value;

  // _weekData 건내주는 get
  List<Covid19Model> get weekDays => _weekData;

  // 증가 수에 따른 화살표 모양 넘겨주기
  ArrowDirection calculrateUpDown(double value){
    if (value ==  0){
      return ArrowDirection.MIDDLE;
    }else if(value > 0){
      return ArrowDirection.UP;
    }else{
      return ArrowDirection.DOWN;
    }
  }

}