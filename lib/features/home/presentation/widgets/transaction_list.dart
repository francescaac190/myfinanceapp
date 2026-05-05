import 'package:flutter/material.dart';

import 'package:myfinanceapp/core/index.dart';
import 'package:myfinanceapp/features/home/domain/entities/home_overview_entity.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({
    required this.transactions,
    super.key,
  });

  final List<RecentTransaction> transactions;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Transactions',
              style: AppTextStyles.titleSmall,
            ),
            Text(
              'See all',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.accentBlue,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        AppSpacing.gapSm,
        Container(
          decoration: BoxDecoration(
            color: AppColors.bgCard,
            borderRadius: AppRadius.allMd,
            border: Border.all(
              color: AppColors.borderCard,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: transactions.isEmpty
                ? [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        'No transactions yet',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textMuted,
                        ),
                      ),
                    ),
                  ]
                : transactions
                    .map(
                      (transaction) => TransactionItem(
                        title: transaction.description,
                        subtitle: _formatDate(transaction.occurredAt),
                        amount: _formatAmount(transaction),
                        icon: _iconForType(transaction.type),
                        iconColor: _colorForType(transaction.type),
                        amountColor: _colorForType(transaction.type),
                      ),
                    )
                    .toList(),
          ),
        ),
      ],
    );
  }
}

String _formatDate(DateTime date) {
  final local = date.toLocal();
  final hour = local.hour.toString().padLeft(2, '0');
  final minute = local.minute.toString().padLeft(2, '0');
  return '${local.month}/${local.day}/${local.year}, $hour:$minute';
}

String _formatAmount(RecentTransaction transaction) {
  final prefix = transaction.type == 'EXPENSE' ? '-' : '+';
  return '$prefix\$${transaction.amount}';
}

IconData _iconForType(String type) {
  return type == 'EXPENSE'
      ? Icons.arrow_upward_rounded
      : Icons.arrow_downward_rounded;
}

Color _colorForType(String type) {
  return type == 'EXPENSE' ? AppColors.accentRed : AppColors.accentGreen;
}

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.icon,
    required this.iconColor,
    this.amountColor = AppColors.accentRed,
    super.key,
  });
  final String title;
  final String subtitle;
  final String amount;
  final IconData icon;
  final Color iconColor;
  final Color amountColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: AppRadius.allSm,
        child: Container(
          padding: EdgeInsets.all(12),
          color: AppColors.bgSecondary,
          child: Icon(icon, color: iconColor, size: 20),
        ),
      ),
      title: Text(
        title,
        style: AppTextStyles.bodyMedium.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: AppTextStyles.bodySmall.copyWith(
          color: AppColors.textMuted,
        ),
      ),
      trailing: Text(
        amount,
        style: AppTextStyles.bodySmall.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: amountColor,
        ),
      ),
    );
  }
}
