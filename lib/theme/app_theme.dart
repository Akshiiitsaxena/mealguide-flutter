import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AppTheme {
  AppTheme._();

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade100,
    primaryColor: Colors.deepPurpleAccent.shade200,
    focusColor: Colors.white,
    textTheme: TextTheme(
      displayLarge: TextStyle(color: Colors.grey, fontSize: 12.sp),
      displayMedium: TextStyle(color: Colors.grey, fontSize: 12.sp),
      displaySmall: TextStyle(color: Colors.grey, fontSize: 12.sp),
      headlineLarge: TextStyle(color: Colors.grey, fontSize: 12.sp),
      headlineMedium: TextStyle(color: Colors.grey, fontSize: 12.sp),
      headlineSmall: TextStyle(color: Colors.grey, fontSize: 12.sp),
      titleLarge: TextStyle(
          color: Colors.grey.shade400,
          fontSize: 16.sp,
          fontWeight: FontWeight.bold),
      titleMedium: TextStyle(
        color: Colors.black87,
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: TextStyle(color: Colors.grey, fontSize: 12.sp),
      bodyLarge: TextStyle(color: Colors.black87, fontSize: 24.sp),
      bodyMedium: TextStyle(color: Colors.grey, fontSize: 12.sp),
      bodySmall: TextStyle(
        color: Colors.grey.shade800,
        fontWeight: FontWeight.bold,
        fontSize: 10.sp,
      ),
      labelLarge: TextStyle(
        color: Colors.deepPurpleAccent.shade200,
        fontWeight: FontWeight.bold,
        fontSize: 10.sp,
      ),
      labelMedium: TextStyle(
          color: Colors.black87, fontSize: 8.sp, fontWeight: FontWeight.bold),
      labelSmall: TextStyle(color: Colors.grey, fontSize: 12.sp),
    ),
    cardColor: Colors.white,
  );

  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xff121212),
    primaryColor: Colors.deepPurpleAccent.shade200,
    focusColor: Colors.grey[900],
    textTheme: TextTheme(
      displayLarge: TextStyle(color: Colors.grey, fontSize: 12.sp),
      displayMedium: TextStyle(color: Colors.grey, fontSize: 12.sp),
      displaySmall: TextStyle(color: Colors.grey, fontSize: 12.sp),
      headlineLarge: TextStyle(color: Colors.grey, fontSize: 12.sp),
      headlineMedium: TextStyle(color: Colors.grey, fontSize: 12.sp),
      headlineSmall: TextStyle(color: Colors.grey, fontSize: 12.sp),
      titleLarge: TextStyle(
          color: Colors.grey.shade400,
          fontSize: 16.sp,
          fontWeight: FontWeight.bold),
      titleMedium: TextStyle(
        color: Colors.grey.shade200,
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: TextStyle(color: Colors.grey, fontSize: 12.sp),
      bodyLarge: TextStyle(color: Colors.black87, fontSize: 24.sp),
      bodyMedium: TextStyle(color: Colors.grey, fontSize: 12.sp),
      bodySmall: TextStyle(
        color: Colors.grey.shade200,
        fontWeight: FontWeight.bold,
        fontSize: 10.sp,
      ),
      labelLarge: TextStyle(
        color: Colors.deepPurpleAccent.shade200,
        fontWeight: FontWeight.bold,
        fontSize: 10.sp,
      ),
      labelMedium: TextStyle(color: Colors.grey.shade200, fontSize: 8.sp),
      labelSmall: TextStyle(color: Colors.grey, fontSize: 12.sp),
    ),
    cardColor: Colors.white.withOpacity(0.05),
    dividerColor: Colors.grey.shade800,
  );
}
