import 'package:flutter/material.dart';
import 'package:myfinanceapp/core/index.dart';
import 'package:myfinanceapp/features/home/domain/entities/home_overview_entity.dart';

class SpendingCardList extends StatelessWidget {
  const SpendingCardList({
    required this.categories,
    super.key,
  });

  final List<CategoryElement> categories;

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.bgCard,
          borderRadius: AppRadius.allMd,
          border: Border.all(color: AppColors.borderCard),
        ),
        child: Text(
          'No spending yet',
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textMuted,
          ),
        ),
      );
    }

    final visibleCategories = categories.take(3).toList();

    return Row(
      children: [
        for (var i = 0; i < visibleCategories.length; i++) ...[
          SpendingCard(category: visibleCategories[i]),
          if (i != visibleCategories.length - 1) AppSpacing.hGapSm,
        ],
      ],
    );
  }
}

class SpendingCard extends StatelessWidget {
  const SpendingCard({
    required this.category,
    super.key,
  });

  final CategoryElement category;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.bgCard,
          borderRadius: AppRadius.allMd,
          border: Border.all(
            color: AppColors.borderCard,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              category.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.bodySmall
                  .copyWith(color: AppColors.textSecondary),
            ),
            AppSpacing.gapXs,
            Text(
              '\$${category.amount}',
              style: AppTextStyles.titleSmall
                  .copyWith(color: AppColors.accentBlue, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
