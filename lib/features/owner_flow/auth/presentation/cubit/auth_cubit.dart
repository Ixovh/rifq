import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:rifq/core/utils/Exception/custom_exception.dart';
import 'package:rifq/features/owner_flow/auth/domain/usecases/auth_use_case.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final loginFormKey = GlobalKey<FormBuilderState>();
  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();

  final sinUpFormKey = GlobalKey<FormBuilderState>();
  final sinUpEmailController = TextEditingController();
  final sinUpPasswordController = TextEditingController();
  final nameController = TextEditingController();

  final resetVerfiyEmailFormKey = GlobalKey<FormBuilderState>();
  final resetVerfiyPasswordFormKey = GlobalKey<FormBuilderState>();
  final resetEmailController = TextEditingController();
  final resetPasswordController = TextEditingController();

  String? email;
  final AuthUseCase _authUseCase;

  AuthCubit(this._authUseCase) : super(AuthInitial());

  void clearAllControllers() {
    // Clear all text controllers
    loginEmailController.clear();
    loginPasswordController.clear();
    sinUpEmailController.clear();
    sinUpPasswordController.clear();
    nameController.clear();
    resetEmailController.clear();
    resetPasswordController.clear();

    // Reset all form states
    loginFormKey.currentState?.reset();
    sinUpFormKey.currentState?.reset();
    resetVerfiyEmailFormKey.currentState?.reset();
    resetVerfiyPasswordFormKey.currentState?.reset();

    // Clear email
    email = null;
  }

  Future signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(AuthLoadingState());

    (await _authUseCase.signUp(
      name: name,
      email: email,
      password: password,
    )).when(
      (whenSuccess) {
        this.email = email;
        clearAllControllers();
        emit(AuthSignUPSuccessState());
      },
      (whenError) {
        emit(
          AuthErrorState(
            msg: CatchErrorMessage(error: whenError).getWriteMessage(),
          ),
        );
      },
    );
  }

  //
  //
  //

  Future login({required String email, required String password}) async {
    emit(AuthLoadingState());

    (await _authUseCase.login(email: email, password: password)).when(
      (whenSuccess) {
        this.email = email;
        clearAllControllers();
        emit(AuthSuccessState());
      },
      (whenError) {
        emit(
          AuthErrorState(
            msg: CatchErrorMessage(error: whenError).getWriteMessage(),
          ),
        );
      },
    );
  }

  //
  //
  //

  Future verifyAccount({required String email, required String otp}) async {
    emit(AuthLoadingState());

    (await _authUseCase.verifyAccount(email: email, otp: otp)).when(
      (whenSuccess) {
        this.email = email;
        clearAllControllers();
        emit(AuthSuccessState());
      },
      (whenError) {
        emit(
          AuthErrorState(
            msg: CatchErrorMessage(error: whenError).getWriteMessage(),
          ),
        );
      },
    );
  }

  Future logOut() async {
    emit(AuthLoadingState());

    (await _authUseCase.logOut()).when(
      (whenSuccess) {
        clearAllControllers();
        emit(AuthLogoutSuccessState());
      },
      (whenError) {
        emit(
          AuthErrorState(
            msg: CatchErrorMessage(error: whenError).getWriteMessage(),
          ),
        );
      },
    );
  }

  //
  //
  //

  Future sendPasswordResetEmail({required String email}) async {
    emit(AuthLoadingState());
    (await _authUseCase.sendPasswordResetEmail(email: email)).when(
      (success) {
        this.email = email;
        emit(AuthPasswordResetEmailSentState(email: email));
      },
      (error) {
        emit(
          AuthErrorState(
            msg: CatchErrorMessage(error: error).getWriteMessage(),
          ),
        );
      },
    );
  }

  //
  //
  //

  Future resetPassword({required String newPassword}) async {
    emit(AuthLoadingState());
    (await _authUseCase.resetPassword(newPassword: newPassword)).when(
      (success) {
        clearAllControllers();
        emit(AuthPasswordResetSuccessState());
      },
      (error) {
        emit(
          AuthErrorState(
            msg: CatchErrorMessage(error: error).getWriteMessage(),
          ),
        );
      },
    );
  }

  //
  //
  //

  @override
  Future<void> close() {
    loginEmailController.dispose();
    loginPasswordController.dispose();
    sinUpEmailController.dispose();
    sinUpPasswordController.dispose();
    nameController.dispose();
    resetEmailController.dispose();
    resetPasswordController.dispose();
    return super.close();
  }
}
