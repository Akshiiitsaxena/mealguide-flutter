import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/models/diet_model.dart';
import 'package:mealguide/models/recipe_model.dart';
import 'package:mealguide/providers/dummy_diet.dart';
import 'package:mealguide/providers/dummy_ing.dart';
import 'package:mealguide/providers/dummy_rec.dart';

final recipeProvider = FutureProvider<Map<Diet, List<Recipe>>>((ref) async {
  Map<Diet, List<Recipe>> map = {};
  List<Recipe> recipes = [];

  for (var data in json_rec['data'] as List) {
    recipes.add(Recipe.fromDoc(data, json_ing));
  }

  List<Diet> diets = [];

  for (var data in json_diet['data'] as List) {
    diets.add(Diet.fromDoc(data));
  }

  diets.sort((a, b) => a.name.compareTo(b.name));
  diets.forEach((element) {
    map[element] =
        recipes.where((recipe) => recipe.diet == element.name).toList();
  });

  return map;
});
