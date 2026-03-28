import 'package:flutter/material.dart';
import '../widgets/app_bottom_nav.dart';

class ShellScreen extends StatelessWidget {
  final int currentIndex;
  final Widget child;
  final ValueChanged<int> onNavigate;

  const ShellScreen({
    super.key,
    required this.currentIndex,
    required this.child,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: child,
      bottomNavigationBar: AppBottomNav(
        currentIndex: currentIndex,
        onTap: onNavigate,
      ),
    );
  }
}
