import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:myfinanceapp/core/index.dart';

class AppBottomBar extends StatelessWidget {
  const AppBottomBar({required this.currentIndex, super.key});
  final int currentIndex;

  static const List<_NavItemData> _items = [
    _NavItemData(icon: Icons.home_outlined, label: 'Home'),
    _NavItemData(icon: Icons.request_quote_outlined, label: 'Bills'),
    _NavItemData(icon: Icons.savings_outlined, label: 'Savings'),
    _NavItemData(icon: Icons.wallet_outlined, label: 'Wallets'),
    _NavItemData(icon: Icons.person_3_outlined, label: 'Profile'),
  ];

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/home');
      case 1:
        context.go('/bills');
      case 2:
        context.go('/savings');
      case 3:
        context.go('/wallet');
      case 4:
        context.go('/profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ClipRRect(
          borderRadius: AppRadius.allFull,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.bgCardAlt,
              borderRadius: AppRadius.allFull,
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.08),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_items.length, (i) {
                return Expanded(
                  child: _NavItem(
                    item: _items[i],
                    isSelected: currentIndex == i,
                    onTap: () => _onTap(context, i),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });
  final _NavItemData item;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOutCubic,
            width: 70,
            height: 60,
            margin: const EdgeInsets.symmetric(vertical: 4),
            // alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected ? AppColors.accentBlue : Colors.transparent,
              shape: BoxShape.circle,
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: AppColors.accentBlue.withValues(alpha: 0.4),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 4),
                  child: Icon(
                    item.icon,
                    size: 22,
                    color:
                        isSelected ? AppColors.bgPrimary : AppColors.textMuted,
                  ),
                ),
                Text(
                  item.label.toUpperCase(),
                  style: AppTextStyles.navLabel.copyWith(
                    color:
                        isSelected ? AppColors.bgPrimary : AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItemData {
  const _NavItemData({required this.icon, required this.label});
  final IconData icon;
  final String label;
}
