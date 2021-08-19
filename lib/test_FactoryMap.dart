
enum PizzaType{
  HamMushroom,
  Deluxe,
  Seafood
}

void main(){

  Map<String, dynamic> json = {
    "type":PizzaType.Deluxe,
    "orderNumber":"12345"
  };

  print(Pizza.fromJson(json).getPrice());


}


// 추상클래스
abstract class Pizza{
  double getPrice();

  // ### 팩토리 만들기 ###
  factory Pizza.fromJson(Map<String, dynamic> json){
    //                                 ↳ 선택적 파라미터
    switch(json["type"] as PizzaType){
      case PizzaType.HamMushroom:
        return HanAndMushroomPizza();
      case PizzaType.Deluxe:
        return DeluxePizza(json["orderNumber"] as String);
      case PizzaType.Seafood:
        return SeafoodPizza();
    }

  }
}

class HanAndMushroomPizza implements Pizza{
  double price = 10.5;

  @override
  double getPrice() {
    return price;
  }
}


class DeluxePizza implements Pizza{
  double price = 5.5;

  // 예. 팩토리를 사용하지 않고 수정할 경우 -> 참조하는 모든곳에서 오류 발생 vs 팩토리패턴 사용-> 팩토리에서만 수정하면 됨
  String orderNumber;
  DeluxePizza(this.orderNumber);

  @override
  double getPrice() {
    print(orderNumber);
    return price;
  }
}


class SeafoodPizza implements Pizza{
  double price = 7.8;

  @override
  double getPrice() {
    return price;
  }
}