import 'package:flutter/material.dart';
import 'package:myfinanceapp/core/index.dart';

class SpendingCardList extends StatelessWidget {
  const SpendingCardList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SpendingCard(),
        SizedBox(width: 12),
        SpendingCard(),
        SizedBox(width: 12),
        SpendingCard(),
      ],
    );
  }
}

class SpendingCard extends StatelessWidget {
  const SpendingCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        // width: 200,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.bgCard,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.borderCard,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Food',
                style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
            SizedBox(height: 4),
            Text('\$89.50',
                style: TextStyle(
                    color: AppColors.accentBlue,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
