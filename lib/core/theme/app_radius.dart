import 'package:flutter/widgets.dart';

/// ============================================================================
/// APP RADIUS
/// ----------------------------------------------------------------------------
/// Centralized border radius tokens for the application.
/// All rounded corners should be referenced from this file.
///
/// Scale:
///   xs   =  4px  → subtle rounding (input fields, small chips)
///   sm   =  8px  → secondary buttons, small cards
///   md   = 12px  → standard chips, list item backgrounds
///   lg   = 16px  → primary cards (balance card, bill card)
///   xl   = 20px  → large feature cards (hero wallet card)
///   xxl  = 28px  → modal sheets, rounded app bar corners
///   full = 999px → pills, circular avatars, FABs
///
/// Usage:
///   BorderRadius.circular(AppRadius.lg)
///   AppRadius.cardLg   (pre-built BorderRadius shortcuts)
///   AppRadius.topLg    (top-only for bottom sheets)
/// ============================================================================
class AppRadius {
  AppRadius._();

  // ---------------------------------------------------------------------------
  // RAW VALUES
  // ---------------------------------------------------------------------------

  /// 4px — subtle rounding for input fields and small chips.
  static const double xs = 4;

  /// 8px — secondary buttons, small info cards.
  static const double sm = 8;

  /// 12px — standard chips, list item backgrounds, category pills.
  static const double md = 12;

  /// 16px — primary cards (the most common radius in the app).
  static const double lg = 16;

  /// 20px — large feature cards (wallet hero, balance card).
  static const double xl = 20;

  /// 28px — bottom sheets, modal top corners.
  static const double xxl = 28;

  /// 999px — pills, circular buttons, avatar rings.
  static const double full = 999;

  // ---------------------------------------------------------------------------
  // SEMANTIC ALIASES
  // ---------------------------------------------------------------------------
  // Use these when the intent is clearer than the number.

  /// 16px — default card radius across the app.
  static const double card = lg;

  /// 20px — hero card radius (wallet balance, savings total).
  static const double heroCard = xl;

  /// 12px — standard button radius.
  static const double button = md;

  /// 8px — input field radius.
  static const double input = sm;

  /// 999px — pill-shaped buttons and tag chips.
  static const double pill = full;

  /// 28px — modal bottom sheets.
  static const double sheet = xxl;

  // ---------------------------------------------------------------------------
  // PRE-BUILT BORDER RADIUS OBJECTS
  // ---------------------------------------------------------------------------
  // Shortcuts for the most common patterns. Use these instead of typing
  // BorderRadius.circular(AppRadius.lg) repeatedly.

  /// Equal rounding on all corners — 4px.
  static const BorderRadius allXs = BorderRadius.all(Radius.circular(xs));

  /// Equal rounding on all corners — 8px.
  static const BorderRadius allSm = BorderRadius.all(Radius.circular(sm));

  /// Equal rounding on all corners — 12px.
  static const BorderRadius allMd = BorderRadius.all(Radius.circular(md));

  /// Equal rounding on all corners — 16px (standard card).
  static const BorderRadius allLg = BorderRadius.all(Radius.circular(lg));

  /// Equal rounding on all corners — 20px (hero card).
  static const BorderRadius allXl = BorderRadius.all(Radius.circular(xl));

  /// Equal rounding on all corners — 28px (sheet).
  static const BorderRadius allXxl = BorderRadius.all(Radius.circular(xxl));

  /// Pill shape — fully rounded on all sides.
  static const BorderRadius allFull = BorderRadius.all(Radius.circular(full));

  // ---------------------------------------------------------------------------
  // DIRECTIONAL RADII (top only / bottom only)
  // ---------------------------------------------------------------------------
  // Useful for bottom sheets, app bar containers, and cards that sit against
  // a screen edge.

  /// Rounds only the top corners — 16px. Used for bottom sheets, toasts.
  static const BorderRadius topLg = BorderRadius.only(
    topLeft: Radius.circular(lg),
    topRight: Radius.circular(lg),
  );

  /// Rounds only the top corners — 28px. Standard bottom sheet style.
  static const BorderRadius topSheet = BorderRadius.only(
    topLeft: Radius.circular(xxl),
    topRight: Radius.circular(xxl),
  );

  /// Rounds only the bottom corners — 16px. Used for items stacked against
  /// an app bar or fixed header.
  static const BorderRadius bottomLg = BorderRadius.only(
    bottomLeft: Radius.circular(lg),
    bottomRight: Radius.circular(lg),
  );

  // ---------------------------------------------------------------------------
  // DYNAMIC HELPERS
  // ---------------------------------------------------------------------------

  /// Returns a BorderRadius with equal rounding on all sides.
  /// Prefer the `all*` constants above when the value is a standard token.
  static BorderRadius all(double radius) =>
      BorderRadius.all(Radius.circular(radius));

  /// Returns a BorderRadius with custom corner values.
  static BorderRadius only({
    double topLeft = 0,
    double topRight = 0,
    double bottomLeft = 0,
    double bottomRight = 0,
  }) =>
      BorderRadius.only(
        topLeft: Radius.circular(topLeft),
        topRight: Radius.circular(topRight),
        bottomLeft: Radius.circular(bottomLeft),
        bottomRight: Radius.circular(bottomRight),
      );
}
