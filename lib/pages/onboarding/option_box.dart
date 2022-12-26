import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/models/onboarding_model.dart';
import 'package:mealguide/providers/onboarding_state_provider.dart';
import 'package:mealguide/widgets/mg_container.dart';
import 'package:sizer/sizer.dart';

class OptionBox extends HookConsumerWidget {
  final int index;
  final OnboardingOption option;
  OptionBox({super.key, required this.index, required this.option});

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

    final theme = Theme.of(context);

    return AnimatedScale(
      scale: scale,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeIn,
      child: GestureDetector(
        onTap: () {
          onboardingQuizStateWatcher.setHasSelected(true);
          onboardingQuizStateWatcher.setCurrentSelection(index);
        },
        child: MgOptionContainer(
          height: option.subtext != null ? 10.h : 7.h,
          border: Border.all(
            width: 1,
            color: isSelected
                ? theme.primaryColor.withOpacity(1)
                : Colors.transparent,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    option.title,
                    style: isSelected
                        ? theme.textTheme.headlineMedium!
                            .copyWith(fontWeight: FontWeight.bold)
                        : theme.textTheme.headlineSmall!
                            .copyWith(fontWeight: FontWeight.bold),
                  ),
                  option.subtext != null
                      ? SizedBox(
                          width: 60.w,
                          child: Text(
                            option.subtext!,
                            style: isSelected
                                ? theme.textTheme.bodyMedium!.copyWith()
                                : theme.textTheme.bodySmall!.copyWith(),
                          ),
                        )
                      : Container(),
                ],
              ),
              isSelected
                  ? Icon(
                      Icons.check,
                      color: theme.primaryColor,
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
