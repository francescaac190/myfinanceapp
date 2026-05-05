import 'package:flutter/material.dart';
import 'package:myfinanceapp/core/index.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text(
          'Quick Actions',
          style: AppTextStyles.titleSmall,
        ),
        AppSpacing.gapMd,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Action(
              icon: Icons.swap_horiz_rounded,
              color: AppColors.accentGreen,
              label: 'Send',
            ),
            Action(
              icon: Icons.radar_rounded,
              color: AppColors.accentAmber,
              label: 'New Goal',
            ),
            Action(
              icon: Icons.donut_large_outlined,
              color: AppColors.accentRed,
              label: 'Budget',
            ),
          ],
        ),
      ],
    );
  }
}

class Action extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  const Action({
    required this.icon,
    required this.color,
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: AppColors.bgCard,
          child: Icon(
            icon,
            color: color,
          ),
        ),
        AppSpacing.gapSm,
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textMuted,
          ),
        ),
      ],
    );
  }
}
