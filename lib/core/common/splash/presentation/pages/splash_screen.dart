import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rifq/core/routes/base_routes.dart';
import 'package:rifq/core/theme/app_theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    await Future.delayed(const Duration(seconds: 3));

    final session =
        Supabase.instance.client.auth.currentUser; //يشيك اذا اليوزر عنده توكن

    if (session == null) {
      if (mounted) {
        context.go(Routes.choosePath);
      }
    }
    if (session != null) {
      final provider = await Supabase.instance.client
          .from('providers')
          .select('*')
          .eq('id', session.id)
          .maybeSingle();
      final user = await Supabase.instance.client
          .from('users')
          .select('*')
          .eq('id', session.id)
          .maybeSingle();
      if (user != null) {
        if (mounted) {
          context.go(Routes.navbar);
        }
      } else if (provider != null) {
        if (mounted) {
          context.go(Routes.providerNavbar);
        }
      }
    } else {
      if (mounted) {
        context.go(Routes.choosePath);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("RIFQ", style: context.h1.copyWith(color: context.primary)),
      ),
    );
  }
}
