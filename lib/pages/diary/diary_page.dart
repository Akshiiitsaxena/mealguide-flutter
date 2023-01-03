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
import 'package:percent_indicator/percent_indicator.dart';
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
                      buildNutritionInfo(
                          'PROTEIN',
                          plan.getConsumedFractionText(NutritionType.protein),
                          Theme.of(context)),
                      buildNutritionInfo(
                          'CARBS',
                          plan.getConsumedFractionText(NutritionType.carbs),
                          Theme.of(context)),
                      buildNutritionInfo(
                          'FATS',
                          plan.getConsumedFractionText(NutritionType.fat),
                          Theme.of(context)),
                      buildNutritionInfo(
                          'FIBER',
                          plan.getConsumedFractionText(NutritionType.fiber),
                          Theme.of(context)),
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

  Widget buildNutritionInfo(String title, String fraction, ThemeData theme) {
    return Column(
      children: [
        Text(title, style: theme.textTheme.bodySmall),
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
