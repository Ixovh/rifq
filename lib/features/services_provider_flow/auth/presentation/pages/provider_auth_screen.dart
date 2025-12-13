import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:rifq/core/routes/base_routes.dart';
import 'package:rifq/features/services_provider_flow/auth/domain/usecases/provider_auth_use_case.dart';
import 'package:rifq/features/services_provider_flow/auth/presentation/pages/provider_login_tab.dart';
import 'package:rifq/features/services_provider_flow/auth/presentation/pages/provider_sign_up_tab.dart';
import 'package:rifq/features/owner_flow/auth/presentation/widgets/custom_bottom_sheet.dart';
import '../../../../../core/theme/app_theme.dart';
import 'package:rifq/features/services_provider_flow/auth/presentation/cubit/provider_auth_cubit.dart';

class ProviderAuthScreen extends StatelessWidget {
  const ProviderAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProviderAuthCubit(GetIt.I.get<ProviderAuthUseCase>()),
      child: Builder(
        builder: (context) {
          final cubit = context.read<ProviderAuthCubit>();
          return BlocConsumer<ProviderAuthCubit, ProviderAuthState>(
            listener: (context, state) {
              switch (state) {
                case ProviderAuthLoginSuccessState _:
                  context.push(Routes.providerHome);
                  break;
                case ProviderAuthSignUPSuccessState _:
                  context.push(
                    Routes.providerOtp,
                    extra: {"cubit": cubit, "isPassword": false},
                  );
                  break;
                case ProviderAuthErrorState _:
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.msg)));
                  break;
                default:
                  break;
              }
            },
            builder: (context, state) {
              return Scaffold(
                backgroundColor: context.neutral100,
                resizeToAvoidBottomInset: false,
                bottomSheet: CustomBottomSheet(
                  content: DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(4.r),
                          decoration: BoxDecoration(
                            color: context.neutral200,
                            borderRadius: BorderRadius.circular(50.r),
                          ),
                          child: TabBar(
                            labelStyle: context.body2.copyWith(
                              fontWeight: FontWeight.w600,
                              color: context.neutral800,
                            ),
                            dividerColor: Colors.transparent,
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicator: BoxDecoration(
                              color: context.neutral100,
                              borderRadius: BorderRadius.circular(50.r),
                            ),
                            tabs: const [
                              Tab(text: 'Log in'),
                              Tab(text: 'Sign up'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [ProviderLoginTab(), ProviderSignUpTab()],
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
              );
            },
          );
        },
      ),
    );
  }
}
