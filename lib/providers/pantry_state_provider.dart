import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/models/ingredient_model.dart';
import 'package:mealguide/providers/hive_provider.dart';

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
  final Ref ref;

  PantryStateNotifier(this.ref) : super(const PantryState({}, {}, {}, {}));

  void setIngredients(String id, IngredientItem item, double? quantity,
      {bool initialCall = false}) {
    Map<String, Set<IngredientItem>> map = {};
    map.addAll(state.items);
    map.update(id, ((val) => {...val, item}), ifAbsent: () => {item});
    state = state.copyWith(items: map);
    if (quantity != null) {
      setQuantity(item.ingredientId, quantity, initialCall: initialCall);
    }
    if (!initialCall) {
      ref.read(hiveProvider).saveToStorage();
    }
  }

  void removeIngredients(String itemId, {bool initialCall = false}) {
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
    removeQuantity(itemId, initialCall: initialCall);
    removePurchasedItems(itemId, initialCall: initialCall);
    removePurchasedItemsExpiry(itemId, initialCall: initialCall);
    if (!initialCall) {
      ref.read(hiveProvider).saveToStorage();
    }
  }

  void setQuantity(String itemId, double quantity, {bool initialCall = false}) {
    Map<String, double> map = {};
    map.addAll(state.addedQuantity);
    map.update(itemId, (value) => value + quantity, ifAbsent: () => quantity);
    state = state.copyWith(addedQuantity: map);
    if (!initialCall) {
      ref.read(hiveProvider).saveToStorage();
    }
  }

  void removeQuantity(String itemId, {bool initialCall = false}) {
    Map<String, double> map = {};
    map.addAll(state.addedQuantity);
    map.removeWhere((key, value) => key == itemId);
    state = state.copyWith(addedQuantity: map);
    if (!initialCall) {
      ref.read(hiveProvider).saveToStorage();
    }
  }

  void setPurchasedIems(String id, {bool initialCall = false}) {
    state = state.copyWith(purchasedItems: {...state.purchasedItems, id});
    if (!initialCall) {
      ref.read(hiveProvider).saveToStorage();
    }
  }

  void removePurchasedItems(String id, {bool initialCall = false}) {
    Set<String> itemSet = {};
    itemSet.addAll(state.purchasedItems);
    itemSet.removeWhere((element) => element == id);
    state = state.copyWith(purchasedItems: itemSet);
    if (!initialCall) {
      ref.read(hiveProvider).saveToStorage();
    }
  }

  void setPurchasedItemExpiry(String id, String date,
      {bool initialCall = false}) {
    Map<String, String> map = {};
    map.addAll(state.purchasedItemExpiry);
    map.update(id, (value) => date, ifAbsent: () => date);
    state = state.copyWith(purchasedItemExpiry: map);
    if (!initialCall) {
      ref.read(hiveProvider).saveToStorage();
    }
  }

  void removePurchasedItemsExpiry(String id, {bool initialCall = false}) {
    Map<String, String> map = {};
    map.addAll(state.purchasedItemExpiry);
    map.removeWhere((key, value) => key == id);
    state = state.copyWith(purchasedItemExpiry: map);
    if (!initialCall) {
      ref.read(hiveProvider).saveToStorage();
    }
  }
}

final pantryStateNotifierProvider =
    StateNotifierProvider<PantryStateNotifier, PantryState>(
  (ref) => PantryStateNotifier(ref),
);
