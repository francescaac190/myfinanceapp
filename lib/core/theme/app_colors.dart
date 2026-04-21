// Centralize color system for the app

import 'package:flutter/material.dart';

class AppColors {
  // SURFACES
  /// Screen backgrounds
  static const Color bgPrimary = Color(0xFF0B0F1A);

  /// Secondary backgrounds, nav
  static const Color bgSecondary = Color(0xFF111827);

  /// Card backgrounds
  static const Color bgCard = Color(0xFF1A1F2E);

  /// Alternate cards, dividers
  static const Color bgCardAlt = Color(0xFF1E293B);

  // TEXT
  /// Heading, key text, active text
  static const Color textPrimary = Color(0xFFFFFFFF);

  /// Description, label, secondary info
  static const Color textSecondary = Color(0xFF94A3B8);

  /// Caption, inactive tabs, hints
  static const Color textMuted = Color(0xFF64748B);

  // BORDERS
  /// Dividers, row separators
  static const Color borderSubtle = Color(0xFF1E293B);

  /// Card outlines
  static const Color borderCard = Color(0x0DFFFFFF);

  //ACCENT COLORS
  /// primary accions, nav tabs, links, CTA buttons
  static const Color accentBlue = Color(0xFF3B82F6);

  /// Positive values, income, savings progress, Face ID toggle, success states.
  static const Color accentGreen = Color(0xFF10B981);

  /// Pro badge, profile tab, mastercard gradient, transfer action icons.
  static const Color accentPurple = Color(0xFF8B5CF6);

  /// Expenses, over-budget alerts, logout button, critical warnings, overdue bills.
  static const Color accentRed = Color(0xFFEF4444);

  /// Warnings, notifications bell, food category, 70% budget threshold alerts.
  static const Color accentAmber = Color(0xFFF59E0B);

  // ALPHA TINTS
  /// For hover states, active tab backgrounds, and subtle highlights.
  ///   static Color get accentBlueTint => accentBlue.withValues(alpha: 0.10);
  static Color get accentGreenTint => accentGreen.withValues(alpha: 0.10);
  static Color get accentPurpleTint => accentPurple.withValues(alpha: 0.10);
  static Color get accentRedTint => accentRed.withValues(alpha: 0.10);
  static Color get accentAmberTint => accentAmber.withValues(alpha: 0.10);

  // SEMANTIC ALIASES
  /// Primary action color for buttons, links, and active states.
  static const Color success = accentGreen;
  static const Color warning = accentAmber;
  static const Color error = accentRed;
  static const Color info = accentBlue;
  static const Color brand = accentBlue;
  static const Color premium = accentPurple;
}

// APP THEME
class AppTheme {
  AppTheme._(); // Private constructor to prevent instantiation

  static ThemeData get dark {
    const colorScheme = ColorScheme.dark(
      primary: AppColors.accentBlue,
      onPrimary: AppColors.textPrimary,
      secondary: AppColors.accentPurple,
      onSecondary: AppColors.textPrimary,
      tertiary: AppColors.accentGreen,
      onTertiary: AppColors.textPrimary,
      error: AppColors.accentRed,
      onError: AppColors.textPrimary,
      surface: AppColors.bgCard,
      surfaceContainerLowest: AppColors.bgPrimary,
      surfaceContainerLow: AppColors.bgSecondary,
      surfaceContainer: AppColors.bgCard,
      surfaceContainerHigh: AppColors.bgCardAlt,
      surfaceContainerHighest: AppColors.bgSecondary,
      outline: AppColors.borderSubtle,
      outlineVariant: AppColors.borderCard,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.bgPrimary,
      canvasColor: AppColors.bgPrimary,
      dividerColor: AppColors.borderSubtle,
      cardTheme: CardThemeData(
        color: AppColors.bgCard,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.bgSecondary,
        foregroundColor: AppColors.textPrimary,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
      ),
      textTheme: const TextTheme().apply(
        bodyColor: AppColors.textPrimary,
        displayColor: AppColors.textPrimary,
      ),
    );
  }
}
