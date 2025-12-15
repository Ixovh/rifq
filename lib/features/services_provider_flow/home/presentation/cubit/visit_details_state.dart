part of 'visit_details_cubit.dart';

abstract class VisitDetailsState extends Equatable {
  const VisitDetailsState();

  @override
  List<Object> get props => [];
}

class VisitDetailsInitial extends VisitDetailsState {}

class VisitDetailsSending extends VisitDetailsState {}

class VisitDetailsSendSuccess extends VisitDetailsState {}

class VisitDetailsSendError extends VisitDetailsState {
  final String message;

  const VisitDetailsSendError(this.message);

  @override
  List<Object> get props => [message];
}
