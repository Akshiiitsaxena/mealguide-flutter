import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@immutable
class RecipeState {
  final Map<String, double> servingQuantity;

  const RecipeState(this.servingQuantity);

  RecipeState copyWith({Map<String, double>? servingQuantity}) {
    return RecipeState(servingQuantity ?? this.servingQuantity);
  }
}

class RecipeStateNotifier extends StateNotifier<RecipeState> {
  RecipeStateNotifier() : super(const RecipeState({}));

  void setQuantity(String id, double value) {
    Map<String, double> map = {};
    map.addAll(state.servingQuantity);
    map.update(id, (_) => value, ifAbsent: () => value);
    state = state.copyWith(servingQuantity: map);
  }
}

final recipeStateNotifierProvider =
    StateNotifierProvider<RecipeStateNotifier, RecipeState>(
  (ref) => RecipeStateNotifier(),
);
