import 'package:flutter/material.dart';
import 'package:myfinanceapp/core/theme/app_colors.dart';

class GradientProgressBar extends StatelessWidget {
  final double progress; // Value between 0.0 and 1.0

  GradientProgressBar({required this.progress});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 8,
      decoration: BoxDecoration(
        color: AppColors.bgCard, // Background track color
        borderRadius: BorderRadius.circular(5),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: progress,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.accentPurple,
                AppColors.accentBlue
              ], // Your gradient colors
            ),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}
