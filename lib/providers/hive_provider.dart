import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/helper/keys.dart';
import 'package:mealguide/models/added_items_hive_model.dart';
import 'package:mealguide/models/diet_model.dart';
import 'package:mealguide/models/ingredient_model.dart';
import 'package:mealguide/models/recipe_model.dart';
import 'package:mealguide/providers/local_plan_state_provider.dart';
import 'package:mealguide/providers/pantry_state_provider.dart';
import 'package:mealguide/providers/recipe_provider.dart';
import 'package:mealguide/providers/viewed_recipes_provider.dart';

final hiveProvider = Provider((ref) => HiveHandler(ref));

class HiveHandler {
  final ProviderRef ref;

  HiveHandler(this.ref);

  void getPantryFromStorage() async {
    final pantryStateNotifier = ref.read(pantryStateNotifierProvider.notifier);
    var pantryBox = await Hive.openBox('pantry');
    var itemsBox = await Hive.openBox<AddedItem>('items');

    List<AddedItem>? items = itemsBox.values.toList();
    List<String>? purchasedItems = pantryBox.get(Keys.puchasedItems);
    Map? addedQuantity = pantryBox.get(Keys.addedQuantity);
    Map? purchasedItemExpiry = pantryBox.get(Keys.purchasedItemExpiry);

    final allIngredients = await getAllIngredientItems();

    for (var item in items) {
      for (var ele in item.ingredientIds) {
        pantryStateNotifier.setIngredients(
            item.recipeId,
            allIngredients.firstWhere((element) => element.ingredientId == ele),
            null,
            initialCall: true);
      }
    }

    if (purchasedItems != null) {
      for (var item in purchasedItems) {
        pantryStateNotifier.setPurchasedIems(item, initialCall: true);
      }
    }

    if (addedQuantity != null) {
      addedQuantity.forEach((key, value) {
        pantryStateNotifier.setQuantity(key, value, initialCall: true);
      });
    }

    if (purchasedItemExpiry != null) {
      purchasedItemExpiry.forEach((key, value) {
        pantryStateNotifier.setPurchasedItemExpiry(key, value,
            initialCall: true);
      });
    }
  }

  void savePantryToStorage() async {
    final pantryState = ref.read(pantryStateNotifierProvider);
    var pantryBox = await Hive.openBox('pantry');
    var itemBox = await Hive.openBox<AddedItem>('items');

    List<AddedItem> items = [];
    pantryState.items.forEach((key, value) {
      items.add(
        AddedItem(
          recipeId: key,
          ingredientIds: value.map((e) => e.ingredientId).toSet().toList(),
        ),
      );
    });

    itemBox.clear();
    itemBox.addAll(items);

    final purchasedItems = pantryState.purchasedItems;
    final addedQuantity = pantryState.addedQuantity;
    final purchasedItemExpiry = pantryState.purchasedItemExpiry;

    pantryBox.put(Keys.puchasedItems, purchasedItems.toList());
    pantryBox.put(Keys.addedQuantity, addedQuantity);
    pantryBox.put(Keys.purchasedItemExpiry, purchasedItemExpiry);
  }

  Future<List<IngredientItem>> getAllIngredientItems() async {
    Set<IngredientItem> allIngredientItems = {};

    Map<Diet, List<Recipe>> dietAllRecipes =
        await ref.read(recipeProvider.future);

    List<Recipe> allRecipes = dietAllRecipes.values
        .fold([], (prev, element) => [...prev, ...element]);

    for (var recipe in allRecipes) {
      allIngredientItems.addAll(
        recipe.ingredients.fold([],
            (previousValue, element) => [...previousValue, ...element.items]),
      );
    }

    return allIngredientItems.toList();
  }

  Future<String> getLocalMealPlan() async {
    var mealBox = await Hive.openBox<String>('mealplan');
    return mealBox.get(Keys.mealPlan) ?? '';
  }

  void setLocalMealPlan(String mealplan) async {
    var mealBox = await Hive.openBox<String>('mealplan');
    mealBox.put(Keys.mealPlan, mealplan);
  }

  Future<void> setLocalPlanFromStorage() async {
    String mealPlan = await getLocalMealPlan();
    if (mealPlan.isNotEmpty) {
      ref.read(localPlanNotifierProvider.notifier).setPlan(mealPlan);
    }
  }

  Future<Map> getOnboardingAnswers() async {
    var onboardingBox = await Hive.openBox('onboarding');
    return onboardingBox.get(Keys.answers);
  }

  void setOnboardingAnswers(Map<String, dynamic> answers) async {
    var onboardingBox = await Hive.openBox('onboarding');
    onboardingBox.put(Keys.answers, answers);
  }

  Future<double> getCalorieGoal() async {
    var calorieBox = await Hive.openBox('calorie');
    return calorieBox.get(Keys.calorie);
  }

  void setCalorieGoal(double calorie) async {
    var calorieBox = await Hive.openBox('calorie');
    calorieBox.put(Keys.calorie, calorie);
  }

  Future<int> getUserViewedRecipes() async {
    var viewedRecipeBox = await Hive.openBox<int>('viewedRecipes');
    return viewedRecipeBox.get(Keys.viewedRecipes) ?? 0;
  }

  void setUserViewedRecipes(int number) async {
    var viewedRecipeBox = await Hive.openBox<int>('viewedRecipes');
    viewedRecipeBox.put(Keys.viewedRecipes, number);
  }

  void setUserViewedRecipesFromStorage() async {
    int viewed = await getUserViewedRecipes();
    ref.read(viewedRecipeNotifierProvider.notifier).setViewedRecipes(viewed);
  }
}
