import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/providers/tab_provider.dart';
import 'package:mealguide/theme/mg_shadows.dart';
import 'package:mealguide/widgets/primary_button.dart';
import 'package:sizer/sizer.dart';

class SubscribeNowBox extends ConsumerWidget {
  const SubscribeNowBox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final subtitleStyle = theme.textTheme.bodySmall!.copyWith(fontSize: 12.sp);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        boxShadow: mgShadow,
        color: theme.scaffoldBackgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Subscribe to get access to:',
            style: theme.textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
          ),
          SizedBox(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('•  ', style: subtitleStyle),
              Expanded(
                child: Text(
                  'Unlimited calls with our nutritionist.',
                  style: subtitleStyle,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('•  ', style: subtitleStyle),
              Expanded(
                child: Text(
                  'Diet plans created by the nutritionist just for you!',
                  style: subtitleStyle,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          SizedBox(
            height: 8.h,
            child: MgPrimaryButton(
              'Subscribe Now',
              onTap: () {
                ref.read(tabControllerProvider).goToTab(tab: 4);
              },
              isEnabled: true,
            ),
          ),
        ],
      ),
    );
  }
}
