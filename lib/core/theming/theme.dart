import 'package:flutter/material.dart';
import 'color_managers.dart';

// Light Theme Configuration
final ThemeData lightTheme = ThemeData(
  colorScheme: lightColorScheme, // Light color scheme
  brightness: Brightness.light, // Light mode brightness
  scaffoldBackgroundColor: lightColorScheme.surface, // Background color
  appBarTheme: AppBarTheme(
    backgroundColor: lightColorScheme.primary, // AppBar background color
    foregroundColor: lightColorScheme.onPrimary, // AppBar text/icon color
    elevation: 0, // Remove AppBar shadow
    iconTheme: IconThemeData(color: lightColorScheme.onPrimary), // Icon color
    titleTextStyle: TextStyle(
      color: lightColorScheme.onPrimary, // Title text color
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: lightColorScheme.onSurface), // Body text
    bodyMedium: TextStyle(color: lightColorScheme.onSurface),
    titleLarge: TextStyle(color: lightColorScheme.onSurface),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: lightColorScheme.primary, // Button background color
      foregroundColor: lightColorScheme.onPrimary, // Button text color
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)), // Button shape
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: lightColorScheme.secondary, // FAB background color
    foregroundColor: lightColorScheme.onSecondary, // FAB icon color
  ),
  cardColor: lightColorScheme.surface, // Card background color
  dividerColor: Colors.grey.shade300, // Divider color
  iconTheme: IconThemeData(color: lightColorScheme.onSurface), // Icon color
  useMaterial3: true, // Enable Material 3
);

// Dark Theme Configuration
final ThemeData darkTheme = ThemeData(
  colorScheme: darkColorScheme, // Dark color scheme
  brightness: Brightness.dark, // Dark mode brightness
  scaffoldBackgroundColor: darkColorScheme.surface, // Background color
  appBarTheme: AppBarTheme(
    backgroundColor: darkColorScheme.primary, // AppBar background color
    foregroundColor: darkColorScheme.onPrimary, // AppBar text/icon color
    elevation: 0, // Remove AppBar shadow
    iconTheme: IconThemeData(color: darkColorScheme.onPrimary), // Icon color
    titleTextStyle: TextStyle(
      color: darkColorScheme.onPrimary, // Title text color
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: darkColorScheme.onSurface), // Body text
    bodyMedium: TextStyle(color: darkColorScheme.onSurface),
    titleLarge: TextStyle(color: darkColorScheme.onSurface),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: darkColorScheme.primary, // Button background color
      foregroundColor: darkColorScheme.onPrimary, // Button text color
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)), // Button shape
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: darkColorScheme.secondary, // FAB background color
    foregroundColor: darkColorScheme.onSecondary, // FAB icon color
  ),
  cardColor: darkColorScheme.surface, // Card background color
  dividerColor: Colors.grey.shade800, // Divider color
  iconTheme: IconThemeData(color: darkColorScheme.onSurface), // Icon color
  useMaterial3: true, // Enable Material 3
);
