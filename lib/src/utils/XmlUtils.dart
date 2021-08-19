import 'package:xml/xml.dart';

class XmlUtils{
  static String searchResult(XmlElement xml, String element){
    return xml.findAllElements(element).map((e) => e.text).isEmpty
        ? ""
        : xml.findAllElements(element).map((e) => e.text).first;
    // ↳ element 이름의 요소의 text만 찾아서 반복함 (first 첫번째것만)
  }
}