import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import '../../../../../core/shared/shared_in_owner_flow/shared_auth/models/auth_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class BaseAuthDataSource {
  Future<Result<Null, Object>> signUp({
    required String name,
    required String email,
    required String password,
  });

  //----------
  Future<Result<Null, Object>> login({
    required String email,
    required String password,
  });

  //---------
  Future<Result<AuthModel, Object>> verifyAccount({
    required String email,
    required String otp,
  });
  //---------
  Future<Result<Null, Object>> anonymousUser();

  //---------
  Future<Result<Null, Object>> logOut();

  //---------
  Future<Result<Null, Object>> resetPassword({required String newPassword});

  //---------
  Future<Result<Null, Object>> sendPasswordResetEmail({required String email});
}

@LazySingleton(as: BaseAuthDataSource)
class SubaBaseDataSource implements BaseAuthDataSource {
  final SupabaseClient _supabase;
  final GetStorage _box;
  String? email;

  SubaBaseDataSource({
    required SupabaseClient supabase,
    required GetStorage box,
    // this.email,
  }) : _supabase = supabase,
       _box = box;

  @override
  Future<Result<Null, Object>> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final existingProfile = await _supabase
          .from('users')
          .select('id')
          .eq('email', email)
          .maybeSingle();

      if (existingProfile != null) {
        return Error('This email is already registered. Please login instead.');
      }
      await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {'username': name},
      );
      return Success(null);
    } catch (e) {
      return Error(e);
    }
  }

  //
  //
  //

  @override
  Future<Result<Null, Object>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      final session = response.session;
      if (session == null) {
        return Error(Exception('No session returned from Supabase.'));
      }

      final res = AuthModel(
        token: session.accessToken,
        refreshToken: session.refreshToken!,
      );
      await _box.write('login', res.toJson());
      await _box.save();

      return Success(null);
    } catch (e) {
      return Error(e);
    }
  }
  //
  //
  //

  @override
  Future<Result<AuthModel, Object>> verifyAccount({
    required String email,
    required String otp,
  }) async {
    try {
      final user = await _supabase.auth.verifyOTP(
        email: email,
        token: otp,
        type: OtpType.email,
      );
      final res = AuthModel(
        token: user.session!.accessToken,
        refreshToken: user.session!.refreshToken!,
      );
      await _box.write('login', res.toJson());
      await _box.save();

      // by doing this query user id will equal auth.id
      await _supabase
          .from('users')
          .update({'id': user.user!.id})
          .eq('auth_id', user.user!.id);

      return Success(res);
    } catch (e) {
      return Error(e);
    }
  }
  //
  //
  //

  @override
  Future<Result<Null, Object>> anonymousUser() async {
    try {
      await _supabase.auth.signInAnonymously();
      return Success(null);
    } catch (e) {
      return Error(e);
    }
  }
  //
  //
  //

  @override
  Future<Result<Null, Object>> logOut() async {
    try {
      await _supabase.auth.signOut();
      await _box.erase();

      return Success(null);
    } catch (e) {
      return Error(e);
    }
  }
  //
  //
  //

  @override
  Future<Result<Null, Object>> resetPassword({
    required String newPassword,
  }) async {
    try {
      final response = await _supabase.auth.updateUser(
        UserAttributes(email: email!, password: newPassword),
      );

      if (response.user == null) {
        return Error('Failed to update password. Please try again.');
      }

      return Success(null);
    } catch (e) {
      return Error(e);
    }
  }

  //
  //
  //

  @override
  Future<Result<Null, Object>> sendPasswordResetEmail({
    required String email,
  }) async {
    try {
      await _supabase.auth.resetPasswordForEmail(email);
      this.email = email;
      return Success(null);
    } catch (e) {
      return Error(e);
    }
  }
}
