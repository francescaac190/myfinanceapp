import 'package:flutter/widgets.dart';

/// ============================================================================
/// APP SPACING
/// ----------------------------------------------------------------------------
/// All padding, margin, and gap values should be referenced from this file.
///
/// Scale: t-shirt sizes, doubling rhythm
///   xs  =  4  → tight gaps between adjacent icons/text
///   sm  =  8  → inner chip padding, between label and value
///   md  = 16  → standard card padding, default list gap (most common)
///   lg  = 24  → section spacing, screen horizontal padding
///   xl  = 32  → between major sections, above primary CTAs
///   xxl = 48  → hero sections, empty-state illustrations
///   xxxl= 64  → rare, top/bottom of onboarding screens
///
/// Usage:
///   Container(padding: EdgeInsets.all(AppSpacing.md))
///   SizedBox(height: AppSpacing.lg)
///   AppSpacing.gapMd  (pre-built SizedBox shortcuts)
/// ============================================================================
class AppSpacing {
  AppSpacing._();

  // ---------------------------------------------------------------------------
  // RAW VALUES
  // ---------------------------------------------------------------------------

  /// 4px — tight gap between adjacent icon and label, chip internal.
  static const double xs = 4;

  /// 8px — small inner padding, gap between two closely related elements.
  static const double sm = 8;

  /// 16px — default card padding, default list item gap. The workhorse.
  static const double md = 16;

  /// 24px — section gap, default screen horizontal padding.
  static const double lg = 24;

  /// 32px — large section separation, above primary CTAs.
  static const double xl = 32;

  /// 48px — hero spacing, between major content blocks.
  static const double xxl = 48;

  /// 64px — onboarding vertical rhythm, splash screen.
  static const double xxxl = 64;

  // ---------------------------------------------------------------------------
  // SEMANTIC ALIASES
  // ---------------------------------------------------------------------------
  // Use these when the intent is clearer than the size.

  /// 24px — standard horizontal padding inside a screen (left/right edges).
  static const double screenHorizontal = lg;

  /// 16px — standard vertical padding between stacked cards or list items.
  static const double screenVertical = md;

  /// 16px — default padding inside an AppCard.
  static const double cardPadding = md;

  /// 12px — inner padding for compact chips and pills.
  static const double chipPadding = 12;

  /// 56px — standard tappable height (buttons, list tiles). Exceeds the
  /// minimum 48px accessibility target while staying comfortable on mobile.
  static const double tapTarget = 56;

  /// 48px — minimum accessibility tap target size. Never go below this.
  static const double minTapTarget = 48;

  /// 64px — height of the bottom navigation bar.
  static const double bottomNavHeight = 64;

  /// 56px — height of the app bar (standard Material).
  static const double appBarHeight = 56;

  // ---------------------------------------------------------------------------
  // PRE-BUILT EDGE INSETS
  // ---------------------------------------------------------------------------
  // Shortcuts for the most common padding patterns.
  // Use these instead of typing EdgeInsets.all(AppSpacing.md) everywhere.

  static const EdgeInsets allXs = EdgeInsets.all(xs);
  static const EdgeInsets allSm = EdgeInsets.all(sm);
  static const EdgeInsets allMd = EdgeInsets.all(md);
  static const EdgeInsets allLg = EdgeInsets.all(lg);

  /// Standard screen edge padding: 24px horizontal, 16px vertical.
  static const EdgeInsets screen = EdgeInsets.symmetric(
    horizontal: screenHorizontal,
    vertical: screenVertical,
  );

  /// Screen horizontal padding only (useful for ListView content).
  static const EdgeInsets screenHorizontalOnly = EdgeInsets.symmetric(
    horizontal: screenHorizontal,
  );

  /// Standard card inner padding.
  static const EdgeInsets card = EdgeInsets.all(cardPadding);

  /// Compact card padding (for dense list items, small cards).
  static const EdgeInsets cardCompact = EdgeInsets.symmetric(
    horizontal: md,
    vertical: sm,
  );

  // ---------------------------------------------------------------------------
  // PRE-BUILT GAP WIDGETS
  // ---------------------------------------------------------------------------
  // Drop-in SizedBox shortcuts. Use in Column/Row children lists.
  //
  // Example:
  //   Column(children: [
  //     TotalBalanceCard(),
  //     AppSpacing.gapMd,
  //     SpendingCard(),
  //     AppSpacing.gapLg,
  //     RecentTransactionsList(),
  //   ])

  /// Vertical gap of 4px.
  static const Widget gapXs = SizedBox(height: xs);

  /// Vertical gap of 8px.
  static const Widget gapSm = SizedBox(height: sm);

  /// Vertical gap of 16px — most common.
  static const Widget gapMd = SizedBox(height: md);

  /// Vertical gap of 24px.
  static const Widget gapLg = SizedBox(height: lg);

  /// Vertical gap of 32px.
  static const Widget gapXl = SizedBox(height: xl);

  /// Vertical gap of 48px.
  static const Widget gapXxl = SizedBox(height: xxl);

  /// Horizontal gap of 4px.
  static const Widget hGapXs = SizedBox(width: xs);

  /// Horizontal gap of 8px.
  static const Widget hGapSm = SizedBox(width: sm);

  /// Horizontal gap of 16px — most common.
  static const Widget hGapMd = SizedBox(width: md);

  /// Horizontal gap of 24px.
  static const Widget hGapLg = SizedBox(width: lg);

  /// Horizontal gap of 32px.
  static const Widget hGapXl = SizedBox(width: xl);

  // ---------------------------------------------------------------------------
  // DYNAMIC HELPERS
  // ---------------------------------------------------------------------------
  // For cases where the size needs to be computed (not const).

  /// Returns a vertical SizedBox of arbitrary height.
  /// Prefer the gap* constants above when the value is one of the standard tokens.
  static SizedBox vGap(double height) => SizedBox(height: height);

  /// Returns a horizontal SizedBox of arbitrary width.
  static SizedBox hGap(double width) => SizedBox(width: width);
}
