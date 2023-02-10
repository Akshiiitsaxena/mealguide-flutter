import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/models/day_plan_model.dart';
import 'package:mealguide/models/diary_model.dart';
import 'package:mealguide/pages/diary/calendar_row.dart';
import 'package:mealguide/pages/diary/calorie_box.dart';
import 'package:mealguide/pages/diary/diary_recipes.dart';
import 'package:mealguide/pages/diary/nutrition_info_tile.dart';
import 'package:mealguide/pages/diary/water_box.dart';
import 'package:mealguide/providers/diary_state_provider.dart';
import 'package:mealguide/widgets/diary_container.dart';
import 'package:mealguide/widgets/mg_bar.dart';
import 'package:sizer/sizer.dart';

class DiaryMealPlanPage extends HookConsumerWidget {
  final Diary diary;
  const DiaryMealPlanPage({Key? key, required this.diary}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final diaryState = ref.watch(diaryStateNotifierProvider);

    int selectedDay = diaryState.date.difference(diary.startTime).inDays;
    DayPlan plan = diary.plans[selectedDay];

    return Scaffold(
      appBar: MgAppBar(
        height: 12.h,
        child: CalendarRow(startDate: diary.startTime),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
        children: [
          Row(
            children: [
              CalorieBox(plan: plan),
              const Spacer(),
              WaterBox(plan: plan),
            ],
          ),
          SizedBox(height: 2.h),
          DiaryContainer(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                NutritionInfoTile(
                    nutritionType: NutritionType.protein, plan: plan),
                NutritionInfoTile(
                    nutritionType: NutritionType.carbs, plan: plan),
                NutritionInfoTile(nutritionType: NutritionType.fat, plan: plan),
                NutritionInfoTile(
                    nutritionType: NutritionType.fiber, plan: plan),
              ],
            ),
          ),
          SizedBox(height: 1.h),
          DiaryRecipes(dayPlan: plan, masterDayPlanId: diary.masterPlanId)
        ],
      ),
    );
  }
}
