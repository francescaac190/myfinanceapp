import 'package:flutter/material.dart';
import 'package:myfinanceapp/core/index.dart';

class SpendingCardList extends StatelessWidget {
  const SpendingCardList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        SpendingCard(),
        AppSpacing.hGapSm,
        SpendingCard(),
        AppSpacing.hGapSm,
        SpendingCard(),
      ],
    );
  }
}

class SpendingCard extends StatelessWidget {
  const SpendingCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.bgCard,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.borderCard,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Food',
              style: AppTextStyles.bodySmall
                  .copyWith(color: AppColors.textSecondary),
            ),
            AppSpacing.gapXs,
            Text(
              r'$89.50',
              style: AppTextStyles.titleSmall
                  .copyWith(color: AppColors.accentBlue, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
