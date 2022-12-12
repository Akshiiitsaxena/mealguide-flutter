import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/models/ingredient_model.dart';

@immutable
class PantryState {
  final Map<String, Set<IngredientItem>> items;
  final Set<String> purchasedItems;
  final Map<String, double> addedQuantity;

  const PantryState(this.items, this.purchasedItems, this.addedQuantity);

  PantryState copyWith({
    Map<String, Set<IngredientItem>>? items,
    Set<String>? purchasedItems,
    Map<String, double>? addedQuantity,
  }) {
    return PantryState(
      items ?? this.items,
      purchasedItems ?? this.purchasedItems,
      addedQuantity ?? this.addedQuantity,
    );
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
  PantryStateNotifier() : super(const PantryState({}, {}, {}));

  void setIngredients(String id, IngredientItem item, double? quantity) {
    Map<String, Set<IngredientItem>> map = {};
    map.addAll(state.items);
    map.update(id, ((val) => {...val, item}), ifAbsent: () => {item});
    state = state.copyWith(items: map);
    if (quantity != null) {
      setQuantity(item.ingredientId, quantity);
    }
  }

  void setQuantity(String itemId, double quantity) {
    Map<String, double> map = {};
    map.addAll(state.addedQuantity);
    map.update(itemId, (value) => value + quantity, ifAbsent: () => quantity);
    state = state.copyWith(addedQuantity: map);
  }

  void setPurchasedIems(String id) {
    state = state.copyWith(purchasedItems: {...state.purchasedItems, id});
  }
}

final pantryStateNotifierProvider =
    StateNotifierProvider<PantryStateNotifier, PantryState>(
  (ref) => PantryStateNotifier(),
);
