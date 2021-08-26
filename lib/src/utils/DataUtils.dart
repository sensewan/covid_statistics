import 'package:intl/intl.dart';

class DataUtils{
  static String myNumberFormat(double? value){
    return NumberFormat("###,###,###,###").format(value);
  }

  // 날짜 형식 포멧팅 만들기
  static String simpleDayFormat(DateTime time){
    return DateFormat("MM.dd").format(time);
  }

}
