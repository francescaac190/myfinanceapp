import 'package:flutter/material.dart';

import 'package:myfinanceapp/core/index.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    required this.userName, super.key,
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
            SizedBox(height: 4),
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
                borderRadius: BorderRadius.circular(100),
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
            ),),
      ],
    );
  }
}
