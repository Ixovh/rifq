import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ProviderBaseAuthDataSource {
  Future<Result<Null, Object>> signUp({
    required String name,
    required String email,
    required String password,
    required int commercialRegister,
    required String location,
    required String phoneNumber,
    required String locationUrl,
  });

  Future<Result<Null, Object>> login({
    required String email,
    required String password,
  });

  Future<Result<Null, Object>> verifyAccount({
    required String email,
    required String otp,
  });

  Future<Result<Null, Object>> logOut();

  Future<Result<Null, Object>> resetPassword({required String newPassword});

  Future<Result<Null, Object>> sendPasswordResetEmail({required String email});

  Future<Result<Null, Object>> selectServiceTypes({
    required String providerId,
    required List<int> serviceTypeIds,
  });

  Future<Result<Null, Object>> addServiceItem({
    required String providerId,
    required String name,
    required String description,
    required double price,
  });

  Future<Result<String?, Object>> getProviderIdByAuthId();
}

@LazySingleton(as: ProviderBaseAuthDataSource)
class ProviderAtuhDataSource implements ProviderBaseAuthDataSource {
  final SupabaseClient _supabase;
  String? email;
  String? providerId;
  // Temporary storage for signup data to be used in verification
  String? _pendingName;
  int? _pendingCommercialRegister;
  String? _pendingLocation;
  String? _pendingPhoneNumber;
  String? _pendingLocationUrl;

  ProviderAtuhDataSource({required SupabaseClient supabase})
    : _supabase = supabase;

  @override
  Future<Result<Null, Object>> signUp({
    required String name,
    required String email,
    required String password,
    required int commercialRegister,
    required String location,
    required String phoneNumber,
    required String locationUrl,
  }) async {
    try {
      // Validate input fields
      if (name.trim().isEmpty) {
        return Error('Name is required.');
      }
      if (email.trim().isEmpty) {
        return Error('Email is required.');
      }
      if (password.isEmpty) {
        return Error('Password is required.');
      }
      if (location.trim().isEmpty) {
        return Error('Location is required.');
      }
      if (phoneNumber.trim().isEmpty) {
        return Error('Phone number is required.');
      }
      if (locationUrl.trim().isEmpty) {
        return Error('Location URL is required.');
      }

      // Check if email already exists as provider
      final existingProvider = await _supabase
          .from('providers')
          .select('id')
          .eq('email', email)
          .maybeSingle();
      if (existingProvider != null) {
        return Error('This email is already registered. Please login instead.');
      }

      // Check if email already exists as user
      final existingUser = await _supabase
          .from('users')
          .select('id')
          .eq('email', email)
          .maybeSingle();
      if (existingUser != null) {
        return Error(
          'This email is already registered as a user. Please login instead.',
        );
      }

      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
      );

      if (response.user == null) {
        return Error('Failed to create account. Please try again.');
      }

      providerId = response.user!.id;

      // Store signup data temporarily for use in verification
      this.email = email;
      _pendingName = name;
      _pendingCommercialRegister = commercialRegister;
      _pendingLocation = location;
      _pendingPhoneNumber = phoneNumber;
      _pendingLocationUrl = locationUrl;

      return Success(null);
    } catch (e) {
      return Error(
        'Failed to sign up. Please check your information and try again.',
      );
    }
  }

  @override
  Future<Result<Null, Object>> login({
    required String email,
    required String password,
  }) async {
    try {
      // Validate input fields
      if (email.trim().isEmpty) {
        return Error('Email is required.');
      }
      if (password.isEmpty) {
        return Error('Password is required.');
      }

      // Check if user exists in users table (provider should not be in users table)
      final existingUser = await _supabase
          .from('users')
          .select('id')
          .eq('email', email)
          .maybeSingle();
      if (existingUser != null) {
        return Error(
          'This account is registered as a user. Please use user login instead.',
        );
      }

      // Check if provider exists
      final existingProvider = await _supabase
          .from('providers')
          .select('id')
          .eq('email', email)
          .maybeSingle();
      if (existingProvider == null) {
        return Error('Account not found. Please sign up first.');
      }

      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        return Error('Invalid email or password. Please try again.');
      }

      providerId = response.user!.id;
      return Success(null);
    } catch (e) {
      return Error(
        'Failed to login. Please check your credentials and try again.',
      );
    }
  }

  @override
  Future<Result<Null, Object>> verifyAccount({
    required String email,
    required String otp,
  }) async {
    try {
      // Validate input fields
      if (email.trim().isEmpty) {
        return Error('Email is required.');
      }
      if (otp.trim().isEmpty) {
        return Error('Verification code is required.');
      }

      final user = await _supabase.auth.verifyOTP(
        email: email,
        token: otp,
        type: OtpType.email,
      );

      if (user.user == null) {
        return Error('Invalid verification code. Please try again.');
      }

      // Insert provider record after successful verification
      if (_pendingName != null &&
          _pendingCommercialRegister != null &&
          _pendingLocation != null &&
          _pendingPhoneNumber != null &&
          _pendingLocationUrl != null) {
        try {
          await _supabase.from('providers').insert({
            'id': user.user!.id,
            'auth_id': user.user!.id,
            'name': _pendingName!,
            'email': email,
            'phone': _pendingPhoneNumber!,
            'location': _pendingLocation!,
            'commercial_register': _pendingCommercialRegister!.toString(),
            'location_url': _pendingLocationUrl!,
            'created_at': DateTime.now().toIso8601String(),
          });
        } catch (e) {
          return Error(
            'Failed to create provider account. Please contact support.',
          );
        }

        // Clear pending data after successful insertion
        _pendingName = null;
        _pendingCommercialRegister = null;
        _pendingLocation = null;
        _pendingPhoneNumber = null;
        _pendingLocationUrl = null;
      } else {
        return Error('Signup data not found. Please sign up again.');
      }

      providerId = user.user!.id;
      return Success(null);
    } catch (e) {
      return Error(
        'Failed to verify account. Please check your verification code and try again.',
      );
    }
  }

  @override
  Future<Result<Null, Object>> logOut() async {
    try {
      await _supabase.auth.signOut();
      providerId = null;
      email = null;
      return Success(null);
    } catch (e) {
      return Error('Failed to logout. Please try again.');
    }
  }

  @override
  Future<Result<Null, Object>> resetPassword({
    required String newPassword,
  }) async {
    try {
      // Validate input
      if (newPassword.isEmpty) {
        return Error('Password is required.');
      }
      if (newPassword.length < 6) {
        return Error('Password must be at least 6 characters long.');
      }
      if (email == null || email!.isEmpty) {
        return Error('Email not found. Please request password reset again.');
      }

      final response = await _supabase.auth.updateUser(
        UserAttributes(email: email!, password: newPassword),
      );

      if (response.user == null) {
        return Error('Failed to reset password. Please try again.');
      }

      return Success(null);
    } catch (e) {
      return Error('Failed to reset password. Please try again.');
    }
  }

  @override
  Future<Result<Null, Object>> sendPasswordResetEmail({
    required String email,
  }) async {
    try {
      // Validate input
      if (email.trim().isEmpty) {
        return Error('Email is required.');
      }

      // Check if provider exists
      final existingProvider = await _supabase
          .from('providers')
          .select('id')
          .eq('email', email)
          .maybeSingle();
      if (existingProvider == null) {
        return Error('No account found with this email address.');
      }

      await _supabase.auth.resetPasswordForEmail(email);
      this.email = email;
      return Success(null);
    } catch (e) {
      return Error('Failed to send password reset email. Please try again.');
    }
  }

  @override
  Future<Result<Null, Object>> selectServiceTypes({
    required String providerId,
    required List<int> serviceTypeIds,
  }) async {
    try {
      // Validate providerId
      if (providerId.isEmpty) {
        return Error('Provider ID is required. Please login first.');
      }

      // Validate service types selection
      if (serviceTypeIds.isEmpty) {
        return Error('Please select at least one service type.');
      }

      // Verify provider exists
      final provider = await _supabase
          .from('providers')
          .select('id')
          .eq('id', providerId)
          .maybeSingle();
      if (provider == null) {
        return Error('Provider not found. Please login again.');
      }

      // Validate service type IDs exist in provider_service_types table
      for (final serviceTypeId in serviceTypeIds) {
        final serviceType = await _supabase
            .from('provider_service_types')
            .select('id')
            .eq('id', serviceTypeId)
            .maybeSingle();
        if (serviceType == null) {
          return Error('Invalid service type selected. Please try again.');
        }
      }

      // Insert service types into provider_services table
      final serviceRecords = serviceTypeIds
          .map(
            (serviceTypeId) => {
              'provider_id': providerId,
              'service_type_id': serviceTypeId,
            },
          )
          .toList();

      await _supabase.from('provider_services').insert(serviceRecords);

      return Success(null);
    } catch (e) {
      return Error('Failed to save service types. Please try again.');
    }
  }

  @override
  Future<Result<Null, Object>> addServiceItem({
    required String providerId,
    required String name,
    required String description,
    required double price,
  }) async {
    try {
      // Validate input fields
      if (providerId.isEmpty) {
        return Error('Provider ID is required.');
      }
      if (name.trim().isEmpty) {
        return Error('Service name is required.');
      }
      if (description.trim().isEmpty) {
        return Error('Service description is required.');
      }
      if (price <= 0) {
        return Error('Price must be greater than zero.');
      }

      // Verify provider exists
      final provider = await _supabase
          .from('providers')
          .select('id')
          .eq('id', providerId)
          .maybeSingle();
      if (provider == null) {
        return Error('Provider not found. Please login again.');
      }

      // Insert service item into provider_service_items table
      await _supabase.from('provider_service_items').insert({
        'provider_id': providerId,
        'name': name,
        'description': description,
        'price': price,
        'created_at': DateTime.now().toIso8601String(),
      });

      return Success(null);
    } catch (e) {
      return Error('Failed to add service item. Please try again.');
    }
  }

  @override
  Future<Result<String?, Object>> getProviderIdByAuthId() async {
    try {
      final authId = _supabase.auth.currentUser?.id;
      if (authId == null) {
        return Error('Please login first.');
      }

      final provider = await _supabase
          .from('providers')
          .select('id')
          .eq('auth_id', authId)
          .maybeSingle();

      if (provider == null) {
        return Error('Provider account not found. Please sign up first.');
      }

      return Success(provider['id']);
    } catch (e) {
      return Error(
        'Failed to retrieve provider information. Please try again.',
      );
    }
  }
}
