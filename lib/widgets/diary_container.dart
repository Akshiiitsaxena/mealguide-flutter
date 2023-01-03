import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DiaryContainer extends StatelessWidget {
  final Widget child;
  final double? height;
  final double? width;

  const DiaryContainer({
    super.key,
    required this.child,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 4.w),
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: theme.canvasColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: child,
    );
  }
}
