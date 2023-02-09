import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mealguide/models/call_slot_model.dart';
import 'package:sizer/sizer.dart';

class DiaryBookedSlotpage extends HookConsumerWidget {
  final CallSlot slot;
  const DiaryBookedSlotpage({super.key, required this.slot});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dayFormatter = DateFormat('EEEE, d MMM');
    final timeFormatter = DateFormat('jm');

    final dayString = dayFormatter.format(slot.startAt);
    final timeString =
        '${timeFormatter.format(slot.startAt)} - ${timeFormatter.format(slot.endAt)}';

    final theme = Theme.of(context);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Image.asset(
            'assets/graphics/book-slot.png',
            height: 15.h,
            width: 15.h,
          ),
          SizedBox(height: 5.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'You have a call scheduled\nwith our Nutritionist on',
                  style: theme.textTheme.titleSmall,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 1.h),
                Text(
                  dayString,
                  style: theme.textTheme.titleSmall!
                      .copyWith(color: theme.indicatorColor),
                  textAlign: TextAlign.center,
                ),
                Text(
                  timeString,
                  style: theme.textTheme.titleSmall!
                      .copyWith(color: theme.indicatorColor),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const Spacer(),
          Text(
            'Check your email for more details',
            style: theme.textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4.h),
        ],
      ),
    );
  }
}
