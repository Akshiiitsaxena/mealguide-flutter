import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/providers/onboarding_state_provider.dart';
import 'package:sizer/sizer.dart';

class OnboardingSteps extends HookConsumerWidget {
  final int totalSteps;
  const OnboardingSteps({Key? key, required this.totalSteps}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int currentStep =
        ref.watch(onboardingQuizStateNotifierProvider).currentStep;

    final theme = Theme.of(context);

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(4.w, 4.h, 0, 0),
        child: Row(
          children: List.generate(
            totalSteps,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              margin: EdgeInsets.only(left: 1.5.w),
              decoration: BoxDecoration(
                color: index <= currentStep
                    ? theme.primaryColor
                    : theme.primaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              height: 0.75.h,
              width: 5.w,
            ),
          ),
        ),
      ),
    );
  }
}
