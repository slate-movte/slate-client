// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Themes {
  static ThemeData lite = ThemeData(
    fontFamily: 'Pretendard',
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        backgroundColor: ColorOf.point.light,
      ),
    ),
    colorScheme: ColorScheme.light(
      primary: ColorOf.point.light,
      onPrimary: ColorOf.white.light,
      secondary: ColorOf.black.light,
      onSecondary: ColorOf.white.light,
      background: ColorOf.lightGrey.light,
      onBackground: ColorOf.black.light,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xFFFFFFFF),
      foregroundColor: const Color.fromARGB(255, 78, 78, 123),
      titleTextStyle: TextStyle(
        fontFamily: 'Pretendard',
        color: const Color(0xFF000000),
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        fixedSize: Size(double.maxFinite, 48.h),
        foregroundColor: ColorOf.black.light,
        textStyle: TextStyle(
          fontFamily: 'Pretendard',
          fontSize: 18.sp,
          color: ColorOf.black.light,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        fixedSize: Size(double.maxFinite, 48.h),
        textStyle: TextStyle(
          fontFamily: 'Pretendard',
          color: ColorOf.point.light,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.36,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(4.r),
          ),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorOf.black.light,
          width: 2.0,
        ),
      ),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      suffixIconColor: const Color(0xFF282828),
      labelStyle: TextStyle(
        fontFamily: 'Pretendard',
        color: const Color(0xFF929292),
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.28,
      ),
      contentPadding: EdgeInsets.symmetric(
        vertical: 15.h,
        horizontal: 17.w,
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xFF282828),
          width: 2.0,
        ),
      ),
      disabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xFF282828),
          width: 2.0,
        ),
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xFF282828),
          width: 2.0,
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xFF282828),
          width: 2.0,
        ),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xFF282828),
          width: 2.0,
        ),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      iconSize: 30.w,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedIconTheme: IconThemeData(
        size: 36.sp,
        color: ColorOf.black.light,
      ),
      unselectedIconTheme: IconThemeData(
        size: 36.sp,
        color: ColorOf.grey.light,
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: ColorOf.lightGrey.light,
      iconTheme: IconThemeData(
        color: ColorOf.point.light,
        size: 20.sp,
      ),
      shape: const RoundedRectangleBorder(),
      labelStyle: TextStyle(
        fontFamily: 'Pretendard',
        fontSize: 12.sp,
        fontWeight: FontWeight.normal,
        color: ColorOf.grey.light,
      ),
    ),
    textTheme: TextTheme(
      headlineSmall: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
        color: ColorOf.black.light,
      ),
      titleLarge: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        color: ColorOf.black.light,
      ),
      titleMedium: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        color: ColorOf.black.light,
      ),
      titleSmall: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        color: ColorOf.black.light,
      ),
      bodyLarge: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.normal,
        color: ColorOf.black.light,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.normal,
        color: ColorOf.grey.light,
      ),
      bodySmall: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.normal,
        color: ColorOf.blue.light,
      ),
      labelLarge: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.normal,
        color: ColorOf.grey.light,
      ),
      labelMedium: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.normal,
        color: ColorOf.point.light,
      ),
      labelSmall: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.normal,
        color: ColorOf.blue.light,
      ),
    ),
    dividerColor: const Color(0xFFE4E4E4),
    scaffoldBackgroundColor: ColorOf.white.light,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: ColorOf.blue.light,
        textStyle: TextStyle(
          color: ColorOf.blue.light,
          decoration: TextDecoration.underline,
        ),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      side: BorderSide(
        width: 1.5,
        color: ColorOf.lightGrey.light,
      ),
    ),
  );
}

class SizeOf {
  static final double w_sm = 8.w;
  static final double w_md = 16.w;
  static final double w_lg = 22.w;

  static final double h_sm = 10.h;
  static final double h_md = 16.h;
  static final double h_lg = 20.h;

  static final double r = 4.r;
}

enum ColorOf {
  point(light: Color(0xFFE10011)),
  black(light: Color(0xFF282828)),
  white(light: Color(0xFFFFFFFF)),
  grey(light: Color(0xFF939393)),
  lightGrey(light: Color(0xFFEBEBEB)),
  blue(light: Color(0xFF1162FF));

  const ColorOf({required this.light});

  final Color light;
}
