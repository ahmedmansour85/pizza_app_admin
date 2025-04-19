import 'models/model.dart';

abstract class PizzaRepo {
  Future<List<Pizza>> getPizzas();
  Future<void> createPizza(Pizza pizza);
}
