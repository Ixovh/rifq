import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq/core/di/setup.dart';
import 'package:rifq/core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // designSize: const Size(402, 874),
      builder: (_, _) => MaterialApp(home: const HomePage()),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Primary Button',
              style: context.body1.copyWith(color: context.neutral100),
            ),
            SizedBox(height: 16.h),
            Text(
              'Heading',
              style: context.h1.copyWith(color: context.neutral100),
            ),

            FormBuilderTextField(
              name: 'email',
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.construction),
                prefixIcon: Icon(Icons.construction),
                labelText: 'Email',
                hintText: 'you@example.com',
                filled: true,
                fillColor: context.neutral200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: context.neutral300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: context.primary300, width: 2),
                ),
              ),
              style: context.body2,
              cursorColor: context.primary,
            ),
          ],
        ),
      ),
    );
  }
}
