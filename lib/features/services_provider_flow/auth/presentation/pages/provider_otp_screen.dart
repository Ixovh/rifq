import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:rifq/core/routes/base_routes.dart';
import 'package:rifq/core/theme/app_theme.dart';
import 'package:rifq/core/common/widgets/lottie_loading/lottie_loding.dart';
import 'package:rifq/features/owner_flow/auth/presentation/widgets/container_button.dart';
import 'package:rifq/features/owner_flow/auth/presentation/widgets/custom_bottom_sheet.dart';
import 'package:rifq/features/services_provider_flow/auth/presentation/cubit/provider_auth_cubit.dart';

class ProviderOtpScreen extends StatelessWidget {
  const ProviderOtpScreen({super.key, this.isResetPassword = false});
  final bool? isResetPassword;
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final cubit = context.read<ProviderAuthCubit>();
        return BlocConsumer<ProviderAuthCubit, ProviderAuthState>(
          listener: (context, state) {
            switch (state) {
              case ProviderAuthVerifyAccountSuccessState _:
                context.push(Routes.providerSelectServiceTypes, extra: cubit);
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
                          isResetPassword!
                              ? 'Reset Password'
                              : 'Email Verification',
                          style: context.h5.copyWith(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w500,
                            color: context.primary400,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'We have sent an OTP to your email address',
                          style: context.body2.copyWith(
                            color: context.neutral800,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          cubit.email!,
                          style: context.body2.copyWith(
                            fontWeight: FontWeight.w500,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Please enter the OTP below',
                          style: context.body2.copyWith(
                            color: context.neutral800,
                          ),
                        ),
                        SizedBox(height: 24.h),
                        Pinput(
                          defaultPinTheme: PinTheme(
                            width: 50.h,
                            height: 60.h,
                            decoration: BoxDecoration(
                              border: Border.all(color: context.primary500),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          length: 6,
                          focusedPinTheme: PinTheme(
                            width: 50.h,
                            height: 60.h,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color.fromARGB(255, 0, 0, 0),
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onCompleted: (pin) async {
                            if (!isResetPassword!) {
                              await cubit.verifyAccount(
                                email: cubit.email!,
                                otp: pin,
                              );
                            } else {
                              context.push(Routes.resetPassword, extra: cubit);
                            }
                          },
                        ),
                        Spacer(),
                        ContainerButton(
                          label: 'Cancel',
                          containerColor: context.neutral100,
                          textColor: context.primary300,
                          fontSize: 20,
                          onTap: () {
                            if (context.canPop()) {
                              context.pop();
                            }
                          },
                        ),
                      ],
                    ),
                    if (isLoading) LottieLoding(),
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
