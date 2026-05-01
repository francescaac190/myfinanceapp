import 'package:flutter/material.dart';
import 'package:myfinanceapp/core/theme/app_colors.dart';
import 'package:myfinanceapp/core/theme/app_radius.dart';
import 'package:myfinanceapp/core/theme/app_text_styles.dart';

enum AppToastType { success, warning, info, error }

class AppToast {
  AppToast._();

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> show(
    BuildContext context, {
    required String message,
    AppToastType type = AppToastType.info,
    String? title,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    final messenger = ScaffoldMessenger.of(context)..clearSnackBars();
    return messenger.showSnackBar(
      _build(
        message: message,
        type: type,
        title: title,
        duration: duration,
        action: action,
      ),
    );
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> success(
    BuildContext context,
    String message, {
    String? title,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) =>
      show(
        context,
        message: message,
        type: AppToastType.success,
        title: title,
        duration: duration,
        action: action,
      );

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> warning(
    BuildContext context,
    String message, {
    String? title,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) =>
      show(
        context,
        message: message,
        type: AppToastType.warning,
        title: title,
        duration: duration,
        action: action,
      );

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> info(
    BuildContext context,
    String message, {
    String? title,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) =>
      show(
        context,
        message: message,
        title: title,
        duration: duration,
        action: action,
      );

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> error(
    BuildContext context,
    String message, {
    String? title,
    Duration duration = const Duration(seconds: 4),
    SnackBarAction? action,
  }) =>
      show(
        context,
        message: message,
        type: AppToastType.error,
        title: title,
        duration: duration,
        action: action,
      );

  static SnackBar _build({
    required String message,
    required AppToastType type,
    String? title,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    final palette = _paletteFor(type);
    return SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
      duration: duration,
      padding: EdgeInsets.zero,
      margin: const EdgeInsets.all(12),
      shape: const RoundedRectangleBorder(),
      content: _ToastBody(
        message: message,
        title: title,
        icon: palette.icon,
        accent: palette.accent,
        background: palette.background,
        border: palette.border,
      ),
      action: action,
    );
  }

  static _ToastPalette _paletteFor(AppToastType type) {
    switch (type) {
      case AppToastType.success:
        return _ToastPalette(
          accent: AppColors.accentGreen,
          background: AppColors.accentGreenTint,
          border: AppColors.accentGreen.withValues(alpha: 0.4),
          icon: Icons.check_circle_outline,
        );
      case AppToastType.warning:
        return _ToastPalette(
          accent: AppColors.accentAmber,
          background: AppColors.accentAmberTint,
          border: AppColors.accentAmber.withValues(alpha: 0.4),
          icon: Icons.warning_amber_rounded,
        );
      case AppToastType.info:
        return _ToastPalette(
          accent: AppColors.accentBlue,
          background: AppColors.accentBlue.withValues(alpha: 0.10),
          border: AppColors.accentBlue.withValues(alpha: 0.4),
          icon: Icons.info_outline,
        );
      case AppToastType.error:
        return _ToastPalette(
          accent: AppColors.accentRed,
          background: AppColors.accentRedTint,
          border: AppColors.accentRed.withValues(alpha: 0.4),
          icon: Icons.error_outline,
        );
    }
  }
}

class _ToastPalette {
  _ToastPalette({
    required this.accent,
    required this.background,
    required this.border,
    required this.icon,
  });
  final Color accent;
  final Color background;
  final Color border;
  final IconData icon;
}

class _ToastBody extends StatelessWidget {
  const _ToastBody({
    required this.message,
    required this.icon,
    required this.accent,
    required this.background,
    required this.border,
    this.title,
  });

  final String message;
  final String? title;
  final IconData icon;
  final Color accent;
  final Color background;
  final Color border;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: border, width: 0.8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: accent),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (title != null) ...[
                  Text(
                    title!,
                    style: AppTextStyles.bodyLargeEmphasis
                        .copyWith(color: accent),
                  ),
                  const SizedBox(height: 2),
                ],
                Text(
                  message,
                  style: AppTextStyles.bodyMedium
                      .copyWith(color: AppColors.textPrimary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
