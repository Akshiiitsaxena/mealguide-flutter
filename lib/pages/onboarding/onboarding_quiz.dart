import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/pages/onboarding/onboarding_steps.dart';
import 'package:mealguide/pages/onboarding/question_screen.dart';
import 'package:mealguide/providers/onboarding_state_provider.dart';
import 'package:mealguide/widgets/primary_button.dart';
import 'package:sizer/sizer.dart';

class OnboardingQuiz extends HookConsumerWidget {
  const OnboardingQuiz({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboardingQuizStateWatcher =
        ref.watch(onboardingQuizStateNotifierProvider.notifier);
    final onboardingQuizStateNotifier =
        ref.watch(onboardingQuizStateNotifierProvider);

    int currentStep = onboardingQuizStateNotifier.currentStep;
    bool hasSelected = onboardingQuizStateNotifier.hasSelected;

    PageController pageController = usePageController();

    return Scaffold(
      body: Column(
        children: [
          const OnboardingSteps(),
          Expanded(child: QuestionScreen(pageController: pageController)),
          MgPrimaryButton(
            'Continue',
            isEnabled: hasSelected,
            onTap: () {
              pageController.animateToPage(
                currentStep + 1,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeIn,
              );
              onboardingQuizStateWatcher.setCurrentStep(currentStep + 1);
              onboardingQuizStateWatcher.setHasSelected(false);
              onboardingQuizStateWatcher.setCurrentSelection(-1);
            },
          ),
          SizedBox(height: 5.h),
        ],
      ),
    );
  }
}
