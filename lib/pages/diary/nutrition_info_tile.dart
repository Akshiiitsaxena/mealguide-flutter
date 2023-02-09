import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/models/day_plan_model.dart';
import 'package:mealguide/providers/diary_state_provider.dart';
import 'package:sizer/sizer.dart';

class NutritionInfoTile extends ConsumerWidget {
  final NutritionType nutritionType;
  final DayPlan plan;

  const NutritionInfoTile({
    super.key,
    required this.nutritionType,
    required this.plan,
  });

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
