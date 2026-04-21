import 'package:flutter/material.dart';

import 'package:myfinanceapp/core/index.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({
    super.key,
  });

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
            children: const [
              TransactionItem(
                title: 'Starbucks',
                subtitle: 'Today, 8:30 AM',
                amount: r'-$5.75',
                icon: Icons.local_cafe_outlined,
                iconColor: AppColors.accentGreen,
              ),
              TransactionItem(
                title: 'Amazon',
                subtitle: 'Yesterday, 3:15 PM',
                amount: r'-$120.00',
                icon: Icons.shopping_cart_outlined,
                iconColor: AppColors.accentRed,
              ),

              // error case
              // Center(
              //   child: Text('No transactions yet',
              //       style: TextStyle(
              //         fontSize: 14,
              //         color: AppColors.textMuted,
              //     )),
            ],
          ),
        ),
      ],
    );
  }
}

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.icon,
    required this.iconColor,
    super.key,
  });
  final String title;
  final String subtitle;
  final String amount;
  final IconData icon;
  final Color iconColor;

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
          color: AppColors.accentRed,
        ),
      ),
    );
  }
}
