// import 'package:bloc/bloc.dart';
// import '../../../../core/utils/Exception/custom_exception.dart';
// import '../../domain/use_cases/loading_use_case.dart';
// import 'package:equatable/equatable.dart';
// part 'loading_state.dart';

// class LoadingCubit extends Cubit<LoadingState> {
//   final LoadingUseCase loadingUseCase;
//   LoadingCubit(this.loadingUseCase) : super(LoadingInitial());
//   Future<void> startCheck() async {
//     final isLoading = await loadingUseCase.checkAuth();
//     isLoading.when(
//       (loading) {
//         emit(LoadingSuccess());
//       },
//       (notLoading) {
//         emit(
//           LoadingError(
//             msg: CatchErrorMessage(error: "Not login").getWriteMessage(),
//           ),
//         );
//       },
//     );
//   }
// }
