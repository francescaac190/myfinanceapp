import 'package:flutter/material.dart';
import '../widgets/balance_card.dart';
import '../widgets/home_header.dart';
import '../widgets/spending_balance.dart';
import '../widgets/spending_card.dart';
import '../widgets/transaction_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            HomeHeader(userName: 'Francesca'),
            SizedBox(height: 24),
            BalanceCard(
              balance: '\$1,234.56',
              change: ' +5.4%',
            ),
            SizedBox(height: 24),
            SpendingBalance(),
            SizedBox(height: 16),
            SpendingCardList(),
            SizedBox(height: 24),
            TransactionList(),
          ],
        ),
      ),
    );
  }
}
