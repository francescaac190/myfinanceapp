import 'package:flutter/material.dart';

import 'package:myfinanceapp/core/index.dart';
import 'package:myfinanceapp/features/home/presentation/widgets/gradient_progress_bar.dart';

class SpendingBalance extends StatelessWidget {
  const SpendingBalance({
    required this.total,
    super.key,
  });

  final String total;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Spending this month', style: AppTextStyles.titleSmall),
            AppSpacing.gapSm,
            Text(
              '\$$total spent',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textMuted,
              ),
            ),
          ],
        ),
        AppSpacing.gapSm,
        GradientProgressBar(progress: 0),
        AppSpacing.gapSm,
      ],
    );
  }
}
