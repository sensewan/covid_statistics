import 'package:covid_statistics/src/models/Covid19Model.dart';
import 'package:covid_statistics/src/repository/CovidStatisticsRepository.dart';
import 'package:get/get.dart';

class CovidStatisticsController extends GetxController{

  late CovidStatisticsRepository _covidStatisticsRepository;
  Rx<Covid19Model> covidStatistic = Covid19Model().obs;

  @override
  void onInit() {
    super.onInit();
    // ↱레포지토리 생성하기
    _covidStatisticsRepository = CovidStatisticsRepository();
    fetchCovidState();
  }

  void fetchCovidState() async{
    var result = await _covidStatisticsRepository.fechCovid19Statistics();

    if (result != null){
      covidStatistic(result);
    }
  }
}