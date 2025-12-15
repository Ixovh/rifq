import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq/core/common/widgets/button/custome_button_widgets.dart';
import 'package:rifq/core/theme/app_theme.dart';
import 'package:rifq/features/services_provider_flow/profile/domain/entities/provider_profile_entity.dart';
import 'package:rifq/features/services_provider_flow/profile/presentation/cubit/provider_profile_cubit.dart';

class ProviderEditProfileScreen extends StatelessWidget {
  const ProviderEditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProviderProfileCubit>();
    ProviderProfileEntity? currentProvider;
    final currentState = cubit.state;
    if (currentState is ProviderProfileLoaded) {
      currentProvider = currentState.provider;
    } else if (currentState is ProviderProfileUpdated) {
      currentProvider = currentState.provider;
    }

    return BlocConsumer<ProviderProfileCubit, ProviderProfileState>(
      listener: (context, state) {
        if (state is ProviderProfileUpdated) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Profile updated successfully'),
              backgroundColor: context.success,
            ),
          );
          Navigator.pop(context);
        }
        if (state is ProviderProfileError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: ${state.message}'),
              backgroundColor: context.error,
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is ProviderProfileLoading;
        final imageUrl = cubit.uploadedImageUrl;

        return Scaffold(
          backgroundColor: context.background,
          appBar: AppBar(
            backgroundColor: context.background,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              color: context.primary,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  SizedBox(height: 10.h),
                  Center(
                    child: GestureDetector(
                      onTap: currentProvider != null && !isLoading
                          ? () => cubit.pickAndUploadImage(currentProvider!.id)
                          : null,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          CircleAvatar(
                            radius: 60.r,
                            backgroundColor: context.primary100,
                            backgroundImage: imageUrl != null
                                ? NetworkImage(imageUrl)
                                : currentProvider?.image != null &&
                                      currentProvider!.image!.isNotEmpty
                                ? NetworkImage(currentProvider.image!)
                                : null,
                            child:
                                imageUrl == null &&
                                    (currentProvider?.image == null ||
                                        currentProvider!.image!.isEmpty)
                                ? Text(
                                    currentProvider != null
                                        ? currentProvider.name[0].toUpperCase()
                                        : "?",
                                    style: TextStyle(
                                      fontSize: 48.sp,
                                      color: Colors.white,
                                    ),
                                  )
                                : null,
                          ),
                          if (!isLoading && currentProvider != null)
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 40.w,
                                height: 40.h,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: context.primary,
                                  border: Border.all(
                                    color: context.background,
                                    width: 3,
                                  ),
                                ),
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 20.sp,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 32.h),
                  Form(
                    key: cubit.formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: cubit.nameController,
                          enabled: !isLoading,
                          decoration: InputDecoration(
                            label: Text("Name"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18.r),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter Your Name!";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 26.h),
                        TextFormField(
                          controller: cubit.emailController,
                          enabled: !isLoading,
                          decoration: InputDecoration(
                            label: Text("Email"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18.r),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter Your Email!";
                            } else if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                            ).hasMatch(value)) {
                              return "Enter a valid email!";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 26.h),
                        TextFormField(
                          controller: cubit.phoneController,
                          enabled: !isLoading,
                          decoration: InputDecoration(
                            label: Text("Phone"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18.r),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter Your Phone!";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 26.h),
                        TextFormField(
                          controller: cubit.locationController,
                          enabled: !isLoading,
                          decoration: InputDecoration(
                            label: Text("Location"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18.r),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter Your Location!";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 26.h),
                        TextFormField(
                          controller: cubit.commercialRegisterController,
                          enabled: !isLoading,
                          decoration: InputDecoration(
                            label: Text("Commercial Register"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18.r),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter Commercial Register!";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 26.h),
                        TextFormField(
                          controller: cubit.locationUrlController,
                          enabled: !isLoading,
                          decoration: InputDecoration(
                            label: Text("Location URL"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18.r),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter Location URL!";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 60.h),
                  isLoading
                      ? CircularProgressIndicator(color: context.primary)
                      : CustomeButtonWidgets(
                          titel: 'Update',
                          onPressed: () {
                            if (currentProvider != null) {
                              cubit.updateProfile(
                                currentProvider.id,
                                currentProvider,
                              );
                            }
                          },
                          buttonWidth: 366.w,
                          buttonhight: 58.h,
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
