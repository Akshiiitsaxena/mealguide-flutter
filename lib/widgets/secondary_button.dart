import 'package:flutter/material.dart';
import 'package:mealguide/theme/mg_shadows.dart';
import 'package:sizer/sizer.dart';

class MgSecondaryButton extends StatelessWidget {
  final String text;
  final Function() onTap;
  final double? height;
  final double? width;

  const MgSecondaryButton(
    this.text, {
    Key? key,
    required this.onTap,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: height,
        width: width,
        padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.w),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(56),
            boxShadow: mgShadow),
        child: Text(
          text,
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ),
    );
  }
}
