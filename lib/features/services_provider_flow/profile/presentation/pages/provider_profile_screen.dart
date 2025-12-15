import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rifq/core/routes/base_routes.dart';
import 'package:rifq/core/theme/app_theme.dart';
import 'package:rifq/features/services_provider_flow/profile/domain/entities/provider_profile_entity.dart';
import 'package:rifq/features/services_provider_flow/profile/presentation/cubit/provider_profile_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProviderProfileScreen extends StatelessWidget {
  const ProviderProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authId = Supabase.instance.client.auth.currentUser?.id ?? '';
    return Scaffold(
      backgroundColor: context.background,
      appBar: AppBar(
        backgroundColor: context.background,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: BlocListener<ProviderProfileCubit, ProviderProfileState>(
        listener: (context, state) {
          if (state is ProviderProfileUpdated) {
            context.read<ProviderProfileCubit>().getProviderProfile(authId);
          }
        },
        child: BlocBuilder<ProviderProfileCubit, ProviderProfileState>(
          builder: (context, state) {
            if (state is ProviderProfileLoading) {
              return Center(
                child: CircularProgressIndicator(color: context.primary),
              );
            }
            ProviderProfileEntity? provider;
            if (state is ProviderProfileLoaded) {
              provider = state.provider;
            }
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    SizedBox(height: 10.h),
                    Center(
                      child: CircleAvatar(
                        radius: 60.r,
                        backgroundColor: context.primary100,
                        backgroundImage:
                            provider?.image != null &&
                                provider!.image!.isNotEmpty
                            ? NetworkImage(provider.image!)
                            : null,
                        child:
                            provider?.image == null || provider!.image!.isEmpty
                            ? Text(
                                provider != null
                                    ? provider.name[0].toUpperCase()
                                    : "?",
                                style: TextStyle(
                                  fontSize: 48.sp,
                                  color: Colors.white,
                                ),
                              )
                            : null,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          provider != null ? provider.name : "Loading...",
                          style: context.h5.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        IconButton(
                          onPressed: () {
                            context.push(
                              Routes.providerEditProfile,
                              extra: context.read<ProviderProfileCubit>(),
                            );
                          },
                          icon: Icon(Icons.edit_outlined),
                        ),
                      ],
                    ),
                    SizedBox(height: 18.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          enabled: false,
                          decoration: InputDecoration(
                            hintText: provider?.email ?? "Email",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18.r),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          enabled: false,
                          decoration: InputDecoration(
                            hintText: provider?.phone ?? "Phone",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18.r),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          enabled: false,
                          decoration: InputDecoration(
                            hintText: provider?.location ?? "Location",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18.r),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          enabled: false,
                          decoration: InputDecoration(
                            hintText:
                                provider?.commercialRegister ??
                                "Commercial Register",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18.r),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 32.h),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
