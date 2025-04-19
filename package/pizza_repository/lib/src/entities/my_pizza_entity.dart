import 'package:pizza_repository/pizza_repository.dart';

class PizzaEntity {
  String id;
  String name;
  String description;
  String imageUrl;
  MacrosEntity micros;
  bool isVeg;
  int spicey;
  int price;
  int discount;

  PizzaEntity(
      {required this.id,
      required this.name,
      required this.description,
      required this.imageUrl,
      required this.micros,
      required this.isVeg,
      required this.spicey,
      required this.price,
      required this.discount});

  Map<String, Object?> toDocument() => {
        'id': id,
        'name': name,
        'description': description,
        'picture': imageUrl,
        'micros': micros.toDocument(),
        'isVeg': isVeg,
        'spicy': spicey,
        'price': price,
        'discount': discount,
      };

  static PizzaEntity fromDocument(Map<String, dynamic> doc) => PizzaEntity(
      id: doc['id'],
      name: doc['name'],
      description: doc['description'],
      imageUrl: doc['picture'],
      micros: MacrosEntity.fromDocument(doc['micros']),
      isVeg: doc['isVeg'],
      spicey: doc['spicy'],
      price: doc['price'],
      discount: doc['discount']);
}
