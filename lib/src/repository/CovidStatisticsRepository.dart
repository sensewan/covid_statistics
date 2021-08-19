import 'package:covid_statistics/src/models/Covid19Model.dart';
import 'package:dio/dio.dart';
import 'package:xml/xml.dart';

class CovidStatisticsRepository{
  late var _dio;

  CovidStatisticsRepository(){
    _dio = Dio(
      BaseOptions(
          baseUrl: "http://openapi.data.go.kr",
          // ServiceKey 에는 Docoding 인증키를 넣어줘야 함...
          queryParameters: {
            'ServiceKey':'a6I2uPlzirpaL6hi4R8DpR3mgATg8SnvgxXFA6tUxSPXCrpz5DdGamLumDL1nNMHxMW73W+XoFzUPhp3IyAZXA=='
          },
      ),
    );
  }

  // ↱ 서버와 통신해서 데이터 갖고 오기
  Future<Covid19Model> fechCovid19Statistics() async{
    //                     ↱ get방식으로 호출
    var response = await _dio.get("/openapi/service/rest/Covid19/getCovid19InfStateJson");

    final document = XmlDocument.parse(response.data);
    final result = document.findAllElements('item');

    if (result.isNotEmpty){
      return Covid19Model.fromXml(result.first);
    } else {
      return Future.value(null);
    }
  }
}