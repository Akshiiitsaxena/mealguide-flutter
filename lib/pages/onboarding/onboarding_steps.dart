import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/providers/onboarding_state_provider.dart';
import 'package:sizer/sizer.dart';

class OnboardingSteps extends HookConsumerWidget {
  const OnboardingSteps({Key? key}) : super(key: key);

  final int totalSteps = 8;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int currentStep =
        ref.watch(onboardingQuizStateNotifierProvider).currentStep;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 32, 0, 0),
        child: Row(
          children: List.generate(
            totalSteps,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              margin: EdgeInsets.only(left: 1.5.w),
              decoration: BoxDecoration(
                color: index <= currentStep
                    ? Colors.deepPurpleAccent.shade100
                    : Colors.deepPurpleAccent.shade100.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              height: 1.h,
              width: 7.w,
            ),
          ),
        ),
      ),
    );
  }
}
