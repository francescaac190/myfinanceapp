import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfinanceapp/core/index.dart';
import 'package:myfinanceapp/features/bills/domain/entities/bills.dart';
import 'package:myfinanceapp/features/bills/presentation/bloc/bills_bloc.dart';
import 'package:myfinanceapp/features/bills/presentation/widgets/billls_list.dart';

class BillsScreen extends StatelessWidget {
  const BillsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BillsBloc, BillsState>(
      builder: (context, state) {
        switch (state.status) {
          case BillsStatus.initial:
          case BillsStatus.loading:
            return const _BillsSkeleton();
          case BillsStatus.failure:
            return _BillsError(
              message: state.errorMessage ?? 'Something went wrong.',
            );
          case BillsStatus.success:
            return _BillsContent(bills: state.bills);
        }
      },
    );
  }
}

class _BillsSkeleton extends StatelessWidget {
  const _BillsSkeleton();

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: AppSpacing.screen,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppSkeleton(width: 120, height: 16),
                      AppSpacing.gapSm,
                      AppSkeleton(width: 180, height: 28),
                    ],
                  ),
                ),
                AppSpacing.gapMd,
                CircleAvatar(radius: 20),
              ],
            ),
            AppSpacing.gapLg,
            // const BillsListSkeleton(),
          ],
        ),
      ),
    );
  }
}

class _BillsError extends StatelessWidget {
  const _BillsError({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message),
    );
  }
}

class _BillsContent extends StatelessWidget {
  const _BillsContent({required this.bills});

  final List<Bills> bills;

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
                  AppSpacing.gapXs,
                  Text(
                    r'$120.00',
                    style: AppTextStyles.displayMedium,
                  ),
                  AppSpacing.gapXs,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        r'Paid: $80.00',
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.accentGreen,
                        ),
                      ),
                      Text(
                        r'Pending: $1080.00',
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.accentAmber,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            DonationPieChart(
              items: [
                PieChartItem(
                  label: 'Rent',
                  value: 4500,
                  color: AppColors.accentBlue,
                ),
                PieChartItem(
                  label: 'Utilities',
                  value: 2800,
                  color: AppColors.accentPurple,
                ),
                PieChartItem(
                  label: 'Subscriptions',
                  value: 3200,
                  color: AppColors.accentGreen,
                ),
                PieChartItem(
                  label: 'Insurance',
                  value: 1500,
                  color: AppColors.accentAmber,
                ),
              ],
            ),
            AppSpacing.gapMd,
            BillsList(),
          ],
        ),
      ),
    );
  }
}
