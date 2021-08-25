import 'package:intl/intl.dart';

class DataUtils{
  static String myNumberFormat(double? value){
    return NumberFormat("###,###,###,###").format(value);
  }
}
