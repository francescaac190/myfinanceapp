import 'package:flutter/material.dart';
import 'package:myfinanceapp/core/theme/app_colors.dart';
import 'package:myfinanceapp/core/theme/app_radius.dart';
import 'package:myfinanceapp/core/theme/app_text_styles.dart';

enum AppButtonVariant { primary, secondary, outline, ghost, danger }

enum AppButtonSize { sm, md, lg }

class AppButton extends StatelessWidget {
  const AppButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.lg,
    this.loading = false,
    this.fullWidth = true,
    this.icon,
    this.trailingIcon,
  });

  const AppButton.primary({
    required this.label,
    required this.onPressed,
    super.key,
    this.size = AppButtonSize.lg,
    this.loading = false,
    this.fullWidth = true,
    this.icon,
    this.trailingIcon,
  }) : variant = AppButtonVariant.primary;

  const AppButton.secondary({
    required this.label,
    required this.onPressed,
    super.key,
    this.size = AppButtonSize.lg,
    this.loading = false,
    this.fullWidth = true,
    this.icon,
    this.trailingIcon,
  }) : variant = AppButtonVariant.secondary;

  const AppButton.outline({
    required this.label,
    required this.onPressed,
    super.key,
    this.size = AppButtonSize.lg,
    this.loading = false,
    this.fullWidth = true,
    this.icon,
    this.trailingIcon,
  }) : variant = AppButtonVariant.outline;

  const AppButton.ghost({
    required this.label,
    required this.onPressed,
    super.key,
    this.size = AppButtonSize.md,
    this.loading = false,
    this.fullWidth = false,
    this.icon,
    this.trailingIcon,
  }) : variant = AppButtonVariant.ghost;

  const AppButton.danger({
    required this.label,
    required this.onPressed,
    super.key,
    this.size = AppButtonSize.lg,
    this.loading = false,
    this.fullWidth = true,
    this.icon,
    this.trailingIcon,
  }) : variant = AppButtonVariant.danger;

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final bool loading;
  final bool fullWidth;
  final IconData? icon;
  final IconData? trailingIcon;

  double get _height => switch (size) {
        AppButtonSize.sm => 36,
        AppButtonSize.md => 44,
        AppButtonSize.lg => 52,
      };

  EdgeInsets get _padding => switch (size) {
        AppButtonSize.sm => const EdgeInsets.symmetric(horizontal: 12),
        AppButtonSize.md => const EdgeInsets.symmetric(horizontal: 16),
        AppButtonSize.lg => const EdgeInsets.symmetric(horizontal: 20),
      };

  TextStyle get _labelStyle => switch (size) {
        AppButtonSize.sm =>
          AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600),
        AppButtonSize.md =>
          AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w600),
        AppButtonSize.lg =>
          AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.w600),
      };

  ({Color bg, Color fg, Color? border}) _palette() {
    switch (variant) {
      case AppButtonVariant.primary:
        return (bg: AppColors.accentBlue, fg: AppColors.textPrimary, border: null);
      case AppButtonVariant.secondary:
        return (bg: AppColors.bgCard, fg: AppColors.textPrimary, border: null);
      case AppButtonVariant.outline:
        return (
          bg: Colors.transparent,
          fg: AppColors.textPrimary,
          border: AppColors.borderCard
        );
      case AppButtonVariant.ghost:
        return (bg: Colors.transparent, fg: AppColors.accentBlue, border: null);
      case AppButtonVariant.danger:
        return (bg: AppColors.accentRed, fg: AppColors.textPrimary, border: null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = _palette();
    final disabled = onPressed == null || loading;

    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.lg),
      side: p.border != null
          ? BorderSide(color: p.border!, width: 0.5)
          : BorderSide.none,
    );

    final style = ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return p.bg.withValues(alpha: 0.5);
        }
        return p.bg;
      }),
      foregroundColor: WidgetStateProperty.all(p.fg),
      overlayColor: WidgetStateProperty.all(
        p.fg.withValues(alpha: 0.08),
      ),
      shape: WidgetStateProperty.all(shape),
      padding: WidgetStateProperty.all(_padding),
      minimumSize: WidgetStateProperty.all(Size(0, _height)),
      elevation: WidgetStateProperty.all(0),
      shadowColor: WidgetStateProperty.all(Colors.transparent),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );

    final child = loading
        ? SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation(p.fg),
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 18, color: p.fg),
                const SizedBox(width: 8),
              ],
              Text(label, style: _labelStyle.copyWith(color: p.fg)),
              if (trailingIcon != null) ...[
                const SizedBox(width: 8),
                Icon(trailingIcon, size: 18, color: p.fg),
              ],
            ],
          );

    final btn = TextButton(
      onPressed: disabled ? null : onPressed,
      style: style,
      child: child,
    );

    return SizedBox(
      width: fullWidth ? double.infinity : null,
      height: _height,
      child: btn,
    );
  }
}
