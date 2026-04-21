import 'package:flutter/material.dart';

import '../index.dart';

class GradientCard extends StatelessWidget {
  const GradientCard({
    super.key,
    required this.child,
  });

  final Widget child;

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
        child: child);
  }
}
