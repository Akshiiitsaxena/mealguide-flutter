import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/models/onboarding_model.dart';
import 'package:mealguide/pages/onboarding/age_question.dart';
import 'package:mealguide/pages/onboarding/height_question.dart';
import 'package:mealguide/pages/onboarding/multi_select_question.dart';
import 'package:mealguide/pages/onboarding/option_box.dart';
import 'package:mealguide/pages/onboarding/weight_question.dart';
import 'package:mealguide/providers/onboarding_state_provider.dart';
import 'package:sizer/sizer.dart';

class QuestionScreen extends HookConsumerWidget {
  final List<OnboardingQuestion> questions;
  final PageController pageController;

  const QuestionScreen({
    super.key,
    required this.pageController,
    required this.questions,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return PageView.builder(
      physics: const NeverScrollableScrollPhysics(),
      controller: pageController,
      itemCount: questions.length,
      itemBuilder: ((context, index) {
        final question = questions[index];
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 3.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child:
                    Text(question.question, style: theme.textTheme.titleMedium),
              ),
              Builder(builder: (_) {
                switch (question.type) {
                  case QuestionType.singleChoice:
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(top: 10.h),
                        child: ListView.builder(
                          padding: EdgeInsets.only(bottom: 5.h),
                          shrinkWrap: true,
                          itemCount: question.options!.length,
                          itemBuilder: (context, optionIndex) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: OptionBox(
                                index: optionIndex,
                                option: question.options![optionIndex],
                                questionKey: question.key,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );

                  case QuestionType.ageField:
                    return AgeQuestion(questionKey: question.key);

                  case QuestionType.heightSelector:
                    return HeightQuestion(questionKey: question.key);

                  case QuestionType.weightSelector:
                    return WeightQuestion(questionKey: question.key);

                  case QuestionType.multipleChoice:
                    return MultiSelectQuestion(
                      options: question.options!,
                      questionKey: question.key,
                    );

                  default:
                    return Container();
                }
              })
            ],
          ),
        );
      }),
    );
  }
}
