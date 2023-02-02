import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/providers/bottom_bar_provider.dart';
import 'package:mealguide/providers/theme_provider.dart';
import 'package:sizer/sizer.dart';

class MgTabIcon extends HookConsumerWidget {
  final String title;
  final String image;
  final int tab;

  const MgTabIcon({
    super.key,
    required this.image,
    required this.title,
    required this.tab,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final bottomBarState = ref.watch(bottomBarStateNotifierProvider);

    int selectedTab = bottomBarState.selectedTab;

    final darkDisabledColor = Colors.grey.shade700;
    final lightDisabledColor = Colors.grey.shade500;
    final enabledColor = theme.primaryColor;

    final darkTextTheme = theme.textTheme.bodySmall!
        .copyWith(fontSize: 8.sp, color: darkDisabledColor);
    final lightTextTheme = theme.textTheme.bodySmall!
        .copyWith(fontSize: 8.sp, color: lightDisabledColor);
    final enabledTextTheme = theme.textTheme.bodySmall!
        .copyWith(fontSize: 8.sp, color: enabledColor);

    bool isEnabled = tab == selectedTab;

    bool isDarkTheme =
        ref.watch(themeStateNotifierProvider).mode == ThemeMode.dark;

    return Material(
      child: Column(
        children: [
          Image.asset(
            image,
            height: 3.5.h,
            width: 3.5.h,
            color: isEnabled
                ? enabledColor
                : isDarkTheme
                    ? darkDisabledColor
                    : lightDisabledColor,
          ),
          SizedBox(height: .3.h),
          Text(
            title,
            style: isEnabled
                ? enabledTextTheme
                : isDarkTheme
                    ? darkTextTheme
                    : lightTextTheme,
          )
        ],
      ),
    );
  }
}
