import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class UpgradeButton extends StatelessWidget {
  final Widget child;
  final Function() onTap;

  const UpgradeButton({super.key, required this.child, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
        decoration: BoxDecoration(
          border: Border.all(color: theme.primaryColor),
          borderRadius: BorderRadius.circular(56),
          color: theme.canvasColor,
        ),
        height: 6.h,
        width: 100.w,
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}
