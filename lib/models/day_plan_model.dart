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
}
