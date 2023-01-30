import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/providers/notification_provider.dart';
import 'package:mealguide/providers/profile_state_provider.dart';
import 'package:sizer/sizer.dart';

class NotificationSheet extends HookConsumerWidget {
  final NotificationType type;
  const NotificationSheet({super.key, required this.type});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final profileState = ref.read(profileStateNotiferProvider);
    final profileStateNotifier =
        ref.watch(profileStateNotiferProvider.notifier);
    final bool isEnabled;
    final TimeOfDay time;
    final String title;

    switch (type) {
      case NotificationType.breakfast:
        isEnabled = profileState.isBreakfastEnabled;
        time = profileState.breakfastTime;
        title = 'Breakfast';
        break;
      case NotificationType.lunch:
        isEnabled = profileState.isLunchEnabled;
        time = profileState.lunchTime;
        title = 'Lunch';
        break;
      case NotificationType.snacks:
        isEnabled = profileState.isSnacksEnabled;
        time = profileState.snacksTime;
        title = 'Snacks';
        break;
      case NotificationType.dinner:
        isEnabled = profileState.isDinnerEnabled;
        time = profileState.dinnerTime;
        title = 'Dinner';
        break;
      default:
        isEnabled = profileState.isBreakfastEnabled;
        time = profileState.breakfastTime;
        title = 'Breakfast';
    }

    final localEnabled = useState(isEnabled);
    final localTime = useState(time);

    return SizedBox(
      height: 32.h,
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            child: Text(
              '$title Notifications',
              style: theme.textTheme.titleMedium,
            ),
          ),
          SizedBox(height: 2.h),
          InkWell(
            onTap: () {
              localEnabled.value
                  ? profileStateNotifier.cancelNotification(type)
                  : profileStateNotifier.setNotification(type, time);
              localEnabled.value = !localEnabled.value;
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
              decoration: BoxDecoration(
                color: theme.canvasColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Text('Enable notifications',
                      style: theme.textTheme.bodyMedium),
                  const Spacer(),
                  Container(
                    height: 2.5.h,
                    width: 2.5.h,
                    padding: const EdgeInsets.all(2.5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: theme.primaryColor, width: 2),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: localEnabled.value
                            ? theme.primaryColor
                            : Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 2.h),
          InkWell(
            child: AnimatedContainer(
              width: 100.w,
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
              decoration: BoxDecoration(
                color: theme.canvasColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: localEnabled.value
                  ? Row(
                      children: [
                        Text('Time of $type notifications',
                            style: theme.textTheme.bodyMedium),
                        const Spacer(),
                        Text(
                          localTime.value.format(context),
                          style: theme.textTheme.bodyMedium!
                              .copyWith(fontSize: 12.sp),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
                  : Text(
                      'Please enable notifications before setting a time',
                      style: theme.textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ),
            ),
          ),
          SizedBox(height: 2.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Text(
              'We will send you a notification just in time, so that you can prepare and cook your meal enjoy it on time',
              style: theme.textTheme.bodySmall!.copyWith(fontSize: 8.sp),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
