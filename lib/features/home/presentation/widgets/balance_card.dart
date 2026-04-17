import 'package:flutter/material.dart';
import '../../../../core/index.dart';

class BalanceCard extends StatelessWidget {
  final String balance;
  final String change;
  const BalanceCard({
    super.key,
    required this.balance,
    required this.change,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.bgPrimary,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.borderCard,
          width: 1,
        ),
        gradient: const RadialGradient(
          center: Alignment.topRight,
          radius: 1.4,
          colors: [
            Color(0xFF2A4A7F), // azul claro (el "punto de luz")
            Color(0xFF1A2847), // azul medio
            Color(0xFF0F1829), // azul muy oscuro (casi negro)
          ],
          stops: [0.0, 0.5, 1.0],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'TOTAL BALANCE',
            style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: AppColors.textMuted),
          ),
          SizedBox(height: 12),
          Text(
            balance,
            style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Icon(
                Icons.trending_up_rounded,
                size: 16,
                color: AppColors.accentGreen,
              ),
              Text(
                '$change this month',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.accentGreen),
              ),
            ],
          )
        ],
      ),
    );
  }
}
