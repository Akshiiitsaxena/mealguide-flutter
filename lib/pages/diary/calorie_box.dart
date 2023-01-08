import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/models/day_plan_model.dart';
import 'package:mealguide/providers/diary_state_provider.dart';
import 'package:mealguide/widgets/diary_container.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:sizer/sizer.dart';

class CalorieBox extends ConsumerWidget {
  const CalorieBox({
    Key? key,
    required this.plan,
  }) : super(key: key);

  final DayPlan plan;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final diaryState = ref.watch(diaryStateNotifierProvider);

    var percentage =
        diaryState.nutritionConsumedForPlan[plan.id]?.calories ?? 0;

    percentage = percentage / plan.getTotalNutrition(NutritionType.calories);

    return DiaryContainer(
      height: 43.w,
      width: 43.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.topRight,
            child: CircularPercentIndicator(
              radius: 11.w,
              lineWidth: 3.w,
              percent: percentage > 1 ? 1 : percentage,
              progressColor: theme.primaryColor,
              circularStrokeCap: CircularStrokeCap.round,
              backgroundColor: theme.primaryColor.withOpacity(0.2),
              animation: true,
              curve: Curves.easeInOutBack,
              animationDuration: 400,
              animateFromLastPercent: true,
              center: percentage >= 1
                  ? Icon(
                      Icons.check,
                      color: theme.primaryColor,
                    )
                  : Container(),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('CALORIES', style: theme.textTheme.bodySmall!),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${(diaryState.nutritionConsumedForPlan[plan.id]?.calories ?? 0).toStringAsFixed(0)}/${plan.getTotalNutrition(NutritionType.calories).toStringAsFixed(0)}',
                      style: theme.textTheme.labelLarge!.copyWith(
                          fontSize: 14.sp, fontWeight: FontWeight.w800),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 0.2.h),
                      child: Text(
                        ' KCAL',
                        style: theme.textTheme.labelLarge,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
