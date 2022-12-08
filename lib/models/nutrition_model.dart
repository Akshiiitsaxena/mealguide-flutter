class Nutrition {
  final double calories;
  final double protein;
  final double carbohydrates;
  final double fat;
  final double fiber;

  Nutrition({
    required this.calories,
    required this.carbohydrates,
    required this.fat,
    required this.fiber,
    required this.protein,
  });

  factory Nutrition.fromDoc(Map<String, dynamic> doc) {
    return Nutrition(
      calories: double.parse(doc['calories'].toString()),
      carbohydrates: double.parse(doc['carbohydrates'].toString()),
      fat: double.parse(doc['fat'].toString()),
      fiber: double.parse(doc['fiber'].toString()),
      protein: double.parse(doc['protein'].toString()),
    );
  }

  Map<String, dynamic> get getMap {
    return {
      'calories': {
        'amount': calories.floor().toString(),
        'unit': 'KCAL',
      },
      'protein': {
        'amount': protein.toString(),
        'unit': 'G',
      },
      'carbs': {
        'amount': carbohydrates.toString(),
        'unit': 'G',
      },
      'fat': {
        'amount': fat.toString(),
        'unit': 'G',
      },
      'fiber': {
        'amount': fiber.toString(),
        'unit': 'G',
      }
    };
  }
}
