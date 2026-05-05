import 'package:flutter/material.dart';
import 'package:myfinanceapp/core/theme/app_colors.dart';
import 'package:myfinanceapp/core/theme/app_radius.dart';

class AppSkeleton extends StatefulWidget {
  const AppSkeleton({
    required this.width,
    required this.height,
    this.borderRadius = AppRadius.md,
    super.key,
  });

  final double width;
  final double height;
  final double borderRadius;

  @override
  State<AppSkeleton> createState() => _AppSkeletonState();
}

class _AppSkeletonState extends State<AppSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            final shimmerPosition = _controller.value * 2 - 1;
            return LinearGradient(
              begin: Alignment(-1 + shimmerPosition, -0.4),
              end: Alignment(1 + shimmerPosition, 0.4),
              colors: const [
                AppColors.bgCardAlt,
                Color(0xFF334155),
                AppColors.bgCardAlt,
              ],
              stops: const [0.2, 0.5, 0.8],
            ).createShader(bounds);
          },
          child: child,
        );
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.bgCardAlt,
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        child: SizedBox(width: widget.width, height: widget.height),
      ),
    );
  }
}
