import 'package:pizza_repository/pizza_repository.dart';
import 'package:uuid/uuid.dart';

class Pizza {
  String pizzaid;
  String picture;
  String name;
  bool isVeg;
  int spicy;
  String description;
  int price;
  int discount;
  Micros micros;

  Pizza({
    required this.pizzaid,
    required this.picture,
    required this.name,
    required this.isVeg,
    required this.spicy,
    required this.description,
    required this.price,
    required this.discount,
    required this.micros,
  });

  static Pizza fromEnity(PizzaEntity entity) => Pizza(
      pizzaid: entity.id,
      picture: entity.imageUrl,
      name: entity.name,
      isVeg: entity.isVeg,
      spicy: entity.spicey,
      description: entity.description,
      price: entity.price,
      discount: entity.discount,
      micros: Micros.fromEntity(entity.micros));

  static Pizza empty() => Pizza(
      pizzaid: Uuid().v1(),
      picture: '',
      name: '',
      isVeg: false,
      spicy: 1,
      description: '',
      price: 0,
      discount: 0,
      micros: Micros.empty());

  @override
  String toString() {
    return 'Pizza(pizzaid: $pizzaid, picture: $picture, name: $name, isVeg: $isVeg, spicy: $spicy, description: $description, price: $price, discount: $discount, micros: $micros)';
  }

  PizzaEntity toEntity() => PizzaEntity(
      id: pizzaid,
      name: name,
      description: description,
      imageUrl: picture,
      micros: micros.toEnity(),
      isVeg: isVeg,
      spicey: spicy,
      price: price,
      discount: discount);
}
