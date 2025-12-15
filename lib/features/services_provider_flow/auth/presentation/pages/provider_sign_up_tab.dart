import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:rifq/core/theme/app_theme.dart';
import 'package:rifq/features/services_provider_flow/auth/presentation/cubit/provider_auth_cubit.dart';
import 'package:rifq/features/owner_flow/auth/presentation/widgets/container_button.dart';
import 'package:rifq/features/owner_flow/auth/presentation/widgets/custom_form_builder_text_field.dart';

class ProviderSignUpTab extends StatelessWidget {
  const ProviderSignUpTab({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProviderAuthCubit>();

    return BlocBuilder<ProviderAuthCubit, ProviderAuthState>(
      builder: (context, state) {
        final isLoading = state is ProviderAuthLoadingState;
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24.h),
              Text(
                'Please fill in your essential information to continue.',
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
                    SizedBox(height: 24.h),
                    CustomFormBuilderTextField(
                      name: 'commercialRegister',
                      label: 'Commercial Register',
                      iconData: CupertinoIcons.lock_fill,
                      controller: cubit.commercialRegisterNumberController,
                      validators: [
                        FormBuilderValidators.required(
                          errorText:
                              'Incorrect commercial register. Please try again.',
                        ),
                        FormBuilderValidators.minLength(
                          10,
                          errorText: 'Commercial register must be 10 digits.',
                        ),
                      ],
                    ),

                    SizedBox(height: 24.h),
                    CustomFormBuilderTextField(
                      name: 'phoneNumber',
                      label: 'Phone Number',
                      iconData: CupertinoIcons.phone_solid,
                      controller: cubit.phoneNumberController,
                      validators: [
                        FormBuilderValidators.required(
                          errorText:
                              'Incorrect phone number. Please try again.',
                        ),
                        FormBuilderValidators.minLength(
                          10,
                          errorText: 'Phone number must be 10 digits.',
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    CustomFormBuilderTextField(
                      name: 'location',
                      label: 'Location',
                      iconData: CupertinoIcons.location_solid,
                      controller: cubit.locationController,
                      validators: [
                        FormBuilderValidators.required(
                          errorText: 'Incorrect location. Please try again.',
                        ),
                        FormBuilderValidators.minLength(
                          4,
                          errorText: 'Location must be 5 characters.',
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    CustomFormBuilderTextField(
                      name: 'locationUrl',
                      label: 'Location URL',
                      iconData: CupertinoIcons.link,
                      controller: cubit.locationUrlController,
                      validators: [
                        FormBuilderValidators.required(
                          errorText:
                              'Incorrect location URL. Please try again.',
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
                      commercialRegister: int.parse(
                        cubit.commercialRegisterNumberController.text,
                      ),
                      location: cubit.locationController.text,
                      phoneNumber: cubit.phoneNumberController.text,
                      locationUrl: cubit.locationUrlController.text,
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
