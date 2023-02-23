import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MgLoadingBlur extends StatelessWidget {
  final bool lessBlur;
  const MgLoadingBlur({Key? key, this.lessBlur = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: lessBlur ? 2 : 10,
        sigmaY: lessBlur ? 2 : 10,
      ),
      child: Container(
        height: 100.h,
        width: 100.w,
        color: lessBlur
            ? Colors.grey.withOpacity(0.4)
            : theme.scaffoldBackgroundColor.withOpacity(0.4),
        child: lessBlur
            ? Container()
            : SizedBox(
                height: 8.h,
                width: 8.h,
                child: Center(
                  child: CircularProgressIndicator(color: theme.primaryColor),
                ),
              ),
      ),
    );
  }
}
