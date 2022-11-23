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
}
