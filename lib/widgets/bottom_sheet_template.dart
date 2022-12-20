import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

showSheet(BuildContext context, {required Widget child, double? height}) async {
  final theme = Theme.of(context);

  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
    ),
    builder: (context) {
      return Container(
        constraints: height != null ? BoxConstraints(maxHeight: height) : null,
        padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: theme.hoverColor.withOpacity(0.1),
              ),
              height: 0.5.h,
              width: 20.w,
            ),
            SizedBox(height: 2.h),
            child,
          ],
        ),
      );
    },
  );
}
