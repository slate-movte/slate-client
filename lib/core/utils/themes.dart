import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Themes {
  static ThemeData lite = ThemeData(
    // dropdownMenuTheme: DropdownMenuThemeData(
    //   textStyle: TextStyle(
    //     color: Colors.amber,
    //   ),
    //   menuStyle: MenuStyle(
    //     backgroundColor: MaterialStateProperty.all(Colors.red),
    //     elevation: MaterialStateProperty.all(0),
    //   ),
    // ),

    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        backgroundColor: ColorOf.point.light,
      ),
    ),
    colorScheme: ColorScheme.light(
      primary: ColorOf.point.light,
      onPrimary: ColorOf.white.light,
      background: ColorOf.lightGrey.light,
      onBackground: ColorOf.black.light,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFFFFFFFF),
      foregroundColor: Color(0xFF1C1C1E),
      titleTextStyle: TextStyle(
        color: Color(0xFF000000),
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        fixedSize: Size(double.maxFinite, 48.h),
        textStyle: TextStyle(
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
          color: Color(0xFF282828),
          width: 2.0,
        ),
      ),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      suffixIconColor: Color(0xFF282828),
      labelStyle: TextStyle(
        color: Color(0xFF929292),
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.28,
      ),
      contentPadding: EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 16,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xFF282828),
          width: 2.0,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xFF282828),
          width: 2.0,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xFF282828),
          width: 2.0,
        ),
      ),

      // fillColor: scheme.background,
      // focusColor: scheme.background,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xFF282828),
          width: 2.0,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xFF282828),
          width: 2.0,
        ),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      // backgroundColor: ColorOf.point.light,
      // foregroundColor: ColorOf.onPrimary.light,
      iconSize: 30.w,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedIconTheme: IconThemeData(size: 30.sp),
      unselectedIconTheme: IconThemeData(size: 30.sp),
    ),
    textTheme: TextTheme(),
    dividerColor: Color(0xFFE4E4E4),
  );
}

enum SizeOf {
  width(sm: 8, md: 16, lg: 22),
  height(sm: 12, md: 16, lg: 20),
  round(sm: 4, md: 4, lg: 4);

  const SizeOf({
    required this.sm,
    required this.md,
    required this.lg,
  });

  final double sm;
  final double md;
  final double lg;
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
