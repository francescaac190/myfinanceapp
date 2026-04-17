import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppFloatingButton extends StatelessWidget {
  const AppFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        context.go('/add');
      },
      child: const Icon(Icons.add),
    );
  }
}
