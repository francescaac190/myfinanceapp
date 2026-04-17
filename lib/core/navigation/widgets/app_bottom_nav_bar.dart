import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../index.dart';

class AppBottomBar extends StatelessWidget {
  final int currentIndex;
  const AppBottomBar({super.key, required this.currentIndex});

  final List<_NavItemData> _items = const [
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
        break;
      case 1:
        context.go('/home');
        break;
      case 2:
        context.go('/home');
        break;
      case 3:
        context.go('/home');
        break;
      case 4:
        context.go('/home');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        minimum: const EdgeInsets.only(bottom: 16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(48),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.bgCardAlt,
                borderRadius: BorderRadius.circular(48),
                border: Border.all(
                  color: Colors.white.withOpacity(0.08),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
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
        ));
  }
}

class _NavItem extends StatelessWidget {
  final _NavItemData item;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

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
                        color: AppColors.accentBlue.withOpacity(0.4),
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
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    letterSpacing: 0.5,
                    color:
                        isSelected ? AppColors.bgPrimary : AppColors.textMuted,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItemData {
  final IconData icon;
  final String label;

  const _NavItemData({required this.icon, required this.label});
}
