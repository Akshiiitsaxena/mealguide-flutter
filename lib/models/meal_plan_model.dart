import 'package:mealguide/models/nutrition_model.dart';
import 'package:mealguide/models/recipe_model.dart';

class MealPlan {
  final String recipeName;
  final String recipeId;
  final String? recipeImage;
  final String? recipeIdentifier;
  final String? instruction;
  final Nutrition nutrition;
  final RecipeType category;
  final bool consumed;
  final String id;
  final MealPlanType type;

  MealPlan({
    required this.category,
    required this.consumed,
    required this.id,
    required this.nutrition,
    required this.recipeId,
    this.recipeIdentifier,
    this.instruction,
    this.recipeImage,
    required this.recipeName,
    required this.type,
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

    MealPlanType mealPlanType;

    if (doc.containsKey('recipe')) {
      mealPlanType = MealPlanType.recipe;
    } else {
      mealPlanType = MealPlanType.snack;
    }

    return doc.containsKey('recipe')
        ? MealPlan(
            category: docRecipeType,
            consumed: doc['consumed'],
            id: doc['_id'],
            nutrition: Nutrition.fromDoc(doc['recipe']['nutrition']),
            recipeId: doc['recipe']['_id'],
            recipeIdentifier: doc['recipe']['identifier'],
            recipeImage: doc['recipe']['image'],
            recipeName: doc['recipe']['name'],
            type: mealPlanType,
          )
        : MealPlan(
            category: docRecipeType,
            consumed: doc['consumed'],
            id: doc['_id'],
            nutrition: Nutrition.fromDoc(doc['snack']['nutrition']),
            recipeId: doc['snack']['_id'],
            recipeImage: doc['snack']['image'],
            recipeName: doc['snack']['name'],
            type: mealPlanType,
            instruction: doc['snack']['instruction'],
          );
  }
}

enum MealPlanType { recipe, snack }
