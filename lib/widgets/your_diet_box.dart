import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/helper/bottom_sheets.dart';
import 'package:mealguide/models/diet_model.dart';
import 'package:mealguide/providers/local_plan_state_provider.dart';
import 'package:mealguide/widgets/rotating_plate.dart';
import 'package:mealguide/widgets/secondary_button.dart';
import 'package:sizer/sizer.dart';

class YourDietBox extends HookConsumerWidget {
  final List<Diet> diets;

  const YourDietBox({super.key, required this.diets});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final dietName = ref.watch(localPlanNotifierProvider).plan;

    Diet diet = diets.firstWhere((element) => element.name == dietName);

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: theme.canvasColor,
        ),
        margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        height: 18.h,
        width: 100.w,
        child: Stack(
          children: [
            Container(
              width: 50.w,
              padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your Assigned Plan',
                    style: theme.textTheme.labelLarge,
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    diet.getDisplayName,
                    style: theme.textTheme.titleMedium,
                  ),
                  const Spacer(),
                  MgSecondaryButton(
                    'View Dietary Guidelines',
                    onTap: () =>
                        MgBottomSheet.showDietaryGuidelines(context, diet),
                  )
                ],
              ),
            ),
            RotatingPlate(diet.getImage, size: 16.h, right: -8.w, top: 1.h),
          ],
        ),
      ),
    );
  }
}
