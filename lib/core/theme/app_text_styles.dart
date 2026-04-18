import 'package:flutter/material.dart';

class AppTextStyles {
  AppTextStyles._();

  // Font families
  static const String _geist = 'Geist';
  static const String _inter = 'Inter';
  static const String _geistMono = 'GeistMono';

  // Hero numbers, budget amounts, large display figures
  /// 44px · Geist 800 · Budget amount input (e.g. "$2,500")
  static const TextStyle displayLarge = TextStyle(
    fontFamily: _geist,
    fontSize: 44,
    fontWeight: FontWeight.w800,
    height: 1.1,
    letterSpacing: -0.5,
  );

  /// 36px · Geist 800 · Hero balance numbers (e.g. "$24,680.50")
  static const TextStyle displayMedium = TextStyle(
    fontFamily: _geist,
    fontSize: 36,
    fontWeight: FontWeight.w800,
    height: 1.1,
    letterSpacing: -0.5,
  );

  /// 32px · Geist 800 · Bill total, savings hero amounts (e.g. "$1,240.00")
  static const TextStyle displaySmall = TextStyle(
    fontFamily: _geist,
    fontSize: 32,
    fontWeight: FontWeight.w800,
    height: 1.15,
    letterSpacing: -0.3,
  );

  // Screen titles, section headers, transaction values
  // ────────────────────────────────────────────────────────────

  /// 28px · Geist 700 · Screen titles (e.g. "Profile")
  static const TextStyle headlineLarge = TextStyle(
    fontFamily: _geist,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    height: 1.2,
    letterSpacing: -0.2,
  );

  /// 24px · Geist 700 · Greeting name, section hero numbers (e.g. "Good Morning")
  static const TextStyle headlineMedium = TextStyle(
    fontFamily: _geist,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.25,
  );

  /// 22px · Geist 700 · Sub-screen titles (e.g. "Set Budget Limit")
  static const TextStyle headlineSmall = TextStyle(
    fontFamily: _geist,
    fontSize: 22,
    fontWeight: FontWeight.w700,
    height: 1.25,
  );

  // Profile name, card categories, sub-section headers
  // ────────────────────────────────────────────────────────────

  /// 20px · Inter/Geist 700 · Profile name, card categories (e.g. "Alexander Chen")
  static const TextStyle titleLarge = TextStyle(
    fontFamily: _inter,
    fontSize: 20,
    fontWeight: FontWeight.w700,
    height: 1.3,
  );

  /// 18px · Geist 700 · Sub-section headers (e.g. "Alpha Tints")
  static const TextStyle titleMedium = TextStyle(
    fontFamily: _geist,
    fontSize: 18,
    fontWeight: FontWeight.w700,
    height: 1.3,
  );

  /// 16px · Inter 600 · Category names, card titles, buttons (e.g. "Entertainment")
  static const TextStyle titleSmall = TextStyle(
    fontFamily: _inter,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  // Status bar, logout, active tabs, toggles
  // ────────────────────────────────────────────────────────────

  /// 15px · Inter 600 · Status bar time, logout text (e.g. "9:41 AM")
  static const TextStyle labelLarge = TextStyle(
    fontFamily: _inter,
    fontSize: 15,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  // List items, settings, descriptions, emails
  // ────────────────────────────────────────────────────────────

  /// 14px · Inter 500/600 · List items, settings, amounts (e.g. "Netflix Premium")
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: _inter,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.45,
  );

  /// 14px · Inter 600 · Emphasized variant of [bodyLarge] for amounts, active rows
  static const TextStyle bodyLargeEmphasis = TextStyle(
    fontFamily: _inter,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.45,
  );

  /// 13px · Inter 400/500 · Descriptions, email, subtitles (e.g. "Monthly subscription")
  static const TextStyle bodyMedium = TextStyle(
    fontFamily: _inter,
    fontSize: 13,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  /// 13px · Inter 500 · Emphasized variant of [bodyMedium]
  static const TextStyle bodyMediumEmphasis = TextStyle(
    fontFamily: _inter,
    fontSize: 13,
    fontWeight: FontWeight.w500,
    height: 1.5,
  );

  /// 12px · Inter 400 · Sub-labels, categories, hints (e.g. "Streaming · Oct 15")
  static const TextStyle bodySmall = TextStyle(
    fontFamily: _inter,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  // Nav tabs, smallest UI labels
  // ────────────────────────────────────────────────────────────

  /// 10px · Inter 600 · Nav tab labels (e.g. "HOME", "BILLS")
  static const TextStyle navLabel = TextStyle(
    fontFamily: _inter,
    fontSize: 10,
    fontWeight: FontWeight.w600,
    height: 1.2,
    letterSpacing: 0.5,
  );

  // Section headers (UPPERCASE), hex values, card numbers
  // ────────────────────────────────────────────────────────────

  /// 13px · GeistMono 600 · Mono section labels
  static const TextStyle monoLarge = TextStyle(
    fontFamily: _geistMono,
    fontSize: 13,
    fontWeight: FontWeight.w600,
    height: 1.4,
    letterSpacing: 0.8,
  );

  /// 12px · GeistMono 600 · Hex codes, card numbers
  static const TextStyle monoMedium = TextStyle(
    fontFamily: _geistMono,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 1.4,
    letterSpacing: 0.5,
  );

  /// 11px · GeistMono 600 · Section headers, UPPERCASE letterspaced (e.g. "LINKED ACCOUNTS")
  static const TextStyle monoSectionHeader = TextStyle(
    fontFamily: _geistMono,
    fontSize: 11,
    fontWeight: FontWeight.w600,
    height: 1.3,
    letterSpacing: 1.2,
  );

  /// 9px · GeistMono 400 · Smallest captions, variable refs (e.g. "Updated 2m ago")
  static const TextStyle monoCaption = TextStyle(
    fontFamily: _geistMono,
    fontSize: 9,
    fontWeight: FontWeight.w400,
    height: 1.3,
    letterSpacing: 0.4,
  );
}
