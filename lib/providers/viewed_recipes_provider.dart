import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/providers/hive_provider.dart';

@immutable
class ViewedRecipes {
  final int viewed;

  const ViewedRecipes({required this.viewed});

  ViewedRecipes copyWith({int? viewed}) {
    return ViewedRecipes(viewed: viewed ?? this.viewed);
  }
}

class ViewedRecipesNotifier extends StateNotifier<ViewedRecipes> {
  final Ref ref;
  ViewedRecipesNotifier(this.ref) : super(const ViewedRecipes(viewed: 0));

  void setViewedRecipes(int value) {
    state = state.copyWith(viewed: value);
  }

  void addViewedRecipes() {
    state = state.copyWith(viewed: state.viewed + 1);
    ref.read(hiveProvider).setUserViewedRecipes(state.viewed);
  }
}

final viewedRecipeNotifierProvider =
    StateNotifierProvider<ViewedRecipesNotifier, ViewedRecipes>(
  (ref) => ViewedRecipesNotifier(ref),
);
