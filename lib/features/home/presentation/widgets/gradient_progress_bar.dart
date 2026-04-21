import 'package:flutter/material.dart';
import 'package:myfinanceapp/core/theme/app_colors.dart';
import 'package:myfinanceapp/core/theme/app_radius.dart';

class GradientProgressBar extends StatelessWidget { // Value between 0.0 and 1.0

  const GradientProgressBar({required this.progress, super.key});
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 8,
      decoration: BoxDecoration(
        color: AppColors.bgCard, // Background track color
        borderRadius: AppRadius.allXs,
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: progress,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: const [
                AppColors.accentPurple,
                AppColors.accentBlue,
              ], // Your gradient colors
            ),
            borderRadius: AppRadius.allXs,
          ),
        ),
      ),
    );
  }
}
