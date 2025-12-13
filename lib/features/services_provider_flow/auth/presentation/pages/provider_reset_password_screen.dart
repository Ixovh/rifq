import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:rifq/core/routes/base_routes.dart';
import 'package:rifq/core/theme/app_theme.dart';
import 'package:rifq/features/owner_flow/auth/presentation/widgets/container_button.dart';
import 'package:rifq/features/owner_flow/auth/presentation/widgets/custom_bottom_sheet.dart';
import 'package:rifq/features/owner_flow/auth/presentation/widgets/custom_form_builder_text_field.dart';
import 'package:rifq/features/services_provider_flow/auth/presentation/cubit/provider_auth_cubit.dart';

class ProviderResetPasswordScreen extends StatelessWidget {
  const ProviderResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final cubit = context.read<ProviderAuthCubit>();
        return BlocConsumer<ProviderAuthCubit, ProviderAuthState>(
          listener: (context, state) {
            switch (state) {
              case ProviderAuthPasswordResetSuccessState _:
                context.push(Routes.providerAuth);
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
            final isLoading = state is ProviderAuthLoadingState;
            return Scaffold(
              backgroundColor: context.neutral100,
              resizeToAvoidBottomInset: false,
              bottomSheet: CustomBottomSheet(
                content: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Reset Password',
                          style: context.h5.copyWith(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w500,
                            color: context.primary400,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Please enter your new password to proceed.',
                          style: context.body2.copyWith(
                            color: context.neutral800,
                          ),
                        ),
                        SizedBox(height: 24.h),
                        FormBuilder(
                          key: cubit.resetVerfiyPasswordFormKey,
                          child: CustomFormBuilderTextField(
                            name: 'password',
                            label: 'Password',
                            iconData: CupertinoIcons.lock_fill,
                            controller: cubit.resetPasswordController,
                            isPassword: true,
                            validators: [
                              FormBuilderValidators.required(
                                errorText:
                                    'Incorrect password. Please try again.',
                              ),
                              FormBuilderValidators.minLength(
                                6,
                                errorText:
                                    'Includes at least one number or symbol (e.g., @, #, \$, !).',
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 32.h),
                        ContainerButton(
                          label: 'verfiy',
                          containerColor: context.primary300,
                          textColor: context.neutral100,
                          fontSize: 20,
                          onTap: () async {
                            if (cubit.resetVerfiyPasswordFormKey.currentState
                                    ?.saveAndValidate() ??
                                false) {
                              await cubit.resetPassword(
                                newPassword: cubit.resetPasswordController.text,
                              );
                            }
                          },
                        ),
                        SizedBox(height: 12.h),
                        Spacer(),
                      ],
                    ),
                    if (isLoading)
                      Center(
                        child: CircularProgressIndicator(
                          color: context.primary300,
                        ),
                      ),
                  ],
                ),
              ),
              body: SafeArea(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: SvgPicture.asset('assets/icon/logo.svg'),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
