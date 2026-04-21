import 'package:flutter/material.dart';
import 'package:myfinanceapp/core/index.dart';
import 'package:myfinanceapp/features/home/presentation/widgets/balance_card.dart';
import 'package:myfinanceapp/features/home/presentation/widgets/home_header.dart';
import 'package:myfinanceapp/features/home/presentation/widgets/spending_balance.dart';
import 'package:myfinanceapp/features/home/presentation/widgets/spending_card.dart';
import 'package:myfinanceapp/features/home/presentation/widgets/transaction_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            HomeHeader(userName: 'Francesca'),
            AppSpacing.gapLg,
            BalanceCard(
              balance: r'$1,234.56',
              change: ' +5.4%',
            ),
            AppSpacing.gapLg,
            SpendingBalance(),
            AppSpacing.gapMd,
            SpendingCardList(),
            AppSpacing.gapLg,
            TransactionList(),
          ],
        ),
      ),
    );
  }
}
