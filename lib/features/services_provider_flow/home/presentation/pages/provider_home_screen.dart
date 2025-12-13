import 'package:flutter/material.dart';
import 'package:rifq/core/theme/app_theme.dart';

class ProviderHomeScreen extends StatelessWidget {
  const ProviderHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.background,
      body: Center(child: Text('Provider Home')),
    );
  }
}
