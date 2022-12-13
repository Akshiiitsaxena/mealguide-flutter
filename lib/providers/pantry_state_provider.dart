import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/models/ingredient_model.dart';

@immutable
class PantryState {
  final Map<String, Set<IngredientItem>> items;
  final Set<String> purchasedItems;
  final Map<String, double> addedQuantity;
  final Map<String, String> purchasedItemExpiry;

  const PantryState(
    this.items,
    this.purchasedItems,
    this.addedQuantity,
    this.purchasedItemExpiry,
  );

  PantryState copyWith({
    Map<String, Set<IngredientItem>>? items,
    Set<String>? purchasedItems,
    Map<String, double>? addedQuantity,
    Map<String, String>? purchasedItemExpiry,
  }) {
    return PantryState(
        items ?? this.items,
        purchasedItems ?? this.purchasedItems,
        addedQuantity ?? this.addedQuantity,
        purchasedItemExpiry ?? this.purchasedItemExpiry);
  }

  get getNumberOfFoodItems {
    int totalItems = items.values
        .toList()
        .fold<List<IngredientItem>>([], (prev, ele) => [...prev, ...ele])
        .toSet()
        .length;

    return totalItems - purchasedItems.length;
  }
}

class PantryStateNotifier extends StateNotifier<PantryState> {
  PantryStateNotifier() : super(const PantryState({}, {}, {}, {}));

  void setIngredients(String id, IngredientItem item, double? quantity) {
    Map<String, Set<IngredientItem>> map = {};
    map.addAll(state.items);
    map.update(id, ((val) => {...val, item}), ifAbsent: () => {item});
    state = state.copyWith(items: map);
    if (quantity != null) {
      setQuantity(item.ingredientId, quantity);
    }
  }

  void removeIngredients(String itemId) {
    Map<String, Set<IngredientItem>> map = {};
    map.addAll(state.items);

    List<String> keysToRemove = [];
    map.forEach((key, value) {
      if (value.map((e) => e.ingredientId).contains(itemId)) {
        if (value.length == 1) {
          keysToRemove.add(key);
        } else {
          Set<IngredientItem> tempItems = value;
          tempItems.removeWhere((element) => element.ingredientId == itemId);
          map.update(key, (value) => tempItems);
        }
      }
    });

    map.removeWhere((key, value) => keysToRemove.contains(key));
    state = state.copyWith(items: map);
    removeQuantity(itemId);
    removePurchasedItems(itemId);
    removePurchasedItemsExpiry(itemId);
  }

  void setQuantity(String itemId, double quantity) {
    Map<String, double> map = {};
    map.addAll(state.addedQuantity);
    map.update(itemId, (value) => value + quantity, ifAbsent: () => quantity);
    state = state.copyWith(addedQuantity: map);
  }

  void removeQuantity(String itemId) {
    Map<String, double> map = {};
    map.addAll(state.addedQuantity);
    map.removeWhere((key, value) => key == itemId);
    state = state.copyWith(addedQuantity: map);
  }

  void setPurchasedIems(String id) {
    state = state.copyWith(purchasedItems: {...state.purchasedItems, id});
  }

  void removePurchasedItems(String id) {
    Set<String> itemSet = {};
    itemSet.addAll(state.purchasedItems);
    itemSet.removeWhere((element) => element == id);
    state = state.copyWith(purchasedItems: itemSet);
  }

  void setPurchasedItemExpiry(String id, String date) {
    Map<String, String> map = {};
    map.addAll(state.purchasedItemExpiry);
    map.update(id, (value) => date, ifAbsent: () => date);
    state = state.copyWith(purchasedItemExpiry: map);
  }

  void removePurchasedItemsExpiry(String id) {
    Map<String, String> map = {};
    map.addAll(state.purchasedItemExpiry);
    map.removeWhere((key, value) => key == id);
    state = state.copyWith(purchasedItemExpiry: map);
  }
}

final pantryStateNotifierProvider =
    StateNotifierProvider<PantryStateNotifier, PantryState>(
  (ref) => PantryStateNotifier(),
);
