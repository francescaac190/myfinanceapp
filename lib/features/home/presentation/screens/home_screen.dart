import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfinanceapp/core/index.dart';
import 'package:myfinanceapp/features/home/domain/entities/home_overview_entity.dart';
import 'package:myfinanceapp/features/home/presentation/bloc/home_overview_bloc.dart';
import 'package:myfinanceapp/features/home/presentation/widgets/balance_card.dart';
import 'package:myfinanceapp/features/home/presentation/widgets/home_header.dart';
import 'package:myfinanceapp/features/home/presentation/widgets/quick_actions.dart';
import 'package:myfinanceapp/features/home/presentation/widgets/spending_balance.dart';
import 'package:myfinanceapp/features/home/presentation/widgets/spending_card.dart';
import 'package:myfinanceapp/features/home/presentation/widgets/transaction_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeOverviewBloc, HomeOverviewState>(
      builder: (context, state) {
        if (state is HomeOverviewLoading) {
          return const _HomeOverviewSkeleton();
        }

        if (state is HomeOverviewFailure) {
          return _HomeOverviewError(message: state.message);
        }

        if (state is HomeOverviewLoaded) {
          return _HomeOverviewContent(overview: state.overview);
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class _HomeOverviewSkeleton extends StatelessWidget {
  const _HomeOverviewSkeleton();

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
                AppSkeleton(
                  width: 48,
                  height: 48,
                  borderRadius: AppRadius.full,
                ),
              ],
            ),
            AppSpacing.gapLg,
            AppSkeleton(
              width: double.infinity,
              height: 180,
              borderRadius: AppRadius.heroCard,
            ),
            AppSpacing.gapLg,
            AppSkeleton(width: 170, height: 24),
            AppSpacing.gapMd,
            AppSkeleton(
              width: double.infinity,
              height: 120,
              borderRadius: AppRadius.card,
            ),
            AppSpacing.gapLg,
            AppSkeleton(width: 150, height: 24),
            AppSpacing.gapMd,
            AppSkeleton(
              width: double.infinity,
              height: 68,
              borderRadius: AppRadius.card,
            ),
            AppSpacing.gapMd,
            AppSkeleton(
              width: double.infinity,
              height: 68,
              borderRadius: AppRadius.card,
            ),
            AppSpacing.gapMd,
            AppSkeleton(
              width: double.infinity,
              height: 68,
              borderRadius: AppRadius.card,
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeOverviewContent extends StatelessWidget {
  const _HomeOverviewContent({required this.overview});

  final HomeOverview overview;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: RefreshIndicator(
        onRefresh: () async {
          context
              .read<HomeOverviewBloc>()
              .add(const HomeOverviewRefreshRequested());
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              HomeHeader(
                userName: overview.greeting.name,
                timeOfDay: overview.greeting.timeOfDay,
              ),
              AppSpacing.gapLg,
              BalanceCard(
                balance: '\$${overview.totalBalance}',
                change: '+0.0%',
              ),
              AppSpacing.gapLg,
              SpendingBalance(total: overview.spendingThisMonth.total),
              AppSpacing.gapMd,
              SpendingCardList(
                categories: overview.spendingThisMonth.categories,
              ),
              AppSpacing.gapMd,
              QuickActions(),
              AppSpacing.gapLg,
              TransactionList(transactions: overview.recentTransactions),
              AppSpacing.gapXxl,
              AppSpacing.gapXxl,
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeOverviewError extends StatelessWidget {
  const _HomeOverviewError({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                message,
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textMuted,
                ),
              ),
              AppSpacing.gapMd,
              AppButton.primary(
                label: 'Try again',
                onPressed: () => context
                    .read<HomeOverviewBloc>()
                    .add(const HomeOverviewRequested()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
