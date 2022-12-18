import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/providers/theme_provider.dart';
import 'package:sizer/sizer.dart';

class UpgradeInfoTile extends HookConsumerWidget {
  final IconData icon;
  final String title;
  final String content;

  const UpgradeInfoTile({
    super.key,
    required this.content,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 6.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(0.7.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(56),
              color:
                  ref.watch(themeStateNotifierProvider).mode == ThemeMode.light
                      ? theme.primaryColor
                      : const Color(0xff393868),
            ),
            child: Icon(icon, color: Colors.white, size: 18.sp),
          ),
          SizedBox(width: 4.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style:
                        theme.textTheme.bodyMedium!.copyWith(fontSize: 12.sp)),
                Text(content, style: theme.textTheme.bodySmall),
              ],
            ),
          )
        ],
      ),
    );
  }
}
