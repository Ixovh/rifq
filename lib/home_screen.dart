import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rifq/core/routes/base_routes.dart';
import 'package:rifq/core/theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.primary300,
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.go(Routes.adoption);
          },
          child: Text('adoption'),
        ),
      ),
    );
  }
}
