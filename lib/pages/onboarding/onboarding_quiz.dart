import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/helper/error_widget.dart';
import 'package:mealguide/models/onboarding_model.dart';
import 'package:mealguide/pages/onboarding/onboarding_steps.dart';
import 'package:mealguide/pages/onboarding/question_screen.dart';
import 'package:mealguide/providers/onboarding_provider.dart';
import 'package:mealguide/providers/onboarding_state_provider.dart';
import 'package:mealguide/widgets/primary_button.dart';
import 'package:sizer/sizer.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questionsWatcher = ref.watch(onboardingProvider);
    final theme = Theme.of(context);

    return Scaffold(
      body: questionsWatcher.when(
        data: (questions) => OnboardingQuiz(questions: questions),
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
}

class OnboardingQuiz extends HookConsumerWidget {
  final List<OnboardingQuestion> questions;
  const OnboardingQuiz({Key? key, required this.questions}) : super(key: key);

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
          OnboardingSteps(totalSteps: questions.length),
          Expanded(
            child: QuestionScreen(
              questions: questions,
              pageController: pageController,
            ),
          ),
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
              FocusManager.instance.primaryFocus?.unfocus();
            },
          ),
          SizedBox(height: 5.h),
        ],
      ),
    );
  }
}
