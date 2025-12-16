import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq/core/theme/app_theme.dart';

class CustomeTextFieldWidgets extends StatelessWidget {
  final TextEditingController controller;
  final bool isLoading;
  final String lable;
  final IconData? prefixIcon;
  const CustomeTextFieldWidgets({
    super.key,
    required this.controller,
    required this.isLoading,
    required this.lable,
    this.prefixIcon});
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(
        left: 18,
        right: 23,),
      child: TextFormField(
        controller: controller,
        enabled:isLoading,
        decoration: InputDecoration(
          label: Text(lable,style: context.body2,),
          prefixIcon: prefixIcon != null
              ? Icon(prefixIcon)
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18.r),
          ),
        ),

      ),
    );
  }

}