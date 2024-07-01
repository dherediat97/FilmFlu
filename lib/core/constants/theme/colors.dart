import 'package:flutter/material.dart';

const primaryColor = Color(0xFFC7CD18);
const secondaryColor = Color(0x00010f0f);
const backgroundColor = Color(0x00010f0f);

final primaryMaterialColor = MaterialColor(primaryColor.value, <int, Color>{
  50: primaryColor.withOpacity(0.1),
  100: primaryColor.withOpacity(0.2),
  200: primaryColor.withOpacity(0.3),
  300: primaryColor.withOpacity(0.4),
  400: primaryColor.withOpacity(0.5),
  500: primaryColor.withOpacity(0.6),
  600: primaryColor.withOpacity(0.7),
  700: primaryColor.withOpacity(0.8),
  800: primaryColor.withOpacity(0.9),
  900: primaryColor.withOpacity(1.0),
});

final secondaryMaterialColor = MaterialColor(secondaryColor.value, <int, Color>{
  50: secondaryColor.withOpacity(0.1),
  100: secondaryColor.withOpacity(0.2),
  200: secondaryColor.withOpacity(0.3),
  300: secondaryColor.withOpacity(0.4),
  400: secondaryColor.withOpacity(0.5),
  500: secondaryColor.withOpacity(0.6),
  600: secondaryColor.withOpacity(0.7),
  700: secondaryColor.withOpacity(0.8),
  800: secondaryColor.withOpacity(0.9),
  900: secondaryColor.withOpacity(1.0),
});
