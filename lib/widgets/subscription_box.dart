import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SubcriptionBox extends StatelessWidget {
  final String oldPrice;
  final String newPrice;
  final String duration;
  final bool isSelected;
  final Function() onTap;

  const SubcriptionBox({
    super.key,
    required this.oldPrice,
    required this.newPrice,
    required this.duration,
    required this.isSelected,
    required this.onTap,
  });

  final double scale = 1;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    double newScale = scale;
    if (isSelected) {
      newScale = scale * 1.1;
    }

    return AnimatedScale(
      scale: newScale,
      duration: const Duration(milliseconds: 200),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 27.w,
          height: 27.w,
          padding: EdgeInsets.symmetric(horizontal: 1.5.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
                color: isSelected ? theme.primaryColor : Colors.transparent,
                width: 2),
            color: theme.canvasColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                oldPrice,
                style: theme.textTheme.bodySmall!
                    .copyWith(fontSize: 8.sp)
                    .copyWith(decoration: TextDecoration.lineThrough),
              ),
              Text(
                newPrice,
                style: theme.textTheme.labelLarge!
                    .copyWith(fontWeight: FontWeight.bold, fontSize: 11.sp),
              ),
              Text(
                duration.toUpperCase(),
                style: theme.textTheme.bodySmall!.copyWith(
                    color: theme.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 8.sp),
              )
            ],
          ),
        ),
      ),
    );
  }
}
