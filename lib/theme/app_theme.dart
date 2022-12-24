import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AppTheme {
  AppTheme._();

  static final lightTheme = ThemeData(
    fontFamily: 'Quicksand',
    scaffoldBackgroundColor: Colors.grey.shade100,
    primaryColor: const Color(0xff7e79eb),
    canvasColor: Colors.grey.shade200,
    focusColor: Colors.white,
    indicatorColor: Colors.black,
    hoverColor: Colors.grey.shade700,
    textTheme: TextTheme(
      displayLarge: TextStyle(color: Colors.grey, fontSize: 12.sp),
      displayMedium: TextStyle(color: Colors.grey, fontSize: 12.sp),
      displaySmall: TextStyle(color: Colors.grey, fontSize: 12.sp),
      headlineLarge: TextStyle(color: Colors.grey, fontSize: 12.sp),
      headlineMedium: TextStyle(color: Colors.black87, fontSize: 14.sp),
      headlineSmall: TextStyle(color: Colors.black54, fontSize: 14.sp),
      titleLarge: TextStyle(
        color: Colors.grey.shade100,
        fontWeight: FontWeight.bold,
        fontSize: 16.sp,
      ),
      titleMedium: TextStyle(
        color: Colors.black87,
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: TextStyle(color: Colors.grey, fontSize: 14.sp),
      bodyLarge: TextStyle(color: Colors.grey.shade200, fontSize: 12.sp),
      bodyMedium: TextStyle(
        color: Colors.grey.shade800,
        fontWeight: FontWeight.bold,
        fontSize: 10.sp,
      ),
      bodySmall: TextStyle(
        color: Colors.grey.shade500,
        fontWeight: FontWeight.bold,
        fontSize: 10.sp,
      ),
      labelLarge: TextStyle(
        color: const Color(0xff7e79eb),
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
    fontFamily: 'Quicksand',
    scaffoldBackgroundColor: const Color(0xff121212),
    primaryColor: const Color(0xff7e79eb),
    focusColor: Colors.grey[900],
    canvasColor: Colors.grey.shade900,
    indicatorColor: Colors.white.withOpacity(0.95),
    hoverColor: Colors.grey.shade900,
    textTheme: TextTheme(
      displayLarge: TextStyle(color: Colors.grey, fontSize: 12.sp),
      displayMedium: TextStyle(color: Colors.grey, fontSize: 12.sp),
      displaySmall: TextStyle(color: Colors.grey, fontSize: 12.sp),
      headlineLarge: TextStyle(color: Colors.grey, fontSize: 12.sp),
      headlineMedium: TextStyle(color: Colors.white, fontSize: 14.sp),
      headlineSmall: TextStyle(color: Colors.white54, fontSize: 14.sp),
      titleLarge: TextStyle(
        color: Colors.grey.shade200,
        fontWeight: FontWeight.bold,
        fontSize: 16.sp,
      ),
      titleMedium: TextStyle(
        color: Colors.grey.shade200,
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: TextStyle(color: Colors.grey, fontSize: 12.sp),
      bodyLarge: TextStyle(color: Colors.grey.shade200, fontSize: 12.sp),
      bodyMedium: TextStyle(
        color: Colors.grey.shade200,
        fontWeight: FontWeight.bold,
        fontSize: 10.sp,
      ),
      bodySmall: TextStyle(
        color: Colors.grey.shade400,
        fontWeight: FontWeight.bold,
        fontSize: 10.sp,
      ),
      labelLarge: TextStyle(
        color: const Color(0xff7e79eb),
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
