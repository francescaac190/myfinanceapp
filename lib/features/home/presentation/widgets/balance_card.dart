import 'package:flutter/material.dart';
import 'package:myfinanceapp/core/index.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({
    required this.balance, required this.change, super.key,
  });
  final String balance;
  final String change;

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
          ),
        ],
      ),
    );
  }
}
