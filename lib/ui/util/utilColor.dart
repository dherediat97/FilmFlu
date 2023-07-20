// Calculate dominant color from ImageProvider

import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

Future<Color> getImagePalette(ImageProvider imageProvider) async {
  final PaletteGenerator paletteGenerator =
      await PaletteGenerator.fromImageProvider(imageProvider);
  if (paletteGenerator.colors.elementAt(3) != Colors.black)
    return paletteGenerator.colors.elementAt(3);
  else
    return paletteGenerator.colors.elementAt(4);
}
