import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AppTheme {
  AppTheme._();

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade300,
    textTheme: TextTheme(
      displayLarge: TextStyle(color: Colors.grey, fontSize: 12.sp),
      displayMedium: TextStyle(color: Colors.grey, fontSize: 12.sp),
      displaySmall: TextStyle(color: Colors.grey, fontSize: 12.sp),
      headlineLarge: TextStyle(color: Colors.grey, fontSize: 12.sp),
      headlineMedium: TextStyle(color: Colors.grey, fontSize: 12.sp),
      headlineSmall: TextStyle(color: Colors.grey, fontSize: 12.sp),
      titleLarge: TextStyle(color: Colors.grey.shade400, fontSize: 12.sp),
      titleMedium: TextStyle(color: Colors.grey, fontSize: 12.sp),
      titleSmall: TextStyle(color: Colors.grey, fontSize: 12.sp),
      bodyLarge: TextStyle(color: Colors.black87, fontSize: 24.sp),
      bodyMedium: TextStyle(color: Colors.grey, fontSize: 12.sp),
      bodySmall: TextStyle(color: Colors.grey, fontSize: 12.sp),
      labelMedium: TextStyle(color: Colors.grey, fontSize: 12.sp),
      labelLarge: TextStyle(color: Colors.grey, fontSize: 12.sp),
      labelSmall: TextStyle(color: Colors.grey, fontSize: 12.sp),
    ),
  );

  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black87,
    textTheme: TextTheme(
      displayLarge: TextStyle(color: Colors.grey, fontSize: 12.sp),
      displayMedium: TextStyle(color: Colors.grey, fontSize: 12.sp),
      displaySmall: TextStyle(color: Colors.grey, fontSize: 12.sp),
      headlineLarge: TextStyle(color: Colors.grey, fontSize: 12.sp),
      headlineMedium: TextStyle(color: Colors.grey, fontSize: 12.sp),
      headlineSmall: TextStyle(color: Colors.grey, fontSize: 12.sp),
      titleLarge: TextStyle(color: Colors.grey.shade400, fontSize: 12.sp),
      titleMedium: TextStyle(color: Colors.grey, fontSize: 12.sp),
      titleSmall: TextStyle(color: Colors.grey, fontSize: 12.sp),
      bodyLarge: TextStyle(color: Colors.black87, fontSize: 24.sp),
      bodyMedium: TextStyle(color: Colors.grey, fontSize: 12.sp),
      bodySmall: TextStyle(color: Colors.grey, fontSize: 12.sp),
      labelMedium: TextStyle(color: Colors.grey, fontSize: 12.sp),
      labelLarge: TextStyle(color: Colors.grey, fontSize: 12.sp),
      labelSmall: TextStyle(color: Colors.grey, fontSize: 12.sp),
    ),
  );
}
