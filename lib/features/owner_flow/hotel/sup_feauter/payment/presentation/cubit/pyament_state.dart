part of 'pyament_cubit.dart';

@immutable
sealed class PyamentState {}

class PaymentInitial extends PyamentState {}

class PaymentLoading extends PyamentState {}

class PaymentSuccess extends PyamentState {}

class PaymentError extends PyamentState {
  final String message;
  PaymentError({required this.message});
}

