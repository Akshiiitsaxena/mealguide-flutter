import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MgPrimaryButton extends StatelessWidget {
  final String text;
  final Function() onTap;
  final bool isEnabled;
  final double? height;
  final double? width;

  const MgPrimaryButton(
    this.text, {
    Key? key,
    required this.onTap,
    required this.isEnabled,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(top: 2.h),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: height ?? 7.h,
          width: width ?? 85.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isEnabled
                ? theme.primaryColor
                : theme.primaryColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(64),
            boxShadow: isEnabled
                ? [
                    BoxShadow(
                      color: theme.primaryColor.withOpacity(0.9),
                      spreadRadius: 1,
                      blurRadius: 3,
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: isEnabled ? Colors.white : theme.cardColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
