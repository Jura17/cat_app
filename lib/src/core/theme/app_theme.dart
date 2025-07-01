import 'package:firebase_test_app/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get appTheme => ThemeData.dark().copyWith(
        scaffoldBackgroundColor: AppColors.backdrop,
        appBarTheme: AppBarTheme(color: AppColors.backdrop),
        inputDecorationTheme: InputDecorationTheme(
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.primary, width: 3)),
            hintStyle: TextStyle(color: Colors.white)),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all(AppColors.primary),
            textStyle: WidgetStateProperty.all(
              TextStyle(fontSize: 18),
            ),
          ),
        ),
      );
}
