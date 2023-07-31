import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slate/presentation/views/main_view.dart';

void main() {
  runApp(const Slate());
}

class Slate extends StatelessWidget {
  const Slate({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.light(
            primary: Color(0xFFEB4E32),
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
                color: Colors.white,
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
            border: OutlineInputBorder(),
            prefixIconColor: Color(0xFF929292),
            labelStyle: TextStyle(
              color: Color(0xFF929292),
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.28,
            ),

            // contentPadding: EdgeInsets.symmetric(
            //     // vertical: SizeTheme.h_sm,
            //     // horizontal: SizeTheme.w_md,
            //     ),
            // focusedErrorBorder: OutlineInputBorder(
            //   borderSide: BorderSide(
            //       // color: scheme.background,
            //       ),
            // ),
            // disabledBorder: OutlineInputBorder(
            //   borderSide: BorderSide(
            //       // color: scheme.background,
            //       ),
            // ),
            // errorBorder: OutlineInputBorder(
            //   borderSide: BorderSide(
            //       // color: scheme.background,
            //       ),
            // ),
            // // fillColor: scheme.background,
            // // focusColor: scheme.background,
            // focusedBorder: OutlineInputBorder(
            //   borderSide: BorderSide(
            //       // color: scheme.background,
            //       ),
            // ),
            // enabledBorder: OutlineInputBorder(
            //   borderSide: BorderSide(
            //       // color: scheme.background,
            //       ),
            // ),
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Color(0xFFEB4E32),
            foregroundColor: Color(0xFFFFFFFF),
            iconSize: 30.w,
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedIconTheme: IconThemeData(size: 30.sp),
            unselectedIconTheme: IconThemeData(size: 30.sp),
          ),
          textTheme: TextTheme(),
        ),
        home: MainView(),
      ),
    );
  }
}
