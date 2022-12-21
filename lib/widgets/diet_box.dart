import 'package:flutter/material.dart';
import 'package:mealguide/models/diet_model.dart';
import 'package:mealguide/widgets/rotating_plate.dart';
import 'package:mealguide/widgets/secondary_button.dart';
import 'package:sizer/sizer.dart';

class DietBox extends StatelessWidget {
  final Diet diet;
  final int recipes;
  final bool isForHome;

  const DietBox({
    super.key,
    required this.diet,
    required this.recipes,
    this.isForHome = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
                    isForHome
                        ? 'Your Assigned Plan'
                        : '$recipes+ delicious recipes',
                    style: theme.textTheme.labelLarge,
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    diet.getDisplayName,
                    style: theme.textTheme.titleMedium,
                  ),
                  const Spacer(),
                  MgSecondaryButton('View Dietary Guidelines', onTap: () {})
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
