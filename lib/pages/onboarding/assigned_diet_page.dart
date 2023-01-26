import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/helper/bottom_sheets.dart';
import 'package:mealguide/helper/mg_exception.dart';
import 'package:mealguide/models/diet_model.dart';
import 'package:mealguide/providers/diet_provider.dart';
import 'package:mealguide/providers/hive_provider.dart';
import 'package:mealguide/providers/onboarding_provider.dart';
import 'package:mealguide/providers/onboarding_state_provider.dart';
import 'package:mealguide/widgets/primary_button.dart';
import 'package:mealguide/widgets/rotating_plate.dart';
import 'package:mealguide/widgets/secondary_button.dart';
import 'package:sizer/sizer.dart';

class AssignedDietPage extends ConsumerWidget {
  const AssignedDietPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final onboardingAnswerWatcher = ref.watch(onboardingAnswerProvider);

    return Scaffold(
      body: onboardingAnswerWatcher.when(
        data: (data) {
          String calories = data['calories'].floor().toString();
          List<String> plans = [];

          data['diet_plans'].forEach((plan) {
            plans.add(plan);
          });

          return SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 2.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MgSecondaryButton(
                        'Retake Quiz',
                        width: 25.w,
                        onTap: () {
                          ref
                              .read(
                                  onboardingQuizStateNotifierProvider.notifier)
                              .clearAnswers();
                          Navigator.of(context).pop();
                        },
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'Your personalised meal plan is ready!',
                        style: theme.textTheme.labelLarge!.copyWith(
                          fontSize: 14.sp,
                          color: const Color(0xff7e79eb).withOpacity(0.6),
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'Your daily net calories goal is',
                        style: theme.textTheme.labelLarge!.copyWith(
                          fontSize: 14.sp,
                          color: const Color(0xff7e79eb).withOpacity(0.6),
                        ),
                      ),
                      Text(
                        '$calories calories',
                        style: theme.textTheme.labelLarge!.copyWith(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 4.h),
                Expanded(
                  child: FutureBuilder<List<Diet>>(
                    future: ref.read(dietProvider.future),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Diet> diets = snapshot.data!
                            .where((element) => plans.contains(element.name))
                            .toList();

                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: diets.length,
                          padding: EdgeInsets.symmetric(horizontal: 6.w),
                          itemBuilder: (_, index) {
                            Diet diet = diets[index];

                            return Container(
                              width: 70.w,
                              decoration: BoxDecoration(
                                color: theme.canvasColor,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              height: double.infinity,
                              margin: EdgeInsets.only(right: 4.w, bottom: 2.h),
                              child: Stack(
                                children: [
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 4.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 22.h),
                                        Text(
                                          diet.getDisplayName,
                                          style: theme.textTheme.titleMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.w900),
                                        ),
                                        SizedBox(height: 1.h),
                                        Text(
                                          diet.getShortDescription,
                                          style: theme.textTheme.bodySmall,
                                        ),
                                        const Spacer(),
                                        MgSecondaryButton(
                                          'View Dietary Guidelines',
                                          width: 40.w,
                                          onTap: () => MgBottomSheet
                                              .showDietaryGuidelines(
                                            context,
                                            diet,
                                          ),
                                        ),
                                        MgPrimaryButton(
                                          'Start Plan',
                                          onTap: () => ref
                                              .read(hiveProvider)
                                              .setLocalMealPlan(diet.name),
                                          isEnabled: true,
                                          height: 5.h,
                                          width: 35.w,
                                        ),
                                        SizedBox(height: 2.h),
                                      ],
                                    ),
                                  ),
                                  RotatingPlate(
                                    diet.getImage,
                                    size: 18.h,
                                    left: -10.w,
                                    top: 2.h,
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      }
                      return Container();
                    },
                  ),
                ),
                SizedBox(height: 2.h),
              ],
            ),
          );
        },
        error: (err, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                (err as MgException).message.toString(),
                style: theme.textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
              ),
              SizedBox(height: 2.h),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Retake Quiz',
                  style: theme.textTheme.labelLarge!.copyWith(
                    fontSize: 12.sp,
                  ),
                ),
              )
            ],
          ),
        ),
        loading: () => Center(
          child: CircularProgressIndicator(color: theme.primaryColor),
        ),
      ),
    );
  }
}
