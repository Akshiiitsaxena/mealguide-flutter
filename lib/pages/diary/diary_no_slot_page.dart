import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/helper/bottom_sheets.dart';
import 'package:mealguide/widgets/primary_button.dart';
import 'package:sizer/sizer.dart';

class DiaryNoSlotPage extends HookConsumerWidget {
  const DiaryNoSlotPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/graphics/nutritionist.png',
            height: 15.h,
            width: 15.h,
          ),
          SizedBox(height: 5.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Text(
              'Book a call with our Nutritionist to get a personlised meal plan!',
              style: theme.textTheme.titleSmall,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 1.h),
          MgPrimaryButton(
            'Book a slot',
            onTap: () => MgBottomSheet.showNutritionistSheet(context),
            isEnabled: true,
          ),
        ],
      ),
    );
  }
}
