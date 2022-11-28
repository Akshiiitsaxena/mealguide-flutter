import 'package:mealguide/models/ingredient_composition_model.dart';

class Ingredient {
  final String component;
  final List<IngredientItem> items;

  Ingredient({required this.component, required this.items});

  factory Ingredient.fromDoc(
      Map<String, dynamic> doc, List<IngredientComposition> compositions) {
    List<IngredientItem> tempItems = [];

    doc['items'].forEach((itemElement) {
      final ingComposition = compositions.firstWhere((compositionElement) =>
          compositionElement.id == itemElement['ingredient']);

      tempItems.add(IngredientItem.fromDoc(itemElement, ingComposition));
    });

    return Ingredient(
      component: doc['component'],
      items: tempItems,
    );
  }
}

class IngredientItem {
  final String ingredientId;
  final IngredientComposition ingredientComposition;
  final double? quantity;
  final String? description;

  IngredientItem({
    required this.ingredientId,
    required this.quantity,
    required this.ingredientComposition,
    this.description,
  });

  factory IngredientItem.fromDoc(
      Map<String, dynamic> doc, IngredientComposition composition) {
    return IngredientItem(
      ingredientId: doc['ingredient'],
      quantity: double.tryParse(doc['quantity'].toString()),
      description: doc['description'],
      ingredientComposition: composition,
    );
  }
}
