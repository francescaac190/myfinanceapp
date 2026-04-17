import 'package:flutter/material.dart';
import '../../../../core/index.dart';
import '../widgets/balance_card.dart';
import '../widgets/home_header.dart';

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
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Spending this month',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(height: 12),
                    Text('\$567.89',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textMuted,
                        )),
                  ],
                ),
                SizedBox(height: 12),
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Color(0xFF8B5CF6), Color(0xFF3B82F6)],
                  ).createShader(bounds),
                  blendMode: BlendMode.srcIn,
                  child: LinearProgressIndicator(
                    value: 0.61,
                    backgroundColor: const Color(0xFF1E2536),
                    valueColor: const AlwaysStoppedAnimation(Colors.white),
                  ),
                ),
                // ProgressIndicatorTheme(
                //   data: ProgressIndicatorThemeData(
                //     color: AppColors.accentGreen,
                //     linearTrackColor: AppColors.bgCard,
                //     linearMinHeight: 8,
                //   ),
                //   child: LinearProgressIndicator(
                //     value: 0.45,
                //   ),
                // )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
