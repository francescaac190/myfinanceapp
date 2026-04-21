import 'package:flutter/material.dart';

import 'package:myfinanceapp/core/index.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    required this.userName,
    super.key,
  });
  final String userName;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good Morning,',
              style:
                  AppTextStyles.bodyLarge.copyWith(color: AppColors.textMuted),
            ),
            AppSpacing.gapXs,
            Text(
              userName,
              style: AppTextStyles.headlineSmall,
            ),
          ],
        ),
        IconButton(
          onPressed: () {
            print('Notification Icon Pressed');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.bgCard,
            shape: RoundedRectangleBorder(
              borderRadius: AppRadius.allFull,
              side: BorderSide(
                color: AppColors.borderCard,
              ),
            ),
            padding: const EdgeInsets.all(12),
          ),
          icon: const Icon(
            Icons.notifications_outlined,
            color: AppColors.textSecondary,
            size: 20,
          ),
        ),
      ],
    );
  }
}
