class MacrosEntity {
  int calories;
  int carbs;
  int fat;
  int protein;

  MacrosEntity(
      {required this.calories,
      required this.carbs,
      required this.fat,
      required this.protein});

  Map<String, Object?> toDocument() => {
        'calories': calories,
        'carbs': carbs,
        'fat': fat,
        'protien': protein,
      };

  static MacrosEntity fromDocument(Map<String, dynamic> doc) => MacrosEntity(
        calories: doc['calories'] ?? 0,
        carbs: doc['carbs'] ?? 0,
        fat: doc['fat'] ?? 0,
        protein: doc['protien'] ?? 0,
      );
}
