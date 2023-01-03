import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/models/day_plan_model.dart';
import 'package:mealguide/providers/diary_state_provider.dart';
import 'package:mealguide/widgets/diary_container.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sizer/sizer.dart';

class WaterBox extends HookConsumerWidget {
  final DayPlan plan;
  const WaterBox({super.key, required this.plan});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final diaryState = ref.watch(diaryStateNotifierProvider);
    final theme = Theme.of(context);
    final waterConsumed = useState(plan.waterConsumed);
    final dailyWater = diaryState.dailyWater;

    const Color waterColor = Colors.lightBlue;

    return Stack(
      children: [
        DiaryContainer(
          height: 43.w,
          width: 43.w,
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('WATER', style: theme.textTheme.bodySmall!),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${waterConsumed.value.toString()}/$dailyWater',
                      style: theme.textTheme.labelLarge!.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w800,
                        color: waterColor,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 0.2.h),
                      child: Text(
                        ' GLASSES',
                        style: theme.textTheme.labelLarge!
                            .copyWith(color: waterColor),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 1.h),
                Row(
                  children: [
                    Container(
                      height: 4.h,
                      width: 24.w,
                      decoration: BoxDecoration(
                        color: waterColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(Icons.add, color: waterColor, size: 12.sp),
                    ),
                    SizedBox(width: 2.w),
                    Expanded(
                      child: Container(
                        height: 4.h,
                        decoration: BoxDecoration(
                          color: waterColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child:
                            Icon(Icons.remove, color: waterColor, size: 12.sp),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Positioned(
          top: 1.5.h,
          right: 4.w,
          child: CircularPercentIndicator(
            radius: 9.w,
            lineWidth: 2.w,
            percent: 0.2,
            progressColor: waterColor,
            circularStrokeCap: CircularStrokeCap.round,
            backgroundColor: waterColor.withOpacity(0.2),
            animation: true,
            curve: Curves.easeInOutBack,
            animationDuration: 400,
            animateFromLastPercent: true,
            center: Icon(
              Icons.water_drop_outlined,
              color: waterColor,
              size: 20.sp,
            ),
          ),
        )
      ],
    );
  }
}
