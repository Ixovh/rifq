import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:rifq/features/services_provider_flow/auth/domain/usecases/provider_auth_use_case.dart';

part 'provider_auth_state.dart';

class ProviderAuthCubit extends Cubit<ProviderAuthState> {
  final loginFormKey = GlobalKey<FormBuilderState>();
  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();

  final sinUpFormKey = GlobalKey<FormBuilderState>();
  final sinUpEmailController = TextEditingController();
  final sinUpPasswordController = TextEditingController();
  final nameController = TextEditingController();
  final commercialRegisterNumberController = TextEditingController();
  final locationController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final locationUrlController = TextEditingController();

  final resetVerfiyEmailFormKey = GlobalKey<FormBuilderState>();
  final resetVerfiyPasswordFormKey = GlobalKey<FormBuilderState>();
  final resetEmailController = TextEditingController();
  final resetPasswordController = TextEditingController();

  String? email;

  final Set<int> _selectedServiceTypes = {};
  String? _providerId;

  final ProviderAuthUseCase _providerAuthUseCase;

  ProviderAuthCubit(this._providerAuthUseCase) : super(ProviderAuthInitial());

  Set<int> get selectedServiceTypes => _selectedServiceTypes;
  String? get providerId => _providerId;

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    required int commercialRegister,
    required String location,
    required String phoneNumber,
    required String locationUrl,
  }) async {
    emit(ProviderAuthLoadingState());
    this.email = email;
    (await _providerAuthUseCase.signUp(
      name: name,
      email: email,
      password: password,
      commercialRegister: commercialRegister,
      location: location,
      phoneNumber: phoneNumber,
      locationUrl: locationUrl,
    )).when(
      (whenSuccess) {
        emit(ProviderAuthSignUPSuccessState());
      },
      (whenError) {
        emit(ProviderAuthErrorState(whenError.toString()));
      },
    );
  }

  Future<void> login({required String email, required String password}) async {
    emit(ProviderAuthLoadingState());
    (await _providerAuthUseCase.login(email: email, password: password)).when(
      (whenSuccess) {
        emit(ProviderAuthLoginSuccessState());
      },
      (whenError) {
        emit(ProviderAuthErrorState(whenError.toString()));
      },
    );
  }

  Future<void> verifyAccount({
    required String email,
    required String otp,
  }) async {
    emit(ProviderAuthLoadingState());
    (await _providerAuthUseCase.verifyAccount(email: email, otp: otp)).when(
      (whenSuccess) {
        emit(ProviderAuthVerifyAccountSuccessState());
      },
      (whenError) {
        emit(ProviderAuthErrorState(whenError.toString()));
      },
    );
  }

  Future<void> logOut() async {
    emit(ProviderAuthLoadingState());
    (await _providerAuthUseCase.logOut()).when(
      (whenSuccess) {
        emit(ProviderAuthLogoutSuccessState());
      },
      (whenError) {
        emit(ProviderAuthErrorState(whenError.toString()));
      },
    );
  }

  Future<void> resetPassword({required String newPassword}) async {
    emit(ProviderAuthLoadingState());
    (await _providerAuthUseCase.resetPassword(newPassword: newPassword)).when(
      (whenSuccess) {
        emit(ProviderAuthPasswordResetSuccessState());
      },
      (whenError) {
        emit(ProviderAuthErrorState(whenError.toString()));
      },
    );
  }

  Future<void> sendPasswordResetEmail({required String email}) async {
    emit(ProviderAuthLoadingState());
    (await _providerAuthUseCase.sendPasswordResetEmail(email: email)).when(
      (whenSuccess) {
        emit(ProviderAuthLoadingState());
        emit(ProviderAuthPasswordResetEmailSentState(email));
      },
      (whenError) {
        emit(ProviderAuthErrorState(whenError.toString()));
      },
    );
  }

  Future<void> initializeServiceTypesSelection() async {
    // Preserve existing selections during initialization
    final currentSelections = Set<int>.from(_selectedServiceTypes);

    emit(
      ProviderAuthServiceTypesSelectionState(
        selectedServiceTypes: currentSelections,
        providerId: _providerId ?? '',
        isLoadingProviderId: true,
      ),
    );

    (await _providerAuthUseCase.getProviderIdByAuthId()).when(
      (whenSuccess) {
        _providerId = whenSuccess;
        emit(
          ProviderAuthServiceTypesSelectionState(
            selectedServiceTypes: Set<int>.from(currentSelections),
            providerId: _providerId ?? '',
            isLoadingProviderId: false,
          ),
        );
      },
      (whenError) {
        emit(ProviderAuthErrorState(whenError.toString()));
      },
    );
  }

  void toggleServiceType(int serviceTypeId) {
    if (_selectedServiceTypes.contains(serviceTypeId)) {
      _selectedServiceTypes.remove(serviceTypeId);
    } else {
      _selectedServiceTypes.add(serviceTypeId);
    }
    // Create a new Set instance to ensure proper state comparison
    emit(
      ProviderAuthServiceTypesSelectionState(
        selectedServiceTypes: Set<int>.from(_selectedServiceTypes),
        providerId: _providerId ?? '',
        isLoadingProviderId: false,
      ),
    );
  }

  Future<void> selectServiceTypes({
    required String providerId,
    required List<int> serviceTypeIds,
  }) async {
    emit(ProviderAuthLoadingState());
    (await _providerAuthUseCase.selectServiceTypes(
      providerId: providerId,
      serviceTypeIds: serviceTypeIds,
    )).when(
      (whenSuccess) {
        emit(ProviderAuthServiceTypesSelectedSuccessState());
      },
      (whenError) {
        emit(ProviderAuthErrorState(whenError.toString()));
      },
    );
  }

  Future<void> submitSelectedServiceTypes() async {
    if (_providerId == null) {
      emit(const ProviderAuthErrorState('Provider ID not found'));
      return;
    }

    await selectServiceTypes(
      providerId: _providerId!,
      serviceTypeIds: _selectedServiceTypes.toList(),
    );
  }

  Future<void> addServiceItem({
    required String providerId,
    required String name,
    required String description,
    required double price,
  }) async {
    emit(ProviderAuthLoadingState());
    (await _providerAuthUseCase.addServiceItem(
      providerId: providerId,
      name: name,
      description: description,
      price: price,
    )).when(
      (whenSuccess) {
        emit(ProviderAuthServiceItemAddedSuccessState());
      },
      (whenError) {
        emit(ProviderAuthErrorState(whenError.toString()));
      },
    );
  }
}
