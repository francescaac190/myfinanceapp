import 'package:flutter/material.dart';

import 'package:myfinanceapp/core/index.dart';
import 'package:myfinanceapp/features/home/presentation/widgets/gradient_progress_bar.dart';

class SpendingBalance extends StatelessWidget {
  const SpendingBalance({
    super.key,
  });

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
              r'$567.89 / $1,000',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textMuted,
              ),
            ),
          ],
        ),
        AppSpacing.gapSm,
        GradientProgressBar(progress: 0.61),
        AppSpacing.gapSm,
      ],
    );
  }
}
