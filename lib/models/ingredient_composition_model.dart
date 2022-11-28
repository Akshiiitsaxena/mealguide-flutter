import 'package:mealguide/models/nutrition_model.dart';

class IngredientComposition {
  final String name;
  final double servingWeight;
  final String unit;
  final String category;
  final double quantity;
  final String id;
  final Nutrition nutrition;

  IngredientComposition({
    required this.category,
    required this.id,
    required this.servingWeight,
    required this.name,
    required this.nutrition,
    required this.quantity,
    required this.unit,
  });

  factory IngredientComposition.fromDoc(Map<String, dynamic> doc) {
    return IngredientComposition(
      category: doc['category'],
      id: doc['id'],
      servingWeight: double.parse(doc['serving_weight_grams'].toString()),
      name: doc['name'],
      nutrition: Nutrition.fromDoc(doc['nutrition']),
      quantity: double.parse(doc['qty'].toString()),
      unit: doc['unit'],
    );
  }
}
