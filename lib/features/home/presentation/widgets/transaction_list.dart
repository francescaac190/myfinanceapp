import 'package:flutter/material.dart';

import '../../../../core/index.dart';

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
            Text('See all',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.accentBlue,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                )),
          ],
        ),
        SizedBox(height: 12),
        Container(
          // height: 100,
          decoration: BoxDecoration(
            color: AppColors.bgCard,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.borderCard,
              width: 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TransactionItem(
                title: 'Starbucks',
                subtitle: 'Today, 8:30 AM',
                amount: '-\$5.75',
                icon: Icons.local_cafe_outlined,
                iconColor: AppColors.accentGreen,
              ),
              TransactionItem(
                title: 'Amazon',
                subtitle: 'Yesterday, 3:15 PM',
                amount: '-\$120.00',
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
  final String title;
  final String subtitle;
  final String amount;
  final IconData icon;
  final Color iconColor;
  const TransactionItem({
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.icon,
    required this.iconColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: EdgeInsets.all(12),
          color: AppColors.bgSecondary,
          child: Icon(icon, color: iconColor, size: 20),
        ),
      ),
      title: Text(title,
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w700,
          )),
      subtitle: Text(subtitle,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textMuted,
          )),
      trailing: Text(amount,
          style: AppTextStyles.bodySmall.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.accentRed)),
    );
  }
}
