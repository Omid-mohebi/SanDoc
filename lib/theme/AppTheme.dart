import 'package:expance/theme/AppFonts.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData light() {
    return ThemeData(
      brightness: Brightness.light,
      fontFamily: AppFonts.iranSans,
      appBarTheme: AppBarTheme(
        centerTitle: false,
        textTheme: TextTheme(
          headline6: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.normal,
            fontFamily: AppFonts.iranSans,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.red,
        elevation: 0.0,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: TextButton.styleFrom(),
      ),
      tabBarTheme: TabBarTheme(
        labelStyle: TextStyle(
          fontFamily: AppFonts.iranSans,
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
