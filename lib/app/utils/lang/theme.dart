import 'package:flutter/material.dart';

import 'colors.dart';

class CustomTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.primary,
      secondaryHeaderColor: AppColors.secondary,
      scaffoldBackgroundColor: AppColors.background,
      appBarTheme: AppBarTheme(
        color: AppColors.primary,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          color: AppColors.textColor,
          fontSize: 18.0,
        ),
        bodyMedium: TextStyle(
          color: AppColors.textColor,
          fontSize: 16.0,
        ),
        titleLarge: TextStyle(
          color: AppColors.primary,
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        onPrimary: Colors.white,
        surface: AppColors.background,
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: AppColors.accentColor,
        textTheme: ButtonTextTheme.primary,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: AppColors.primary,
      secondaryHeaderColor: AppColors.secondary,
      scaffoldBackgroundColor: Color(0xFF303030),
      appBarTheme: AppBarTheme(
        color: AppColors.primary,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        ),
        bodyMedium: TextStyle(
          color: Colors.white70,
          fontSize: 16.0,
        ),
        titleLarge: TextStyle(
          color: AppColors.primary,
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        onPrimary: Colors.white,
        surface: Color(0xFF303030),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: AppColors.accentColor,
        textTheme: ButtonTextTheme.primary,
      ),
    );
  }
}
