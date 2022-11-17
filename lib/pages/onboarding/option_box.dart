import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/providers/onboarding_state_provider.dart';
import 'package:mealguide/widgets/mg_container.dart';
import 'package:sizer/sizer.dart';

class OptionBox extends HookConsumerWidget {
  final int index;
  OptionBox({super.key, required this.index});

  double scale = 1;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboardingQuizStateWatcher =
        ref.read(onboardingQuizStateNotifierProvider.notifier);

    bool isSelected = index ==
        ref.watch(onboardingQuizStateNotifierProvider).currentSelection;

    if (isSelected) {
      scale = 1.02;
    } else {
      scale = 1;
    }

    return AnimatedScale(
      scale: scale,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeIn,
      child: GestureDetector(
        onTap: () {
          onboardingQuizStateWatcher.setHasSelected(true);
          onboardingQuizStateWatcher.setCurrentSelection(index);
        },
        child: MgContainer(
          height: 7.h,
          border: Border.all(
              width: 1,
              color: isSelected
                  ? Colors.deepPurpleAccent.shade100.withOpacity(0.5)
                  : Colors.grey.shade900),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'This is the Option $index',
                style: isSelected
                    ? Theme.of(context).textTheme.titleLarge
                    : Theme.of(context).textTheme.titleMedium,
              ),
              isSelected
                  ? Icon(Icons.check, color: Colors.deepPurpleAccent.shade100)
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
