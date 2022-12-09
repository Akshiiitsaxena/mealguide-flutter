import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/models/ingredient_model.dart';

@immutable
class PantryState {
  final Map<String, Set<IngredientItem>> items;
  final List<String> purchasedItems;

  const PantryState(this.items, this.purchasedItems);

  PantryState copyWith({
    Map<String, Set<IngredientItem>>? items,
    List<String>? purchasedItems,
  }) {
    return PantryState(
      items ?? this.items,
      purchasedItems ?? this.purchasedItems,
    );
  }
}

class PantryStateNotifier extends StateNotifier<PantryState> {
  PantryStateNotifier() : super(const PantryState({}, []));

  void setIngredients(String id, IngredientItem item) {
    Map<String, Set<IngredientItem>> map = {};
    map.addAll(state.items);
    map.update(id, ((val) => {...val, item}), ifAbsent: () => {item});
    state = state.copyWith(items: map);
  }

  void setPurchasedIems(String id) {
    state = state.copyWith(purchasedItems: [...state.purchasedItems, id]);
  }
}

final pantryStateNotifierProvider =
    StateNotifierProvider<PantryStateNotifier, PantryState>(
  (ref) => PantryStateNotifier(),
);
