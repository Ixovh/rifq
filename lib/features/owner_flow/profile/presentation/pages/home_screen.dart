import 'package:flutter/material.dart';
import 'package:rifq/core/theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.primary300,
      body: Text('welcome home'),
    );
  }
}