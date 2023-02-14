import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/helper/wave_slider.dart';
import 'package:mealguide/providers/onboarding_state_provider.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class HeightQuestion extends HookConsumerWidget {
  final String questionKey;
  const HeightQuestion({super.key, required this.questionKey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboardingQuizStateWatcher =
        ref.read(onboardingQuizStateNotifierProvider.notifier);

    // useEffect(() {
    //   Future.microtask(() {
    //     onboardingQuizStateWatcher.setHasSelected(true);
    //   });
    //   return null;
    // }, []);

    final theme = Theme.of(context);
    final measure = useState(Measure.metric);

    final isChanging = useState(false);

    final min, max;
    final minText, maxText;

    switch (measure.value) {
      case Measure.metric:
        min = 92;
        minText = '$min cm';
        max = 244;
        maxText = '$max cm';
        break;
      case Measure.imperial:
        min = 36;
        minText = '3\' 0"';
        max = 96;
        maxText = '8\' 0"';
        break;
      default:
        min = 92;
        minText = '$min cm';
        max = 244;
        maxText = '$max cm';
    }

    final height = useState((min + max) / 2);

    String heightText;

    if (measure.value == Measure.imperial) {
      heightText =
          '${(height.value / 12).floor()}\' ${(height.value % 12).floor()}"';
    } else {
      heightText = '${height.value.floor()} cm';
    }

    return Expanded(
        child: Container(
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 2.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    measure.value = Measure.metric;
                    height.value = 168;
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
                          'cm',
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
                    height.value = 66;
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
                          'ft-in',
                          style: theme.textTheme.bodyMedium!
                              .copyWith(fontSize: 12.sp),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
                  decoration: BoxDecoration(
                    color: theme.canvasColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    heightText,
                    style: theme.textTheme.titleLarge!
                        .copyWith(color: theme.primaryColor),
                  ),
                )
              ],
            ),
          ),
          const Spacer(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  maxText,
                  style: theme.textTheme.titleMedium!.copyWith(
                    color:
                        isChanging.value ? theme.indicatorColor : Colors.grey,
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 1.h),
                Expanded(
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: WaveSlider(
                      color:
                          isChanging.value ? theme.indicatorColor : Colors.grey,
                      onChanged: (perc) {
                        HapticFeedback.selectionClick();
                        final value = min + ((max - min) * perc);
                        onboardingQuizStateWatcher.setHasSelected(true);
                        height.value = value;

                        double val;
                        if (measure.value == Measure.imperial) {
                          val = value * 2.54;
                        } else {
                          val = value;
                        }
                        onboardingQuizStateWatcher.setAnswers(
                            questionKey, val.floor());
                      },
                      onChangeEnd: (_) => isChanging.value = false,
                      onChangeStart: (_) => isChanging.value = true,
                      sliderWidth: 60.w,
                      displayTrackball: true,
                    ),
                  ),
                ),
                SizedBox(height: 1.h),
                Text(
                  minText,
                  style: theme.textTheme.titleMedium!.copyWith(
                    color:
                        isChanging.value ? theme.indicatorColor : Colors.grey,
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 1.h),
              ],
            ),
          ),
          // SfTheme(
          //   data: SfThemeData(
          //     sliderThemeData: SfSliderThemeData(
          //       activeLabelStyle: theme.textTheme.bodyMedium,
          //       inactiveLabelStyle: theme.textTheme.bodyMedium,
          //       tooltipBackgroundColor: theme.canvasColor,
          //       tooltipTextStyle: theme.textTheme.bodyMedium!
          //           .copyWith(color: theme.primaryColor, fontSize: 14.sp),
          //     ),
          //   ),
          //   child: SfSlider.vertical(
          //     min: min,
          //     max: max,
          //     value: height.value.floor(),
          //     showLabels: true,
          //     showDividers: true,
          //     enableTooltip: true,
          //     shouldAlwaysShowTooltip: true,
          //     tooltipTextFormatterCallback: (actualValue, formattedText) {
          //       if (measure.value == Measure.imperial) {
          //         return '${(actualValue / 12).floor()}\' ${(actualValue % 12).floor()}"';
          //       } else {
          //         return '${actualValue.floor()} cm';
          //       }
          //     },
          //     labelFormatterCallback: (actualValue, formattedText) {
          //       if (measure.value == Measure.imperial) {
          //         return '${(actualValue / 12).floor()}\' ${(actualValue % 12).floor()}"';
          //       } else {
          //         return '${actualValue.floor()} cm';
          //       }
          //     },
          //     activeColor: theme.primaryColor,
          //     inactiveColor: theme.primaryColor.withOpacity(0.2),
          //     minorTicksPerInterval: 1,
          //     onChanged: (value) {
          // onboardingQuizStateWatcher.setHasSelected(true);
          // height.value = value;

          // double val;
          // if (measure.value == Measure.imperial) {
          //   val = value * 2.54;
          // } else {
          //   val = value;
          // }
          // onboardingQuizStateWatcher.setAnswers(questionKey, val.floor());
          //     },
          //   ),
          // ),
          SizedBox(width: 6.w),
        ],
      ),
    ));
  }
}

enum Measure { metric, imperial }
// 