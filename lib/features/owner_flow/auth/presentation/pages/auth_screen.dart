import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:rifq/features/owner_flow/auth/domain/usecases/auth_use_case.dart';
import 'package:rifq/features/owner_flow/auth/presentation/pages/auth_tab_bar.dart';
import 'package:rifq/features/owner_flow/auth/presentation/pages/login_tab.dart';
import 'package:rifq/features/owner_flow/auth/presentation/pages/sign_up_tab.dart';
import 'package:rifq/features/owner_flow/auth/presentation/widgets/custom_bottom_sheet.dart';
import '../../../../../core/theme/app_theme.dart';
import 'package:rifq/features/owner_flow/auth/presentation/cubit/auth_cubit.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(GetIt.I.get<AuthUseCase>()),
      child: Builder(
        builder: (context) {
          final _ = context.read<AuthCubit>();
          return BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              switch (state) {
                case AuthSuccessState _:
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("welcome home!")));
                  // TODO: create home screen and add routes it home
                  // context.go(Routes.home, extra: cubit);
                  break;

                case AuthErrorState _:
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.msg)));
                  break;

                case AuthLoadingState _:
                  Center(child: CircularProgressIndicator());
                  break;

                default:
                  Navigator.of(context).pop();
                  break;
              }
            },
            child: Scaffold(
              backgroundColor: context.neutral100,
              resizeToAvoidBottomInset: false,
              bottomSheet: CustomBottomSheet(
                content: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      const AuthTabBar(),
                      Expanded(
                        child: TabBarView(
                          children: [
                            LoginTab(),
                            SignUpTab(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              body: SafeArea(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: SvgPicture.asset('assets/icon/logo.svg'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
