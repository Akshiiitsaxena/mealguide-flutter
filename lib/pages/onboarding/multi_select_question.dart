import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/models/onboarding_model.dart';
import 'package:mealguide/providers/onboarding_state_provider.dart';
import 'package:sizer/sizer.dart';

class MultiSelectQuestion extends HookConsumerWidget {
  final List<OnboardingOption> options;
  final String questionKey;

  const MultiSelectQuestion({
    required this.options,
    super.key,
    required this.questionKey,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboardingQuizStateWatcher =
        ref.read(onboardingQuizStateNotifierProvider.notifier);

    useEffect(() {
      Future.microtask(() {
        onboardingQuizStateWatcher.setHasSelected(true);
      });
      return null;
    }, []);

    final allergicItems = useState(<String>[]);

    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(top: 5.h),
        child: Wrap(
          children: List.generate(
            options.length,
            (index) => InkWell(
              onTap: () {
                List<String> tempList = [];
                tempList.addAll(allergicItems.value);

                if (allergicItems.value.contains(options[index].title)) {
                  tempList.remove(options[index].title);
                  allergicItems.value = tempList;
                } else {
                  tempList.add(options[index].title);
                  allergicItems.value = tempList;
                }

                onboardingQuizStateWatcher.setAnswers(
                  questionKey,
                  allergicItems.value,
                );
              },
              child: AllergyChip(
                isSelected: allergicItems.value.contains(options[index].title),
                title: options[index].title,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AllergyChip extends StatelessWidget {
  final String title;
  final bool isSelected;

  const AllergyChip({super.key, required this.isSelected, required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedContainer(
      margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
      duration: const Duration(milliseconds: 400),
      padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isSelected ? Colors.redAccent : theme.canvasColor,
      ),
      child: Text(
        title,
        style: isSelected
            ? theme.textTheme.bodySmall!
                .copyWith(color: Colors.white, fontSize: 12.sp)
            : theme.textTheme.bodySmall!.copyWith(fontSize: 12.sp),
      ),
    );
  }
}
