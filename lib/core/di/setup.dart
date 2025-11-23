import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'setup.config.dart';


final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureDependencies() async {
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: dotenv.env['supabaseUrl'].toString(),
    anonKey: dotenv.env['keySupabase'].toString(),
  );

  await GetStorage.init();

  getIt.init();
}