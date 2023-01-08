import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/providers/theme_provider.dart';
import 'package:sizer/sizer.dart';

class DiaryContainer extends ConsumerWidget {
  final Widget child;
  final double? height;
  final double? width;
  final bool enabled;

  const DiaryContainer({
    super.key,
    required this.child,
    this.height,
    this.width,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final themeMode = ref.watch(themeStateNotifierProvider);

    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 4.w),
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: themeMode.mode == ThemeMode.light
                ? Colors.white
                : theme.canvasColor,
            borderRadius: BorderRadius.circular(24),
          ),
          child: child,
        ),
        if (enabled)
          Container()
        else
          Positioned.fill(
            child: Container(
              color: theme.scaffoldBackgroundColor.withOpacity(0.65),
            ),
          ),
      ],
    );
  }
}
