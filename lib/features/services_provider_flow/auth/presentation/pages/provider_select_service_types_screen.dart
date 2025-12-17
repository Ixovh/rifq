import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rifq/core/routes/base_routes.dart';
import 'package:rifq/core/theme/app_theme.dart';
import 'package:rifq/core/common/widgets/lottie_loading/lottie_loding.dart';
import 'package:rifq/features/owner_flow/auth/presentation/widgets/container_button.dart';
import 'package:rifq/features/services_provider_flow/auth/presentation/cubit/provider_auth_cubit.dart';
import 'package:rifq/features/services_provider_flow/auth/presentation/widgets/build_service_type_option.dart';

class ProviderSelectServiceTypesScreen extends StatelessWidget {
  const ProviderSelectServiceTypesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProviderAuthCubit>();

    // Initialize on first build only if not already initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (cubit.providerId == null) {
        cubit.initializeServiceTypesSelection();
      }
    });

    return BlocConsumer<ProviderAuthCubit, ProviderAuthState>(
      listener: (context, state) {
        switch (state) {
          case ProviderAuthServiceTypesSelectedSuccessState _:
            context.push(Routes.providerSelectServiceItem, extra: cubit);
            break;
          case ProviderAuthErrorState _:
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.msg)));
            break;
          default:
            break;
        }
      },
      builder: (context, state) {
        final selectionState = state is ProviderAuthServiceTypesSelectionState
            ? state
            : null;

        // Get selected service types from state, or fallback to cubit's internal state
        final selectedServiceTypes =
            selectionState?.selectedServiceTypes ?? cubit.selectedServiceTypes;

        final isLoading = selectionState?.isLoadingProviderId ?? false;

        return Scaffold(
          backgroundColor: context.neutral100,
          appBar: AppBar(
            title: Text(
              'Select Service Types',
              style: context.h5.copyWith(color: context.primary400),
            ),
            backgroundColor: context.neutral100,
            elevation: 0,
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24.h),
                  Text(
                    'Please select at least one service type you want to provide:',
                    style: context.body1.copyWith(fontSize: 16.sp),
                  ),
                  SizedBox(height: 32.h),
                  Expanded(
                    child: isLoading
                        ? LottieLoding()
                        : ListView(
                            children: [
                              BuildServiceTypeOption(
                                context: context,
                                cubit: cubit,
                                id: 1,
                                title: 'Clinic',
                                icon: Icons.local_hospital,
                                isSelected: selectedServiceTypes.contains(1),
                              ),
                              SizedBox(height: 16.h),
                              BuildServiceTypeOption(
                                context: context,
                                cubit: cubit,
                                id: 2,
                                title: 'Store',
                                icon: Icons.store,
                                isSelected: selectedServiceTypes.contains(2),
                              ),
                              SizedBox(height: 16.h),
                              BuildServiceTypeOption(
                                context: context,
                                cubit: cubit,
                                id: 3,
                                title: 'External Service',
                                icon: Icons.build_circle,
                                isSelected: selectedServiceTypes.contains(3),
                              ),
                              SizedBox(height: 16.h),
                              BuildServiceTypeOption(
                                context: context,
                                cubit: cubit,
                                id: 4,
                                title: 'Boarding',
                                icon: Icons.home,
                                isSelected: selectedServiceTypes.contains(4),
                              ),
                            ],
                          ),
                  ),
                  SizedBox(height: 24.h),
                  ContainerButton(
                    label: 'Continue',
                    containerColor: context.primary300,
                    textColor: context.neutral100,
                    fontSize: 20,
                    isLoading: isLoading,
                    onTap: isLoading
                        ? null
                        : () => cubit.submitSelectedServiceTypes(),
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
