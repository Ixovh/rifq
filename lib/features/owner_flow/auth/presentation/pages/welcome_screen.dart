import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq/core/theme/app_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.background,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(18).r,
            child: Column(
              children: [
                SvgPicture.asset('assets/icon/logo.svg')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
