import 'package:flutter/material.dart';
import 'package:myfinanceapp/core/index.dart';
import 'package:myfinanceapp/features/bills/presentation/widgets/billls_list.dart';

class BillsScreen extends StatelessWidget {
  const BillsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'Bills',
            style: AppTextStyles.headlineSmall,
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GradientCard(
                  child: Column(
                children: [
                  Text(
                    'TOTAL DUE THIS MONTH',
                    style: AppTextStyles.bodySmall
                        .copyWith(color: AppColors.textMuted),
                  ),
                  SizedBox(height: 8),
                  Text(
                    r'$120.00',
                    style: AppTextStyles.displayMedium,
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(r'Paid: $80.00',
                          style: AppTextStyles.bodyMedium.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.accentGreen,),),
                      Text(r'Pending: $1080.00',
                          style: AppTextStyles.bodyMedium.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.accentAmber,),),
                    ],
                  ),
                ],
              ),),
              DonationPieChart(
                // size: 120,
                items: [
                  PieChartItem(
                      label: 'Rent', value: 4500, color: AppColors.accentBlue,),
                  PieChartItem(
                      label: 'Utilities',
                      value: 2800,
                      color: AppColors.accentPurple,),
                  PieChartItem(
                      label: 'Subscriptions',
                      value: 3200,
                      color: AppColors.accentGreen,),
                  PieChartItem(
                      label: 'Insurance',
                      value: 1500,
                      color: AppColors.accentAmber,),
                ],
              ),
              SizedBox(height: 16),
              BillsList(),
            ],
          ),
        ),);
  }
}
