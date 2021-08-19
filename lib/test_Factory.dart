
enum PizzaType{
  HamMushroom,
  Deluxe,
  Seafood
}

void main(){

  String? orderNumber;
  //    ↱ 팩토리화 함으로써 Pizza 클래스를 객체 생성하지 않고도 사용가능함 (Pizza 객체를 참조하지 않음)
  print(Pizza.pizzaFactory(PizzaType.Deluxe).getPrice());
  print(Pizza.pizzaFactory(PizzaType.Deluxe, orderNumber: "12345").getOrderNumber());
  print(Pizza.pizzaFactory(PizzaType.Deluxe, orderNumber: orderNumber).getOrderNumber());

  print(Pizza.pizzaFactory(PizzaType.HamMushroom).getPrice());

}


// 추상클래스
abstract class Pizza{
  double getPrice();

  // 팩토리 만들기
  static pizzaFactory(PizzaType type, {String? orderNumber}){
    //                                 ↳ 선택적 파라미터
    switch(type){
      case PizzaType.HamMushroom:
        return HanAndMushroomPizza();
      case PizzaType.Deluxe:
        return DeluxePizza(orderNumber??"없어");
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
    return price;
  }

  String getOrderNumber(){
    return orderNumber;
  }
}


class SeafoodPizza implements Pizza{
  double price = 7.8;

  @override
  double getPrice() {
    return price;
  }
}