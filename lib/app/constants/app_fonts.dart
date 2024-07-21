import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFonts {
  static String primaryFont = 'Ysabeau';
  static String secondaryFont = 'LilitaOne';
  static String tertiaryFont = 'Shadows Into Light';

  const AppFonts(
    primaryFont,
    secondaryFont,
    tertiaryFont,
  );
}

TextTheme createTextTheme(
    BuildContext context, String bodyFontString, String displayFontString) {
  TextTheme baseTextTheme = Theme.of(context).textTheme;

  TextTheme titleTextTheme =
      GoogleFonts.getTextTheme(bodyFontString, baseTextTheme);

  TextTheme bodyTextTheme =
      GoogleFonts.getTextTheme(bodyFontString, baseTextTheme);

  TextTheme displayTextTheme =
      GoogleFonts.getTextTheme(displayFontString, baseTextTheme);

  TextTheme textTheme = displayTextTheme.copyWith(
    displayLarge: displayTextTheme.displayLarge?.copyWith(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: Theme.of(context).colorScheme.primary,
    ),
    displayMedium: displayTextTheme.displayMedium?.copyWith(
      fontSize: 15,
      color: Theme.of(context).colorScheme.secondary,
    ),
    displaySmall: displayTextTheme.displaySmall?.copyWith(
      fontSize: 12,
      color: Theme.of(context).colorScheme.secondary,
    ),
    bodyLarge: bodyTextTheme.bodyLarge?.copyWith(
      fontSize: 24,
      color: Theme.of(context).colorScheme.secondary,
    ),
    bodyMedium: bodyTextTheme.bodyMedium?.copyWith(
      fontSize: 15,
      color: Theme.of(context).colorScheme.secondary,
    ),
    bodySmall: bodyTextTheme.bodySmall?.copyWith(
      fontSize: 15,
      color: Theme.of(context).colorScheme.secondary,
    ),
    labelLarge: bodyTextTheme.labelLarge?.copyWith(
      fontSize: 12,
      color: Theme.of(context).colorScheme.secondary,
    ),
    labelMedium: bodyTextTheme.labelMedium?.copyWith(
      fontSize: 14,
      color: Theme.of(context).colorScheme.secondary,
    ),
    labelSmall: bodyTextTheme.labelSmall?.copyWith(
      fontSize: 14,
      color: Theme.of(context).colorScheme.secondary,
    ),
    titleLarge: titleTextTheme.titleLarge?.copyWith(
      fontSize: 40,
      color: Theme.of(context).colorScheme.secondary,
    ),
    titleMedium: titleTextTheme.titleMedium?.copyWith(
      fontSize: 14,
      color: Theme.of(context).colorScheme.secondary,
    ),
    titleSmall: titleTextTheme.titleSmall?.copyWith(
      fontSize: 16,
      color: Theme.of(context).colorScheme.secondary,
    ),
  );
  return textTheme;
}
