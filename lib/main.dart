import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq/core/routes/base_routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/di/setup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await configureDependencies();
  //عشان اسجل خروج "بحذفها بعد مانسوي لوق اوت "
  // await Supabase.instance.client.auth.signOut();
  // await GetStorage().erase();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(402, 874),
      builder: (_, _) => MaterialApp.router(
        routerConfig: Routes.routers,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
