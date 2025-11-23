import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get_storage/get_storage.dart';

@module
abstract class ThirdPartyModule {
  @singleton
  GetStorage get storage => GetStorage();

  @singleton
  SupabaseClient get supabaseClient => Supabase.instance.client;
}
