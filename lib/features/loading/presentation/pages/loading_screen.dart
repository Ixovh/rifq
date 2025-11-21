// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get_it/get_it.dart';
// import 'package:go_router/go_router.dart';
// import '../../../../core/routes/base_routes.dart';
// import '../cubit/loading_cubit.dart';

// class LoadingScreen extends StatelessWidget {
//   const LoadingScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => LoadingCubit(GetIt.I.get())..startCheck(),
//       child: Builder(
//         builder: (context) {
//           return BlocListener<LoadingCubit, LoadingState>(
//             listener: (context, state) {
//               switch (state) {
//                 case LoadingSuccess _:
//                   context.go(Routes.home);
//                   break;
//                 default:
//                   context.go(Routes.signUp);
//                   break;
//               }
//             },
//             child: Scaffold(body: Center(child: CircularProgressIndicator())),
//           );
//         },
//       ),
//     );
//   }
// }
