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

  String? email;
  final AuthUseCase _authUseCase;
  
  AuthCubit(this._authUseCase) : super(AuthInitial());

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

  Future login({required String email, required String password}) async {
    emit(AuthLoadingState());

    (await _authUseCase.login(email: email, password: password)).when(
      (whenSuccess) {
        this.email = email;
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
  
  Future anonymousUser() async {
    emit(AuthLoadingState());

    (await _authUseCase.anonymousUser()).when(
    (whenSuccess) {
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

  Future logOut() async {
    emit(AuthLoadingState());

    (await _authUseCase.logOut()).when(
    (whenSuccess) {
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

  @override
  Future<void> close() {
    loginEmailController.dispose();
    loginPasswordController.dispose();
    sinUpEmailController.dispose();
    sinUpPasswordController.dispose();
    nameController.dispose();
    return super.close();
  }
}
 
