import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/providers/theme_provider.dart';
import 'package:sizer/sizer.dart';

class MgAppBar extends ConsumerWidget with PreferredSizeWidget {
  final Widget child;
  final bool isEmpty;

  const MgAppBar({super.key, required this.child, this.isEmpty = false});

  @override
  PreferredSize build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    Color bgColor =
        ref.watch(themeStateNotifierProvider).mode == ThemeMode.light
            ? theme.primaryColor
            : const Color(0xff393868);

    return PreferredSize(
      preferredSize: Size.fromHeight(11.h),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
            color: bgColor,
            boxShadow: [
              BoxShadow(
                color: bgColor,
                blurRadius: 10,
                spreadRadius: 1,
              )
            ]),
        child: SafeArea(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(isEmpty ? 2.w : 6.w, 1.h, 6.w, 1.h),
            child: child,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(11.h);
}
