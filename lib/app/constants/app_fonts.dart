import 'package:film_flu/app/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppFonts {
  static String primaryFont = 'YsabeauInfant';
  static String secondaryFont = 'LilitaOne';
  static String tertiaryFont = 'ShadowsIntoLight';

  const AppFonts(
    primaryFont,
    secondaryFont,
    tertiaryFont,
  );
}

TextTheme createTextTheme({required bool isDarkMode}) {
  TextTheme textTheme = TextTheme(
    headlineLarge: TextStyle(
      fontFamily: AppFonts.primaryFont,
      fontSize: 40,
      color: AppColors.textPrimaryColor,
    ),
    titleLarge: TextStyle(
      fontFamily: AppFonts.primaryFont,
      fontSize: 40,
      color: isDarkMode
          ? AppColors.textPrimaryColor
          : AppColors.textSecondaryColor,
    ),
    titleMedium: TextStyle(
      fontFamily: AppFonts.primaryFont,
      fontSize: 30,
      color: AppColors.textPrimaryColor,
    ),
    titleSmall: TextStyle(
      fontFamily: AppFonts.primaryFont,
      fontSize: 16,
    ),
    displayLarge: TextStyle(
      fontFamily: AppFonts.tertiaryFont,
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: AppColors.primaryColor,
    ),
    displayMedium: TextStyle(
      fontFamily: AppFonts.primaryFont,
      fontSize: 15,
      color: !isDarkMode
          ? AppColors.textSecondaryColor
          : AppColors.textPrimaryColor,
    ),
    displaySmall: TextStyle(
      fontFamily: AppFonts.primaryFont,
      fontSize: 12,
      color: !isDarkMode
          ? AppColors.textSecondaryColor
          : AppColors.textPrimaryColor,
    ),
    bodyLarge: TextStyle(
      fontFamily: AppFonts.primaryFont,
      fontSize: 24,
    ),
    bodyMedium: TextStyle(
      fontFamily: AppFonts.primaryFont,
      fontSize: 15,
      color: AppColors.textPrimaryColor,
    ),
    bodySmall: TextStyle(
      fontFamily: AppFonts.primaryFont,
      fontSize: 15,
    ),
    labelLarge: TextStyle(
      fontSize: 12,
      color: !isDarkMode
          ? AppColors.textSecondaryColor
          : AppColors.textPrimaryColor,
    ),
    labelMedium: TextStyle(
      fontFamily: AppFonts.primaryFont,
      fontSize: 14,
      color: AppColors.textPrimaryColor,
    ),
    labelSmall: TextStyle(
      fontFamily: AppFonts.primaryFont,
      fontSize: 14,
      color: !isDarkMode
          ? AppColors.textSecondaryColor
          : AppColors.textPrimaryColor,
    ),
  );

  return textTheme;
}
