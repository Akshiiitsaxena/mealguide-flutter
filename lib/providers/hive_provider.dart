import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/helper/keys.dart';
import 'package:mealguide/models/added_items_hive_model.dart';
import 'package:mealguide/models/diet_model.dart';
import 'package:mealguide/models/ingredient_model.dart';
import 'package:mealguide/models/recipe_model.dart';
import 'package:mealguide/providers/pantry_state_provider.dart';
import 'package:mealguide/providers/recipe_provider.dart';

final hiveProvider = Provider((ref) => HiveHandler(ref));

class HiveHandler {
  final ProviderRef ref;

  HiveHandler(this.ref);

  void getFromStorage() async {
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

  void saveToStorage() async {
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
}
