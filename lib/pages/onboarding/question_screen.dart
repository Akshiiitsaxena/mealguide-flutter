import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/pages/onboarding/option_box.dart';
import 'package:mealguide/providers/onboarding_state_provider.dart';
import 'package:sizer/sizer.dart';

class QuestionScreen extends HookConsumerWidget {
  final PageController pageController;

  const QuestionScreen({super.key, required this.pageController});

  final int totalSteps = 8;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageView.builder(
      physics: const NeverScrollableScrollPhysics(),
      controller: pageController,
      itemCount: 8,
      itemBuilder: ((context, index) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text('This is the question'),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: OptionBox(index: index),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
