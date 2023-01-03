import 'package:mealguide/models/nutrition_model.dart';
import 'package:mealguide/models/recipe_model.dart';

class MealPlan {
  final String recipeName;
  final String recipeId;
  final String recipeImage;
  final String recipeIdentifier;
  final Nutrition nutrition;
  final RecipeType category;
  final bool consumed;
  final String id;

  MealPlan({
    required this.category,
    required this.consumed,
    required this.id,
    required this.nutrition,
    required this.recipeId,
    required this.recipeIdentifier,
    required this.recipeImage,
    required this.recipeName,
  });

  factory MealPlan.fromDoc(Map<String, dynamic> doc) {
    RecipeType docRecipeType;

    switch (doc['category'].toString().toLowerCase()) {
      case 'breakfast':
        docRecipeType = RecipeType.breakfast;
        break;
      case 'lunch':
        docRecipeType = RecipeType.lunch;
        break;
      case 'snacks':
        docRecipeType = RecipeType.snacks;
        break;
      case 'dinner':
        docRecipeType = RecipeType.dinner;
        break;
      default:
        docRecipeType = RecipeType.breakfast;
    }

    return MealPlan(
      category: docRecipeType,
      consumed: doc['consumed'],
      id: doc['_id'],
      nutrition: Nutrition.fromDoc(doc['recipe']['nutrition']),
      recipeId: doc['recipe']['_id'],
      recipeIdentifier: doc['recipe']['identifier'],
      recipeImage: doc['recipe']['image'],
      recipeName: doc['recipe']['name'],
    );
  }
}
