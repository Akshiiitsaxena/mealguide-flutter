import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class InfoBox extends StatelessWidget {
  final String heading;
  final String title;
  final String trailing;

  const InfoBox({
    required this.heading,
    required this.title,
    required this.trailing,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme.labelLarge!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading.toUpperCase(),
          style: textTheme.copyWith(
            color: theme.primaryColor.withOpacity(0.5),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              title,
              style: textTheme.copyWith(
                fontSize: 16.sp,
              ),
            ),
            SizedBox(width: 0.5.w),
            Padding(
              padding: EdgeInsets.only(bottom: 0.1.h),
              child: Text(
                trailing.toUpperCase(),
                style: textTheme,
              ),
            )
          ],
        )
      ],
    );
  }
}
