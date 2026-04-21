import 'package:flutter/material.dart';
import '../../../../core/index.dart';

class BalanceCard extends StatelessWidget {
  final String balance;
  final String change;
  const BalanceCard({
    super.key,
    required this.balance,
    required this.change,
  });

  @override
  Widget build(BuildContext context) {
    return GradientCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'TOTAL BALANCE',
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.textMuted),
          ),
          SizedBox(height: 12),
          Text(
            balance,
            style: AppTextStyles.displayMedium,
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Icon(
                Icons.trending_up_rounded,
                size: 16,
                color: AppColors.accentGreen,
              ),
              Text(
                '$change this month',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.accentGreen,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
