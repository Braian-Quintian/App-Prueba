import 'package:flutter/material.dart';

const Color _customColor = Color(0xFF000000);
const Color _customColor2 = Color(0xFFF84A18);

const List<Color> _colorThemes = [
  _customColor,
  _customColor2,
];

class AppTheme {
  ThemeData theme() {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: _colorThemes[1],
    );
  }
}

