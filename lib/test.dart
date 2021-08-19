
enum PizzaType{
  HamMushroom,
  Deluxe,
  Seafood
}

void main(){

  var userSelectedPizza = PizzaType.HamMushroom;

  Pizza myPizza;

  switch(userSelectedPizza){
    case PizzaType.HamMushroom:
      myPizza = HanAndMushroomPizza();
      break;
    case PizzaType.Deluxe:
      myPizza = DeluxePizza();
      break;
    case PizzaType.Seafood:
      myPizza = SeafoodPizza();
      break;
  }

  print(myPizza.getPrice());

}

// 추상클래스
abstract class Pizza{
  double getPrice();
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
  // String orderNumber;
  // DeluxePizza(this.orderNumber);

  @override
  double getPrice() {
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