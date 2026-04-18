import 'package:flutter/material.dart';

import '../../../../core/index.dart';
import 'gradient_progress_bar.dart';

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
            SizedBox(height: 12),
            Text('\$567.89 / \$1,000',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textMuted,
                )),
          ],
        ),
        SizedBox(height: 12),
        GradientProgressBar(progress: 0.61),
        SizedBox(height: 12),
      ],
    );
  }
}
