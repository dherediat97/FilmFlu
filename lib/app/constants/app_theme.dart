import 'package:film_flu/app/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  final TextTheme textTheme;

  const AppTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff650009),
      surfaceTint: Color(0xffb32729),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff9f171e),
      onPrimaryContainer: Color(0xffffedeb),
      secondary: Color(0xff5d5f5f),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffcbcccc),
      onSecondaryContainer: Color(0xff383a3a),
      tertiary: Color(0xff650009),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff9f171e),
      onTertiaryContainer: Color(0xffffedeb),
      error: Color(0xff9e4300),
      onError: Color(0xffffffff),
      errorContainer: Color(0xfffe7314),
      onErrorContainer: Color(0xff1e0700),
      surface: AppColors.backgroundColorLight,
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff4c4546),
      outline: Color(0xff7e7576),
      outlineVariant: Color(0xffcfc4c5),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff313030),
      inversePrimary: Color(0xffffb3ad),
      primaryFixed: Color(0xffffdad7),
      onPrimaryFixed: Color(0xff410004),
      primaryFixedDim: Color(0xffffb3ad),
      onPrimaryFixedVariant: Color(0xff910815),
      secondaryFixed: Color(0xffe2e2e2),
      onSecondaryFixed: Color(0xff1a1c1c),
      secondaryFixedDim: Color(0xffc6c7c7),
      onSecondaryFixedVariant: Color(0xff454747),
      tertiaryFixed: Color(0xffffdad7),
      onTertiaryFixed: Color(0xff410004),
      tertiaryFixedDim: Color(0xffffb3ad),
      onTertiaryFixedVariant: Color(0xff910815),
      surfaceDim: Color(0xffddd9d9),
      surfaceBright: Color(0xfffcf8f8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xff910815),
      surfaceContainer: Color(0xfff1edec),
      surfaceContainerHigh: Color(0xffebe7e7),
      surfaceContainerHighest: Color(0xffe5e2e1),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFFB10112),
      surfaceTint: Color(0xffffb3ad),
      onPrimary: Color(0xFFB10112),
      primaryContainer: Color(0xff79000d),
      onPrimaryContainer: Color(0xffffbab4),
      secondary: Color(0xffe8e9e9),
      onSecondary: Color(0xff2e3131),
      secondaryContainer: Color(0xffbebfbf),
      onSecondaryContainer: Color(0xff2f3131),
      tertiary: Color(0xffffb3ad),
      onTertiary: Color(0xff68000a),
      tertiaryContainer: Color(0xff79000d),
      onTertiaryContainer: Color(0xffffbab4),
      error: Color(0xffffb691),
      onError: Color(0xff552100),
      errorContainer: Color(0xffc15300),
      onErrorContainer: Color(0xffffffff),
      surface: AppColors.backgroundColorDark,
      onSurface: Color(0xffe5e2e1),
      onSurfaceVariant: Color(0xffcfc4c5),
      outline: Color(0xff988e90),
      outlineVariant: Color(0xff4c4546),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe5e2e1),
      inversePrimary: Color(0xffb32729),
      primaryFixed: Color(0xffffdad7),
      onPrimaryFixed: Color(0xff410004),
      primaryFixedDim: Color(0xffffb3ad),
      onPrimaryFixedVariant: Color(0xff910815),
      secondaryFixed: Color(0xffe2e2e2),
      onSecondaryFixed: Color(0xff1a1c1c),
      secondaryFixedDim: Color(0xffc6c7c7),
      onSecondaryFixedVariant: Color(0xff454747),
      tertiaryFixed: Color(0xffffdad7),
      onTertiaryFixed: Color(0xff410004),
      tertiaryFixedDim: Color(0xffffb3ad),
      onTertiaryFixedVariant: Color(0xff910815),
      surfaceDim: Color(0xff141313),
      surfaceBright: Color(0xff3a3939),
      surfaceContainerLowest: Color(0xff0e0e0e),
      surfaceContainerLow: Color(0xff1c1b1b),
      surfaceContainer: Color(0xff201f1f),
      surfaceContainerHigh: Color(0xff2a2a2a),
      surfaceContainerHighest: Color(0xff353434),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    appBarTheme: AppBarTheme(color: colorScheme.primary, toolbarHeight: 75),
    bottomAppBarTheme: BottomAppBarTheme(
      color: colorScheme.primary,
      height: 50,
    ),
    textTheme: textTheme,
    iconTheme: const IconThemeData(color: AppColors.backgroundColorLight),
    iconButtonTheme: const IconButtonThemeData(
      style: ButtonStyle(
        iconColor: WidgetStatePropertyAll(AppColors.backgroundColorLight),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: colorScheme.primary,
      foregroundColor: AppColors.backgroundColorLight,
    ),
    scaffoldBackgroundColor: colorScheme.surface,
    canvasColor: colorScheme.surface,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: colorScheme.primary,
      selectedItemColor: AppColors.textPrimaryColor,
    ),
    tabBarTheme: TabBarTheme(
      indicatorColor: colorScheme.primary,
      labelColor: colorScheme.secondary,
      splashFactory: NoSplash.splashFactory,
      labelPadding: EdgeInsets.zero,
      unselectedLabelColor: colorScheme.secondary,
      indicatorSize: TabBarIndicatorSize.label,
    ),
  );
}
