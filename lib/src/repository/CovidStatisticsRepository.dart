import 'package:covid_statistics/src/models/Covid19Model.dart';
import 'package:dio/dio.dart';
import 'package:xml/xml.dart';

class CovidStatisticsRepository{
  late var _dio;

  // 테스트용 데이터
  // final bookshelfXml =
  // '''
  //   <response>
  //       <header>
  //           <resultCode>00</resultCode>
  //           <resultMsg>NORMAL SERVICE.</resultMsg>
  //       </header>
  //       <body>
  //           <items>
  //               <item>
  //                   <accDefRate>1.9333458358</accDefRate>
  //                   <accExamCnt>12461685</accExamCnt>
  //                   <accExamCompCnt>11826958</accExamCompCnt>
  //                   <careCnt>26896</careCnt>
  //                   <clearCnt>199582</clearCnt>
  //                   <createDt>2021-08-18 09:41:29.969</createDt>
  //                   <deathCnt>2178</deathCnt>
  //                   <decideCnt>228656</decideCnt>
  //                   <examCnt>634727</examCnt>
  //                   <resutlNegCnt>11598302</resutlNegCnt>
  //                   <seq>607</seq>
  //                   <stateDt>20210818</stateDt>
  //                   <stateTime>00:00</stateTime>
  //                   <updateDt>2021-08-19 09:37:01.591</updateDt>
  //               </item>
  //               <item>
  //                   <accDefRate>1.9250278569</accDefRate>
  //                   <accExamCnt>12404977</accExamCnt>
  //                   <accExamCompCnt>11784297</accExamCompCnt>
  //                   <careCnt>27454</careCnt>
  //                   <clearCnt>197224</clearCnt>
  //                   <createDt>2021-08-17 09:34:16.236</createDt>
  //                   <deathCnt>2173</deathCnt>
  //                   <decideCnt>226851</decideCnt>
  //                   <examCnt>620680</examCnt>
  //                   <resutlNegCnt>11557446</resutlNegCnt>
  //                   <seq>606</seq>
  //                   <stateDt>20210817</stateDt>
  //                   <stateTime>00:00</stateTime>
  //                   <updateDt>2021-08-19 09:36:47.415</updateDt>
  //               </item>
  //               <item>
  //                   <accDefRate>1.9144810398</accDefRate>
  //                   <accExamCnt>12372777</accExamCnt>
  //                   <accExamCompCnt>11777552</accExamCompCnt>
  //                   <careCnt>27114</careCnt>
  //                   <clearCnt>196198</clearCnt>
  //                   <createDt>2021-08-16 09:37:05.069</createDt>
  //                   <deathCnt>2167</deathCnt>
  //                   <decideCnt>225479</decideCnt>
  //                   <examCnt>595225</examCnt>
  //                   <resutlNegCnt>11552073</resutlNegCnt>
  //                   <seq>605</seq>
  //                   <stateDt>20210816</stateDt>
  //                   <stateTime>00:00</stateTime>
  //                   <updateDt>2021-08-19 09:36:35.574</updateDt>
  //               </item>
  //               <item>
  //                   <accDefRate>1.9041828431</accDefRate>
  //                   <accExamCnt>12344716</accExamCnt>
  //                   <accExamCompCnt>11759585</accExamCompCnt>
  //                   <careCnt>26665</careCnt>
  //                   <clearCnt>195103</clearCnt>
  //                   <createDt>2021-08-15 09:34:53.152</createDt>
  //                   <deathCnt>2156</deathCnt>
  //                   <decideCnt>223924</decideCnt>
  //                   <examCnt>585131</examCnt>
  //                   <resutlNegCnt>11535661</resutlNegCnt>
  //                   <seq>604</seq>
  //                   <stateDt>20210815</stateDt>
  //                   <stateTime>00:00</stateTime>
  //                   <updateDt>2021-08-18 10:22:12.123</updateDt>
  //               </item>
  //               <item>
  //                   <accDefRate>1.8908320084</accDefRate>
  //                   <accExamCnt>12309280</accExamCnt>
  //                   <accExamCompCnt>11746575</accExamCompCnt>
  //                   <careCnt>26182</careCnt>
  //                   <clearCnt>193778</clearCnt>
  //                   <createDt>2021-08-14 09:45:15.42</createDt>
  //                   <deathCnt>2148</deathCnt>
  //                   <decideCnt>222108</decideCnt>
  //                   <examCnt>562705</examCnt>
  //                   <resutlNegCnt>11524467</resutlNegCnt>
  //                   <seq>603</seq>
  //                   <stateDt>20210814</stateDt>
  //                   <stateTime>00:00</stateTime>
  //                   <updateDt>2021-08-18 10:21:55.926</updateDt>
  //               </item>
  //               <item>
  //                   <accDefRate>1.8789204800</accDefRate>
  //                   <accExamCnt>12257966</accExamCnt>
  //                   <accExamCompCnt>11718431</accExamCompCnt>
  //                   <careCnt>25788</careCnt>
  //                   <clearCnt>192248</clearCnt>
  //                   <createDt>2021-08-13 09:44:04.528</createDt>
  //                   <deathCnt>2144</deathCnt>
  //                   <decideCnt>220180</decideCnt>
  //                   <examCnt>539535</examCnt>
  //                   <resutlNegCnt>11498251</resutlNegCnt>
  //                   <seq>602</seq>
  //                   <stateDt>20210813</stateDt>
  //                   <stateTime>00:00</stateTime>
  //                   <updateDt>2021-08-18 10:19:42.839</updateDt>
  //               </item>
  //               <item>
  //                   <accDefRate>1.8653269665</accDefRate>
  //                   <accExamCnt>12207241</accExamCnt>
  //                   <accExamCompCnt>11697145</accExamCompCnt>
  //                   <careCnt>25516</careCnt>
  //                   <clearCnt>190536</clearCnt>
  //                   <createDt>2021-08-12 09:38:42.576</createDt>
  //                   <deathCnt>2138</deathCnt>
  //                   <decideCnt>218190</decideCnt>
  //                   <examCnt>510096</examCnt>
  //                   <resutlNegCnt>11478955</resutlNegCnt>
  //                   <seq>601</seq>
  //                   <stateDt>20210812</stateDt>
  //                   <stateTime>00:00</stateTime>
  //                   <updateDt>2021-08-18 10:19:28.931</updateDt>
  //               </item>
  //               <item>
  //                   <accDefRate>1.8529358426</accDefRate>
  //                   <accExamCnt>12156199</accExamCnt>
  //                   <accExamCompCnt>11668132</accExamCompCnt>
  //                   <careCnt>24562</careCnt>
  //                   <clearCnt>189506</clearCnt>
  //                   <createDt>2021-08-11 09:40:02.974</createDt>
  //                   <deathCnt>2135</deathCnt>
  //                   <decideCnt>216203</decideCnt>
  //                   <examCnt>488067</examCnt>
  //                   <resutlNegCnt>11451929</resutlNegCnt>
  //                   <seq>600</seq>
  //                   <stateDt>20210811</stateDt>
  //                   <stateTime>00:00</stateTime>
  //                   <updateDt>2021-08-18 10:19:06.897</updateDt>
  //               </item>
  //           </items>
  //           <numOfRows>10</numOfRows>
  //           <pageNo>1</pageNo>
  //           <totalCount>9</totalCount>
  //       </body>
  //   </response>
  // ''';

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
  Future<List<Covid19Model>> fechCovid19Statistics({String? startDate, String? endDate}) async{

    // 넘겨줄 쿼리 Map 형태로 만들어주기
    var query = Map<String, String>();
    if(startDate != null){
      //    ↱ key 값이 없을 경우 추가하라는 뜻
      query.putIfAbsent("startCreateDt", () => startDate);
    }
    if(endDate != null){
      //    ↱ key 값이 없을 경우 추가하라는 뜻
      query.putIfAbsent("endCreateDt", () => endDate);
    }
    //
    //                     ↱ get방식으로 호출
    var response = await _dio.get(
        "/openapi/service/rest/Covid19/getCovid19InfStateJson",
        queryParameters: query);
    //
    final document = XmlDocument.parse(response.data);

    // final document = XmlDocument.parse(bookshelfXml); // 샘플 임시 데이터

    final result = document.findAllElements('item');

    if (result.isNotEmpty){
      return result.map<Covid19Model>((e) => Covid19Model.fromXml(e)).toList();
    } else {
      return Future.value(null);
    }
  }
}