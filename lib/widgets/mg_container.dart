import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MgContainer extends StatelessWidget {
  final Widget child;
  final double? height;
  final double? width;
  final Color? color;
  final BorderRadius? borderRadius;
  final Border? border;
  final EdgeInsets? padding;

  const MgContainer({
    super.key,
    required this.child,
    this.height,
    this.width,
    this.color,
    this.border,
    this.borderRadius,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
      height: height ?? 5.h,
      width: width ?? 80.w,
      decoration: BoxDecoration(
        color: color ?? Colors.grey.shade900,
        borderRadius: borderRadius ?? BorderRadius.circular(16),
        border: border,
      ),
      child: child,
    );
  }
}
