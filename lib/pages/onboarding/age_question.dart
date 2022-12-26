import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/providers/onboarding_state_provider.dart';
import 'package:sizer/sizer.dart';

class AgeQuestion extends HookConsumerWidget {
  const AgeQuestion({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final ageController = useTextEditingController();
    final onboardingQuizStateWatcher =
        ref.read(onboardingQuizStateNotifierProvider.notifier);

    return Expanded(
      child: Container(
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
        child: TextFormField(
          autofocus: true,
          cursorColor: theme.primaryColor,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Enter your age...',
            hintStyle: theme.textTheme.titleLarge!
                .copyWith(color: Colors.grey, fontSize: 18.sp),
          ),
          keyboardType: TextInputType.number,
          style: theme.textTheme.labelLarge!
              .copyWith(fontSize: 34.sp, color: theme.indicatorColor),
          onChanged: (value) {
            int? age = int.tryParse(value);

            if (age == null || age < 2 || age > 100) {
              onboardingQuizStateWatcher.setHasSelected(false);
            } else {
              onboardingQuizStateWatcher.setHasSelected(true);
            }
          },
        ),
      ),
    );
  }
}
