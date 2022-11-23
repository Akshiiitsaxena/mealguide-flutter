class Ingredient {
  final String component;
  final List<IngredientItem> items;

  Ingredient({required this.component, required this.items});

  factory Ingredient.fromDoc(Map<String, dynamic> doc) {
    List<IngredientItem> tempItems = [];

    doc['items'].forEach((element) {
      tempItems.add(IngredientItem.fromDoc(element));
    });

    return Ingredient(
      component: doc['component'],
      items: tempItems,
    );
  }
}

class IngredientItem {
  final String ingredientId;
  final double? quantity;
  final String? description;

  IngredientItem({
    required this.ingredientId,
    required this.quantity,
    this.description,
  });

  factory IngredientItem.fromDoc(Map<String, dynamic> doc) {
    return IngredientItem(
      ingredientId: doc['ingredient'],
      quantity: double.tryParse(doc['quantity'].toString()),
      description: doc['description'],
    );
  }
}
