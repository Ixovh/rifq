import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:rifq/core/theme/app_theme.dart';
import 'package:rifq/features/owner_flow/auth/presentation/cubit/auth_cubit.dart';
import 'package:rifq/features/owner_flow/auth/presentation/widgets/container_button.dart';
import 'package:rifq/features/owner_flow/auth/presentation/widgets/custom_form_builder_text_field.dart';

class SignUpTab extends StatelessWidget {
  const SignUpTab({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();

    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final isLoading = state is AuthLoadingState;
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24.h),
              Text(
                'Please fill in your details to continue.',
                style: context.body1.copyWith(fontSize: 16.sp),
              ),
              SizedBox(height: 24.h),
              FormBuilder(
                key: cubit.sinUpFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomFormBuilderTextField(
                      name: 'name',
                      label: 'name',
                      iconData: CupertinoIcons.person_alt,
                      controller: cubit.nameController,
                    ),
                    SizedBox(height: 24.h),
                    CustomFormBuilderTextField(
                      name: 'email',
                      label: 'Email',
                      iconData: CupertinoIcons.mail_solid,
                      controller: cubit.sinUpEmailController,
                      validators: [
                        FormBuilderValidators.required(
                          errorText: '(e.g., username@example.com).',
                        ),
                        FormBuilderValidators.email(
                          errorText: '(e.g., username@example.com).',
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    CustomFormBuilderTextField(
                      name: 'password',
                      label: 'Password',
                      iconData: CupertinoIcons.lock_fill,
                      controller: cubit.sinUpPasswordController,
                      isPassword: true,
                      validators: [
                        FormBuilderValidators.required(
                          errorText: 'Incorrect password. Please try again.',
                        ),
                        FormBuilderValidators.minLength(
                          6,
                          errorText:
                              'Includes at least one number or symbol (e.g., @, #, \$, !).',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              ContainerButton(
                label: 'Sign up',
                containerColor: context.primary300,
                textColor: context.neutral100,
                fontSize: 20,
                isLoading: isLoading,
                onTap: () async {
                  if (cubit.sinUpFormKey.currentState?.saveAndValidate() ??
                      false) {
                    await cubit.signUp(
                      name: cubit.nameController.text,
                      email: cubit.sinUpEmailController.text,
                      password: cubit.sinUpPasswordController.text,
                    );
                  }
                },
              ),
              SizedBox(height: 24.h),
              RichText(
                text: TextSpan(
                  text: 'By continuing, you agree to our ',
                  style: context.body3.copyWith(
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Terms & Conditions ',
                      style: context.body3.copyWith(color: context.primary300),
                    ),
                    TextSpan(
                      text: 'and ',
                      style: context.body3.copyWith(
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: context.body3.copyWith(color: context.primary300),
                    ),
                    TextSpan(
                      text: '.',
                      style: context.body3.copyWith(
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
