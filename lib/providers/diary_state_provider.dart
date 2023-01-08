import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mealguide/models/day_plan_model.dart';
import 'package:mealguide/models/nutrition_model.dart';

@immutable
class DiaryState {
  final DateTime date;
  final int dailyWater;
  final Map<String, int> waterConsumedForPlan;
  final Map<String, List<String>> recipeConsumedForPlan;
  final Map<String, Nutrition> nutritionConsumedForPlan;

  const DiaryState({
    required this.date,
    required this.dailyWater,
    required this.waterConsumedForPlan,
    required this.recipeConsumedForPlan,
    required this.nutritionConsumedForPlan,
  });

  DiaryState copyWith({
    DateTime? date,
    int? dailyWater,
    Map<String, int>? waterConsumedForPlan,
    Map<String, List<String>>? recipeConsumedForPlan,
    Map<String, Nutrition>? nutritionConsumedForPlan,
  }) {
    return DiaryState(
      date: date ?? this.date,
      dailyWater: dailyWater ?? this.dailyWater,
      waterConsumedForPlan: waterConsumedForPlan ?? this.waterConsumedForPlan,
      recipeConsumedForPlan:
          recipeConsumedForPlan ?? this.recipeConsumedForPlan,
      nutritionConsumedForPlan:
          nutritionConsumedForPlan ?? this.nutritionConsumedForPlan,
    );
  }

  get getDateTitle {
    String trailing = DateFormat(', dd MMM').format(date);
    String day;

    if (date.day == DateTime.now().day) {
      day = 'Today';
    } else if (date.day == DateTime.now().add(const Duration(days: 1)).day) {
      day = 'Tomorrow';
    } else {
      day = DateFormat('EEEE').format(date);
    }

    return '$day$trailing';
  }
}

class DiaryStateNotifier extends StateNotifier<DiaryState> {
  DiaryStateNotifier()
      : super(
          DiaryState(
            date: DateTime.now(),
            dailyWater: 8,
            waterConsumedForPlan: const {},
            recipeConsumedForPlan: const {},
            nutritionConsumedForPlan: const {},
          ),
        );

  void setDate(DateTime dateTime) {
    state = state.copyWith(date: dateTime);
  }

  void setDailyWater(int value) {
    if (value <= 18 && value >= 4) {
      state = state.copyWith(dailyWater: value);
    }
  }

  void setWaterConsumedForPlan(String planId, int waterConsumed) {
    Map<String, int> tempState = {};
    tempState.addAll(state.waterConsumedForPlan);

    tempState.update(
      planId,
      (value) => waterConsumed,
      ifAbsent: () => waterConsumed,
    );
    state = state.copyWith(waterConsumedForPlan: tempState);
  }

  void setRecipeConsumedForPlan(String planId, String recipeId) {
    Map<String, List<String>> tempState = {};
    tempState.addAll(state.recipeConsumedForPlan);

    tempState.update(
      planId,
      (value) => [...value, recipeId],
      ifAbsent: () => [recipeId],
    );
    state = state.copyWith(recipeConsumedForPlan: tempState);
  }

  void setNutritionConsumedForPlan(String mealPlanId, Nutrition nutrition) {
    Map<String, Nutrition> tempMap = {};
    tempMap.addAll(state.nutritionConsumedForPlan);

    tempMap.update(
      mealPlanId,
      (value) => Nutrition(
        calories: value.calories + nutrition.calories,
        carbohydrates: value.carbohydrates + nutrition.carbohydrates,
        fat: value.fat + nutrition.fat,
        fiber: value.fiber + nutrition.fiber,
        protein: value.protein + nutrition.protein,
      ),
      ifAbsent: () => tempMap[mealPlanId] = nutrition,
    );

    state = state.copyWith(nutritionConsumedForPlan: tempMap);
  }
}

final diaryStateNotifierProvider =
    StateNotifierProvider<DiaryStateNotifier, DiaryState>(
  (_) => DiaryStateNotifier(),
);
