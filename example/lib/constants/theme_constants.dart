import 'package:flutter/material.dart';

/// Tema sabitleri
class ThemeConstants {
  /// Factory constructor
  factory ThemeConstants() => _instance;

  /// Internal constructor
  ThemeConstants._internal();

  /// Singleton instance
  static final ThemeConstants _instance = ThemeConstants._internal();

  /// Açık tema
  static final ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.light,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    useMaterial3: true,
  );

  /// Koyu tema
  static final ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.dark,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    useMaterial3: true,
  );
}
