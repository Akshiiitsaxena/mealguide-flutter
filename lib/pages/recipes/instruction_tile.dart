import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sizer/sizer.dart';

class InstructionTile extends StatelessWidget {
  final int step;
  final String content;

  const InstructionTile({required this.content, required this.step, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.5, horizontal: 3.w),
      padding: EdgeInsets.symmetric(vertical: 1.25.h, horizontal: 3.w),
      decoration: BoxDecoration(
        color: step.isEven
            ? theme.primaryColor.withOpacity(0.1)
            : theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${step + 1}. ',
            style: theme.textTheme.bodySmall!.copyWith(
                color: theme.primaryColor, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 1.w),
          Expanded(
            child: Text(
              content,
              style: theme.textTheme.bodySmall,
            ),
          )
        ],
      ),
    );
  }
}
