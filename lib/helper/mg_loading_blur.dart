import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MgLoadingBlur extends StatelessWidget {
  const MgLoadingBlur({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Container(
        height: 100.h,
        width: 100.w,
        color: theme.scaffoldBackgroundColor.withOpacity(0.4),
        child: SizedBox(
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
