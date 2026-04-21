import 'package:flutter/material.dart';

import 'package:myfinanceapp/core/index.dart';
import 'package:myfinanceapp/features/home/presentation/widgets/transaction_list.dart';

class BillsList extends StatelessWidget {
  const BillsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Upcoming Bills',
          style: AppTextStyles.titleSmall,
        ),
        AppSpacing.gapMd,
        Container(
          // height: 100,
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
                title: 'Electricity Bill',
                subtitle: 'Due in 3 days',
                amount: r'$60.00',
                icon: Icons.bolt_outlined,
                iconColor: AppColors.accentAmber,
              ),
              TransactionItem(
                title: 'Netflix Subscription',
                subtitle: 'Due in 5 days',
                amount: r'$15.00',
                icon: Icons.tv_outlined,
                iconColor: AppColors.accentPurple,
              ),
              TransactionItem(
                title: 'Car Insurance',
                subtitle: 'Due in 10 days',
                amount: r'$45.00',
                icon: Icons.directions_car_outlined,
                iconColor: AppColors.accentRed,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
