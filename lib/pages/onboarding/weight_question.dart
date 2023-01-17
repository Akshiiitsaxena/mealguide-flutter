import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/pages/onboarding/height_question.dart';
import 'package:mealguide/providers/onboarding_state_provider.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class WeightQuestion extends HookConsumerWidget {
  final String questionKey;
  const WeightQuestion({super.key, required this.questionKey});

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

    final theme = Theme.of(context);
    final measure = useState(Measure.metric);

    final min, max;

    switch (measure.value) {
      case Measure.metric:
        min = 40;
        max = 140;
        break;
      case Measure.imperial:
        min = 88;
        max = 308;
        break;
      default:
        min = 40;
        max = 140;
    }

    final weight = useState((min + max) / 2);

    return Expanded(
        child: Container(
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 2.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    measure.value = Measure.metric;
                    weight.value = 90;
                  },
                  child: SizedBox(
                    width: 25.w,
                    child: Row(
                      children: [
                        Container(
                          height: 3.h,
                          width: 3.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: theme.scaffoldBackgroundColor,
                            border:
                                Border.all(color: theme.primaryColor, width: 2),
                          ),
                          alignment: Alignment.center,
                          child: Container(
                            height: 1.5.h,
                            width: 1.5.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: measure.value == Measure.metric
                                  ? theme.primaryColor
                                  : Colors.transparent,
                            ),
                          ),
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          'kg',
                          style: theme.textTheme.bodyMedium!
                              .copyWith(fontSize: 12.sp),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                InkWell(
                  onTap: () {
                    measure.value = Measure.imperial;
                    weight.value = 198;
                  },
                  child: SizedBox(
                    width: 25.w,
                    child: Row(
                      children: [
                        Container(
                          height: 3.h,
                          width: 3.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: theme.scaffoldBackgroundColor,
                            border:
                                Border.all(color: theme.primaryColor, width: 2),
                          ),
                          alignment: Alignment.center,
                          child: Container(
                            height: 1.5.h,
                            width: 1.5.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: measure.value == Measure.imperial
                                  ? theme.primaryColor
                                  : Colors.transparent,
                            ),
                          ),
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          'lb',
                          style: theme.textTheme.bodyMedium!
                              .copyWith(fontSize: 12.sp),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15.h),
          SizedBox(
            width: double.infinity,
            child: SfTheme(
              data: SfThemeData(
                sliderThemeData: SfSliderThemeData(
                  activeLabelStyle: theme.textTheme.bodyMedium,
                  inactiveLabelStyle: theme.textTheme.bodyMedium,
                  tooltipBackgroundColor: theme.canvasColor,
                  tooltipTextStyle: theme.textTheme.bodyMedium!
                      .copyWith(color: theme.primaryColor, fontSize: 14.sp),
                ),
              ),
              child: SfSlider(
                min: min,
                max: max,
                value: weight.value.floor(),
                showLabels: true,
                showDividers: true,
                enableTooltip: true,
                shouldAlwaysShowTooltip: true,
                tooltipTextFormatterCallback: (actualValue, formattedText) {
                  if (measure.value == Measure.imperial) {
                    return '${actualValue.floor()} lb';
                  } else {
                    return '${actualValue.floor()} kg';
                  }
                },
                labelFormatterCallback: (actualValue, formattedText) {
                  if (measure.value == Measure.imperial) {
                    return '${actualValue.floor()} lb';
                  } else {
                    return '${actualValue.floor()} kg';
                  }
                },
                activeColor: theme.primaryColor,
                inactiveColor: theme.primaryColor.withOpacity(0.2),
                minorTicksPerInterval: 1,
                onChanged: (value) {
                  weight.value = value;

                  double val;
                  if (measure.value == Measure.imperial) {
                    val = value / 2.205;
                  } else {
                    val = value;
                  }
                  onboardingQuizStateWatcher.setAnswers(
                      questionKey, val.floor());
                },
              ),
            ),
          ),
          SizedBox(width: 4.w),
        ],
      ),
    ));
  }
}
