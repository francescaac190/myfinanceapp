import 'package:flutter/material.dart';

import 'package:myfinanceapp/core/index.dart';

class AppShell extends StatelessWidget {
  const AppShell({required this.child, required this.currentIndex, super.key});
  final Widget child;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: AppBottomBar(currentIndex: currentIndex),
      // floatingActionButton: AppFloatingButton(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
