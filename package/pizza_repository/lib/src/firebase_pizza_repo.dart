// Corrected import for logging

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pizza_repository/pizza_repository.dart';

class FirebasePizzaRepo extends PizzaRepo {
  final pizzaCollection = FirebaseFirestore.instance.collection('pizza');
  @override
  Future<List<Pizza>> getPizzas() async {
    try {
      return await pizzaCollection.get().then((value) => value.docs
          .map((e) => Pizza.fromEnity(PizzaEntity.fromDocument(e.data())))
          .toList());
                } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
  
  @override
  Future<void> createPizza(Pizza pizza) async {
    try {
      return await pizzaCollection.doc(pizza.pizzaid).set(pizza.toEntity().toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

 
}
