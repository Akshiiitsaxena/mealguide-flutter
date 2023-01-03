import 'package:mealguide/models/meal_plan_model.dart';

class DayPlan {
  final List<MealPlan> mealPlan;
  final int waterConsumed;
  final String id;

  DayPlan({
    required this.id,
    required this.mealPlan,
    required this.waterConsumed,
  });

  factory DayPlan.fromDoc(Map<String, dynamic> doc) {
    List<MealPlan> mealPlans = [];
    doc['meals'].forEach((mealDoc) {
      mealPlans.add(MealPlan.fromDoc(mealDoc));
    });

    return DayPlan(
      id: doc['_id'],
      mealPlan: mealPlans,
      waterConsumed: doc['water_consumed'],
    );
  }

  double getTotalNutrition(NutritionType type) {
    return mealPlan.fold(0, (val, plan) {
      switch (type) {
        case NutritionType.calories:
          return val + plan.nutrition.calories;
        case NutritionType.carbs:
          return val + plan.nutrition.carbohydrates;
        case NutritionType.fat:
          return val + plan.nutrition.fat;
        case NutritionType.fiber:
          return val + plan.nutrition.fiber;
        case NutritionType.protein:
          return val + plan.nutrition.protein;
        default:
          return val + plan.nutrition.calories;
      }
    });
  }

  double getConsumedNutrition(NutritionType type) {
    return mealPlan.fold(0, (val, plan) {
      switch (type) {
        case NutritionType.calories:
          return val + (plan.consumed ? plan.nutrition.calories : 0);
        case NutritionType.carbs:
          return val + (plan.consumed ? plan.nutrition.carbohydrates : 0);
        case NutritionType.fat:
          return val + (plan.consumed ? plan.nutrition.fat : 0);
        case NutritionType.fiber:
          return val + (plan.consumed ? plan.nutrition.fiber : 0);
        case NutritionType.protein:
          return val + (plan.consumed ? plan.nutrition.protein : 0);
        default:
          return val + (plan.consumed ? plan.nutrition.calories : 0);
      }
    });
  }

  String getConsumedFractionText(NutritionType type) =>
      '${getConsumedNutrition(type).toStringAsFixed(0)}/${getTotalNutrition(type).toStringAsFixed(0)}';
}

enum NutritionType { calories, protein, carbs, fat, fiber }
