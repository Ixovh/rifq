import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import '../../../../../core/theme/app_theme.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final keyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      backgroundColor: context.neutral100,
      resizeToAvoidBottomInset: false,
      bottomSheet: BottomSheet(
        enableDrag: false,
        onClosing: () {},
        backgroundColor: context.neutral100,
        builder: (context) {

          return Container(
            width: 402.w,
            height: keyboardVisible ? 670.h : 570.h,
            padding: EdgeInsets.all(20.r),
            decoration: BoxDecoration(
              border: Border.all(color: context.neutral400),
              borderRadius: BorderRadius.circular(50.r),
            ),
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(4.r),
                    decoration: BoxDecoration(
                      color: context.neutral200,
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    child: TabBar(
                      labelStyle: context.body2.copyWith(
                        fontWeight: FontWeight.w600,
                        color: context.neutral800,
                      ),
                      dividerColor: Colors.transparent,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BoxDecoration(
                        color: context.neutral100,
                        borderRadius: BorderRadius.circular(50.r),
                      ),
                      tabs: [
                        Tab(text: 'Log in'),
                        Tab(text: 'Sign up'),
                      ],
                    ),
                  ),

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
                              key: formKey,
                              child: Column(
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
                          ],
                        ),
                        Column(children: [Text('data2'), Text('data2')]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      body: SafeArea(
        child: Align(
          alignment: .topCenter,
          child: SvgPicture.asset('assets/icon/logo.svg'),
        ),
      ),
    );
  }
}

class CustomFormBuilderTextField extends StatelessWidget {
  const CustomFormBuilderTextField({
    super.key,
    required this.name,
    required this.label,
    required this.iconData,
    this.isPassword = false,
    this.controller,
    this.validators,
  });

  final String name;
  final String label;
  final IconData iconData;
  final bool isPassword;
  final TextEditingController? controller;
  final List<String? Function(String?)>? validators;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      cursorColor: context.neutral1000,
      name: name,
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 15.r),
        prefixIcon: Icon(iconData, color: const Color(0xFF949494)),
        labelText: label,
        filled: true,
        fillColor: context.neutral100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.r),
          borderSide: const BorderSide(color: Color(0xFF949494)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.r),
          borderSide: BorderSide(color: context.neutral700, width: 1),
        ),
      ),
      validator: validators != null
          ? FormBuilderValidators.compose(validators!)
          : null,
    );
  }
}
