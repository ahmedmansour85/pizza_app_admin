import 'package:pizza_repository/src/entities/entity.dart';

class Micros {
  int calories;
  int carbs;
  int fat;
  int protein;

  Micros({
    required this.calories,
    required this.carbs,
    required this.fat,
    required this.protein,
  });

  MacrosEntity toEnity() {
    return MacrosEntity(
      calories: calories,
      carbs: carbs,
      fat: fat,
      protein: protein,
    );
  }

  static Micros fromEntity(MacrosEntity entity) {
    return Micros(
      calories: entity.calories,
      carbs: entity.carbs,
      fat: entity.fat,
      protein: entity.protein,
    );
  }

  static Micros empty() => Micros(
        calories: 0,
        carbs: 0,
        fat: 0,
        protein: 0,
      );
}
