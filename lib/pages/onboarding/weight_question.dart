import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/helper/wave_slider.dart';
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
        min = 40;
        minText = '$min kg';
        max = 140;
        maxText = '$max kg';
        break;
      case Measure.imperial:
        min = 88;
        minText = '$min lb';
        max = 308;
        maxText = '$max lb';
        break;
      default:
        min = 40;
        minText = '$min kg';
        max = 140;
        maxText = '$max kg';
    }

    final weight = useState((min + max) / 2);

    String weightText;

    if (measure.value == Measure.imperial) {
      weightText = '${weight.value.floor()} lb';
    } else {
      weightText = '${weight.value.floor()} kg';
    }

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
          SizedBox(height: 10.h),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 30.w),
            padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
            decoration: BoxDecoration(
              color: theme.canvasColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              weightText,
              style: theme.textTheme.titleLarge!
                  .copyWith(color: theme.primaryColor),
            ),
          ),
          SizedBox(height: 5.h),
          Column(
            children: [
              Container(
                // color: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: WaveSlider(
                  color: isChanging.value ? theme.indicatorColor : Colors.grey,
                  onChanged: (perc) {
                    HapticFeedback.selectionClick();
                    final value = min + (max - min) * perc;
                    onboardingQuizStateWatcher.setHasSelected(true);
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
                  onChangeEnd: (_) => isChanging.value = false,
                  onChangeStart: (_) => isChanging.value = true,
                  displayTrackball: true,
                  sliderWidth: 80.w,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    minText,
                    style: theme.textTheme.titleMedium!.copyWith(
                      color:
                          isChanging.value ? theme.indicatorColor : Colors.grey,
                      fontSize: 14.sp,
                    ),
                  ),
                  Text(
                    maxText,
                    style: theme.textTheme.titleMedium!.copyWith(
                      color:
                          isChanging.value ? theme.indicatorColor : Colors.grey,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // SizedBox(
          //   width: double.infinity,
          //   child: SfTheme(
          //     data: SfThemeData(
          //       sliderThemeData: SfSliderThemeData(
          //         activeLabelStyle: theme.textTheme.bodyMedium,
          //         inactiveLabelStyle: theme.textTheme.bodyMedium,
          //         tooltipBackgroundColor: theme.canvasColor,
          //         tooltipTextStyle: theme.textTheme.bodyMedium!
          //             .copyWith(color: theme.primaryColor, fontSize: 14.sp),
          //       ),
          //     ),
          //     child: SfSlider(
          //       min: min,
          //       max: max,
          //       value: weight.value.floor(),
          //       showLabels: true,
          //       showDividers: true,
          //       enableTooltip: true,
          //       shouldAlwaysShowTooltip: true,
          //       tooltipTextFormatterCallback: (actualValue, formattedText) {
          //         if (measure.value == Measure.imperial) {
          //           return '${actualValue.floor()} lb';
          //         } else {
          //           return '${actualValue.floor()} kg';
          //         }
          //       },
          //       labelFormatterCallback: (actualValue, formattedText) {
          // if (measure.value == Measure.imperial) {
          //   return '${actualValue.floor()} lb';
          // } else {
          //   return '${actualValue.floor()} kg';
          // }
          //       },
          //       activeColor: theme.primaryColor,
          //       inactiveColor: theme.primaryColor.withOpacity(0.2),
          //       minorTicksPerInterval: 1,
          //       onChanged: (value) {
          //         onboardingQuizStateWatcher.setHasSelected(true);
          //         weight.value = value;

          //         double val;
          //         if (measure.value == Measure.imperial) {
          //           val = value / 2.205;
          //         } else {
          //           val = value;
          //         }
          //         onboardingQuizStateWatcher.setAnswers(
          //             questionKey, val.floor());
          //       },
          //     ),
          //   ),
          // ),

          SizedBox(width: 4.w),
        ],
      ),
    ));
  }
}
