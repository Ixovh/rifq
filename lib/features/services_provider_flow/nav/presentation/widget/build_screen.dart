import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rifq/features/services_provider_flow/home/presentation/cubit/home_cubit.dart';
import 'package:rifq/features/services_provider_flow/home/presentation/pages/provider_home_screen.dart';
import 'package:rifq/features/services_provider_flow/profile/presentation/cubit/provider_profile_cubit.dart';
import 'package:rifq/features/services_provider_flow/profile/presentation/pages/provider_profile_screen.dart';

class BuildScreen extends StatelessWidget {
  const BuildScreen({super.key, required this.context, required this.index});

  final BuildContext context;
  final int index;

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        return BlocProvider.value(
          value: context.read<ProviderHomeCubit>(),
          child: const ProviderHomeScreen(),
        );
      case 1:
        return BlocProvider.value(
          value: context.read<ProviderProfileCubit>(),
          child: const ProviderProfileScreen(),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
