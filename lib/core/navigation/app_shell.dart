import 'package:flutter/material.dart';

import '../index.dart';

class AppShell extends StatelessWidget {
  final Widget child;
  final int currentIndex;
  const AppShell({super.key, required this.child, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      extendBody: false,
      bottomNavigationBar: AppBottomBar(currentIndex: currentIndex),
      // floatingActionButton: AppFloatingButton(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
