import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/helper/error_widget.dart';
import 'package:mealguide/models/day_plan_model.dart';
import 'package:mealguide/pages/diary/calendar_row.dart';
import 'package:mealguide/pages/diary/calorie_box.dart';
import 'package:mealguide/pages/diary/diary_recipes.dart';
import 'package:mealguide/pages/diary/water_box.dart';
import 'package:mealguide/providers/diary_provider.dart';
import 'package:mealguide/providers/diary_state_provider.dart';
import 'package:mealguide/widgets/diary_container.dart';
import 'package:mealguide/widgets/mg_bar.dart';
import 'package:sizer/sizer.dart';

class DiaryPage extends HookConsumerWidget {
  const DiaryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final diaryWatcher = ref.watch(diaryProvider);
    final diaryState = ref.watch(diaryStateNotifierProvider);
    final theme = Theme.of(context);

    return Scaffold(
      body: diaryWatcher.when(
        data: (data) {
          int selectedDay = diaryState.date.difference(data.startTime).inDays;
          DayPlan plan = data.plans[selectedDay];
          return Scaffold(
            appBar: MgAppBar(
              height: 12.h,
              child: CalendarRow(startDate: data.startTime),
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
                      NutritionInfoTile(
                          nutritionType: NutritionType.fat, plan: plan),
                      NutritionInfoTile(
                          nutritionType: NutritionType.fiber, plan: plan),
                    ],
                  ),
                ),
                SizedBox(height: 1.h),
                DiaryRecipes(dayPlan: plan)
              ],
            ),
          );
        },
        error: (_, __) => const MgError(
          title: 'Whoops! Something went wrong',
          subtitle: 'Please try again later.',
        ),
        loading: () => Center(
          child: CircularProgressIndicator(color: theme.primaryColor),
        ),
      ),
    );
  }
}

class NutritionInfoTile extends ConsumerWidget {
  final NutritionType nutritionType;
  final DayPlan plan;
  const NutritionInfoTile(
      {super.key, required this.nutritionType, required this.plan});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final diaryState = ref.watch(diaryStateNotifierProvider);
    var fraction = '';

    switch (nutritionType) {
      case NutritionType.carbs:
        fraction =
            '${(diaryState.nutritionConsumedForPlan[plan.id]?.carbohydrates ?? 0).toStringAsFixed(0)}/${plan.getTotalNutrition(NutritionType.carbs).toStringAsFixed(0)}';
        break;
      case NutritionType.fat:
        fraction =
            '${(diaryState.nutritionConsumedForPlan[plan.id]?.fat ?? 0).toStringAsFixed(0)}/${plan.getTotalNutrition(NutritionType.fat).toStringAsFixed(0)}';
        break;
      case NutritionType.fiber:
        fraction =
            '${(diaryState.nutritionConsumedForPlan[plan.id]?.fiber ?? 0).toStringAsFixed(0)}/${plan.getTotalNutrition(NutritionType.fiber).toStringAsFixed(0)}';
        break;
      case NutritionType.protein:
        fraction =
            '${(diaryState.nutritionConsumedForPlan[plan.id]?.protein ?? 0).toStringAsFixed(0)}/${plan.getTotalNutrition(NutritionType.protein).toStringAsFixed(0)}';
        break;
      default:
    }

    return Column(
      children: [
        Text(nutritionType.toString().toUpperCase(),
            style: theme.textTheme.bodySmall),
        SizedBox(height: 0.2.h),
        Row(
          children: [
            Text(fraction,
                style: theme.textTheme.labelLarge!.copyWith(fontSize: 12.sp)),
            Text(
              ' G',
              style: theme.textTheme.labelLarge,
            )
          ],
        )
      ],
    );
  }
}
