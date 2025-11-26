import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq/core/di/setup.dart';
import 'core/routes/base_routes.dart';
import 'features/owner_flow/profile/presentation/pages/edit_profile_screen.dart';
import 'features/owner_flow/profile/presentation/pages/profile_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(402, 874),
      builder: (_, _) => MaterialApp.router(
        routerConfig: Routs.routers,
        //   home:
        //   // EditProfileScreen(),
        // ProfileScreen(),
      ),
          // OnbordingScreen() ),
    );
  }
}

