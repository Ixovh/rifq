import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:rifq/features/owner_flow/auth/presentation/pages/auth_tab_bar.dart';
import 'package:rifq/features/owner_flow/auth/presentation/widgets/container_button.dart';
import 'package:rifq/features/owner_flow/auth/presentation/widgets/custom_bottom_sheet.dart';
import 'package:rifq/features/owner_flow/auth/presentation/widgets/custom_form_builder_text_field.dart';
import '../../../../../core/theme/app_theme.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      backgroundColor: context.neutral100,
      resizeToAvoidBottomInset: false,
      bottomSheet: CustomBottomSheet(
        controllers: [emailController, passwordController],
        formKeys: [loginFormKey],
        content: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              AuthTabBar(), // this widget is in separate file
              Expanded(
                child: TabBarView(
                  children: [
                    Column(
                      crossAxisAlignment: .start,
                      children: [
                        SizedBox(height: 24.h),
                        Text(
                          'Please enter your email and Password.',
                          style: context.body1.copyWith(fontSize: 16.sp),
                        ),
                        SizedBox(height: 24.h),
                        FormBuilder(
                          key: loginFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomFormBuilderTextField(
                                name: 'email',
                                label: 'Email',
                                iconData: CupertinoIcons.mail_solid,
                                controller: emailController,
                                validators: [
                                  FormBuilderValidators.required(),
                                  FormBuilderValidators.email(),
                                ],
                              ),
                              SizedBox(height: 24.h),
                              CustomFormBuilderTextField(
                                name: 'password',
                                label: 'Password',
                                iconData: CupertinoIcons.lock_fill,
                                controller: passwordController,
                                isPassword: true,
                                validators: [
                                  FormBuilderValidators.required(),
                                  FormBuilderValidators.minLength(6),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 8.h),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Forgot password?',
                            style: context.body3.copyWith(
                              color: context.primary300,
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        ContainerButton(
                          label: 'Log in',
                          containerColor: context.primary300,
                          textColor: context.neutral100,
                          fontSize: 20,
                        ),
                      ],
                    ),
                    /*

                      SIGNUP

                    */
                    Column(
                      crossAxisAlignment: .start,
                      children: [
                        SizedBox(height: 24.h),
                        Text(
                          'Please fill in your details to continue.',
                          style: context.body1.copyWith(fontSize: 16.sp),
                        ),
                        SizedBox(height: 24.h),
                        FormBuilder(
                          key: sinUPFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomFormBuilderTextField(
                                name: 'name',
                                label: 'name',
                                iconData: CupertinoIcons.person_alt,
                                controller: nameController,
                              ),
                              SizedBox(height: 24.h),

                              CustomFormBuilderTextField(
                                name: 'email',
                                label: 'Email',
                                iconData: CupertinoIcons.mail_solid,
                                controller: emailController,
                                validators: [
                                  FormBuilderValidators.required(),
                                  FormBuilderValidators.email(),
                                ],
                              ),
                              SizedBox(height: 24.h),

                              CustomFormBuilderTextField(
                                name: 'password',
                                label: 'Password',
                                iconData: CupertinoIcons.lock_fill,
                                controller: passwordController,
                                isPassword: true,
                                validators: [
                                  FormBuilderValidators.required(),
                                  FormBuilderValidators.minLength(6),
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
                                style: context.body3.copyWith(
                                  color: context.primary300,
                                ),
                              ),
                              TextSpan(
                                text: 'and ',
                                style: context.body3.copyWith(
                                  color: const Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                              TextSpan(
                                text: 'Privacy Policy',
                                style: context.body3.copyWith(
                                  color: context.primary300,
                                ),
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: SvgPicture.asset('assets/icon/logo.svg'),
        ),
      ),
    );
  }
}
