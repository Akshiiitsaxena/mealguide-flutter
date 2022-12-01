import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/models/recipe_model.dart';

@immutable
class RecipeTypeState {
  final RecipeType type;

  const RecipeTypeState({this.type = RecipeType.breakfast});

  RecipeTypeState copyWith({RecipeType? recipeType}) {
    return RecipeTypeState(type: recipeType ?? type);
  }
}

class RecipeTypeStateNotifier extends StateNotifier<RecipeTypeState> {
  RecipeTypeStateNotifier() : super(const RecipeTypeState());

  void setCurrentType(RecipeType value) {
    state = state.copyWith(recipeType: value);
  }
}

final recipeTypeStateNotifierProvider =
    StateNotifierProvider<RecipeTypeStateNotifier, RecipeTypeState>(
  (ref) => RecipeTypeStateNotifier(),
);
