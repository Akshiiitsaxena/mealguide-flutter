import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/helper/date_helper.dart';
import 'package:mealguide/providers/diary_state_provider.dart';
import 'package:sizer/sizer.dart';

class CalendarRow extends HookConsumerWidget {
  final DateTime startDate;
  const CalendarRow({super.key, required this.startDate});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final diaryState = ref.watch(diaryStateNotifierProvider);
    final title = diaryState.getDateTitle;

    final theme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleLarge,
        ),
        SizedBox(height: 1.2.h),
        Expanded(
            child: SizedBox(
          width: 100.w,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 14,
              itemBuilder: (context, index) {
                final date = startDate.add(Duration(days: index));
                final day = DateHelper.getDayLetter(date);
                final isSelected = date.day == diaryState.date.day &&
                    date.month == diaryState.date.month;
                return InkWell(
                  onTap: () => ref
                      .read(diaryStateNotifierProvider.notifier)
                      .setDate(date),
                  child: AnimatedContainer(
                    margin: EdgeInsets.only(right: 4.w),
                    width: 9.w,
                    duration: const Duration(milliseconds: 300),
                    padding:
                        EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 2.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(56),
                      color: isSelected ? Colors.black26 : Colors.transparent,
                    ),
                    child: Column(
                      children: [
                        Text(
                          day,
                          style: theme.textTheme.bodySmall!.copyWith(
                              color:
                                  isSelected ? Colors.white : Colors.white38),
                        ),
                        Text(
                          date.day.toString(),
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: isSelected ? Colors.white : Colors.white54,
                            fontSize: 12.sp,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
        ))
      ],
    );
  }
}
