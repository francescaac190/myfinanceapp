import 'package:flutter/material.dart';

import '../../../../core/index.dart';
import '../../../home/presentation/widgets/transaction_list.dart';

class BillsList extends StatelessWidget {
  const BillsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Upcoming Bills',
          style: AppTextStyles.titleSmall,
        ),
        SizedBox(height: 8),
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
                title: 'Electricity Bill',
                subtitle: 'Due in 3 days',
                amount: '\$60.00',
                icon: Icons.bolt_outlined,
                iconColor: AppColors.accentAmber,
              ),
              TransactionItem(
                title: 'Netflix Subscription',
                subtitle: 'Due in 5 days',
                amount: '\$15.00',
                icon: Icons.tv_outlined,
                iconColor: AppColors.accentPurple,
              ),
              TransactionItem(
                title: 'Car Insurance',
                subtitle: 'Due in 10 days',
                amount: '\$45.00',
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
