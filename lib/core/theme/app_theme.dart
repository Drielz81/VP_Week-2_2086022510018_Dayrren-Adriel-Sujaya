import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme._();

  static const Color seedColor = Color(0xFF00A86B);
  static const Color gradientColor1 = Color(0xFF007660);
  static const Color transparentColor = Colors.transparent;
  static const Color defaultColor = Colors.grey;
  static const Color blackColor = Colors.black87; 
  static const Color whiteColor = Colors.white; 

  static dynamic _border([Color color = defaultColor, double width = 1]) =>
      OutlineInputBorder(
        borderSide: BorderSide(color: color, width: width),
        borderRadius: BorderRadius.circular(12),
      );

  static const RoundedRectangleBorder _shape = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
  );

  static ThemeData get light => _build(Brightness.light);
  static ThemeData get dark => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: brightness,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      cardTheme: const CardThemeData(shape: _shape, margin: EdgeInsets.zero),
      chipTheme: const ChipThemeData(shape: _shape),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: _border(),
        focusedBorder: _border(seedColor, 3.0),
        errorBorder: _border(),
        focusedErrorBorder: _border(seedColor, 3.0),
      ),
    );
  }
}
