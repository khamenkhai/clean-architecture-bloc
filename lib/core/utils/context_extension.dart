import 'package:flutter/material.dart';

extension ThemeContextExtension on BuildContext {
  // Colors
  Color get primaryColor => Theme.of(this).colorScheme.primary;
  Color get onPrimary => Theme.of(this).colorScheme.onPrimary;
  Color get secondary => Theme.of(this).colorScheme.secondary;
  Color get onSecondary => Theme.of(this).colorScheme.onSecondary;
  Color get error => Theme.of(this).colorScheme.error;
  Color get onError => Theme.of(this).colorScheme.onError;
  Color get surface => Theme.of(this).colorScheme.surface;
  Color get onSurface => Theme.of(this).colorScheme.onSurface;
  Color get onSurfaceVariant => Theme.of(this).colorScheme.onSurfaceVariant;
  Color get tertiary => Theme.of(this).colorScheme.tertiary;

  // Theme data shortcuts
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
  Brightness get brightness => Theme.of(this).brightness;

  // ========== AppTextStyles Access ==========

  // Small font style with theme color fallback
  TextStyle verySmall({Color? color, FontWeight? fontWeight}) =>
      TextStyle(fontSize: 12, fontWeight: fontWeight, color: color);
  // Small font style with theme color fallback
  TextStyle smallFont({Color? color, FontWeight? fontWeight}) => TextStyle(
    fontSize: 14,
    fontWeight: fontWeight ?? FontWeight.w500,
    color: color,
  );

  // Normal font style with theme color fallback
  TextStyle normalFont({Color? color, FontWeight? fontWeight}) =>
      TextStyle(fontSize: 16, fontWeight: fontWeight, color: color);

  // Subtitle font style with theme color fallback
  TextStyle subTitle({Color? color, FontWeight? fontWeight}) => TextStyle(
    fontSize: 20,
    fontWeight: fontWeight ?? FontWeight.bold,
    color: color,
  );

  // Heading font style with theme color fallback
  TextStyle heading({Color? color, FontWeight? fontWeight}) => TextStyle(
    fontSize: 24,
    fontWeight: fontWeight ?? FontWeight.bold,
    color: color,
  );

  // Large text style with theme color fallback
  TextStyle largeText({Color? color}) =>
      TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: color);

  // Button text style with theme color fallback
  TextStyle buttonText({Color? color}) =>
      TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: color);

  // ========== Combined Utilities ==========

  // Responsive text size multiplier
  // ignore: deprecated_member_use
  double get textScaleFactor => MediaQuery.of(this).textScaleFactor;

  // Adaptive text style that scales with system settings
  TextStyle adaptiveTextStyle(TextStyle style) =>
      style.copyWith(fontSize: style.fontSize! * textScaleFactor);

  /// Pushes a new page with a fade transition
  Future<T?> push<T>(
    Widget page, {
    Duration duration = const Duration(milliseconds: 11),
  }) {
    return Navigator.of(this).push<T>(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: duration,
      ),
    );
  }

  Future<T?> pushReplacement<T>(
    Widget page, {
    Duration duration = const Duration(milliseconds: 200),
  }) {
    return Navigator.of(this).pushReplacement<T, T>(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: duration,
      ),
    );
  }

  // ========== Navigation Helpers ==========
  // Future<T?> push<T>(Widget page) {
  //   return Navigator.of(this).push<T>(MaterialPageRoute(builder: (_) => page));
  // }

  // Future<T?> pushReplacement<T, TO>(Widget page, {TO? result}) {
  //   return Navigator.of(this).pushReplacement<T, TO>(
  //     MaterialPageRoute(builder: (_) => page),
  //     result: result,
  //   );
  // }
}
