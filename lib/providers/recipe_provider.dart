import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/models/diet_model.dart';
import 'package:mealguide/models/ingredient_composition_model.dart';
import 'package:mealguide/models/recipe_model.dart';

final recipeProvider = FutureProvider<Map<Diet, List<Recipe>>>((ref) async {
  Map<Diet, List<Recipe>> map = {};
  List<Recipe> recipes = [];

  final String recipesJsonString =
      await rootBundle.loadString('assets/data/recipes.json');
  final recipeJson = jsonDecode(recipesJsonString);

  final String dietsJsonString =
      await rootBundle.loadString('assets/data/diets.json');
  final dietsJson = jsonDecode(dietsJsonString);

  final String ingredientsJsonString =
      await rootBundle.loadString('assets/data/ingredients.json');
  final ingredientsJson = jsonDecode(ingredientsJsonString);

  List<IngredientComposition> composition = [];

  for (var data in ingredientsJson['data']) {
    composition.add(IngredientComposition.fromDoc(data));
  }

  for (var data in recipeJson['data'] as List) {
    var recipe = Recipe.fromDoc(data, composition);
    recipes.add(recipe);
  }

  List<Diet> diets = [];

  for (var data in dietsJson['data'] as List) {
    diets.add(Diet.fromDoc(data));
  }

  diets.sort((a, b) => a.name.compareTo(b.name));
  diets.forEach((element) {
    map[element] =
        recipes.where((recipe) => recipe.diet == element.name).toList();
  });

  return map;
});
