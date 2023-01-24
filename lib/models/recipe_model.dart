import 'package:mealguide/models/ingredient_composition_model.dart';
import 'package:mealguide/models/ingredient_model.dart';
import 'package:mealguide/models/instruction_model.dart';
import 'package:mealguide/models/nutrition_model.dart';
import 'package:mealguide/models/serving_model.dart';

class Recipe {
  final String id;
  final String name;
  final String? description;
  final String image;
  final String diet;
  final Serving serving;
  final RecipeType category;
  final String identifier;
  final Map<String, dynamic> time;
  final List<Ingredient> ingredients;
  final List<Instruction> instructions;
  final Nutrition nutrition;
  final String ingredientsSearch;

  Recipe({
    required this.category,
    required this.description,
    required this.diet,
    required this.id,
    required this.identifier,
    required this.image,
    required this.ingredients,
    required this.ingredientsSearch,
    required this.instructions,
    required this.name,
    required this.nutrition,
    required this.serving,
    required this.time,
  });

  factory Recipe.fromDoc(
      Map<String, dynamic> doc, List<IngredientComposition> composition) {
    Serving docServing = Serving.fromDoc(doc['servings']);

    List<Ingredient> docIngredients = [];
    doc['ingredients'].forEach(
        (val) => docIngredients.add(Ingredient.fromDoc(val, composition)));

    List<Instruction> docInstructions = [];
    doc['instructions']
        .forEach((val) => docInstructions.add(Instruction.fromDoc(val)));

    Nutrition docNutrition = Nutrition.fromDoc(doc['nutrition']);

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

    return Recipe(
      category: docRecipeType,
      description: doc['description'],
      diet: doc['diet'],
      id: doc['id'],
      identifier: doc['identifier'],
      image: doc['image'],
      ingredients: docIngredients,
      ingredientsSearch: doc['ingredients_search'],
      instructions: docInstructions,
      name: doc['name'],
      nutrition: docNutrition,
      serving: docServing,
      time: doc['time'],
    );
  }

  get getCalories => '${nutrition.calories.floor()} KCAL';
}

enum RecipeType {
  breakfast,
  lunch,
  snacks,
  dinner;

  @override
  String toString() => name;
}
