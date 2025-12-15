import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:rifq/core/common/widgets/appbar/custom_app_bar.dart';
import 'package:rifq/core/theme/app_theme.dart';
import 'package:rifq/features/owner_flow/adoption/domain/usecases/adotion_use_case.dart';
import 'package:rifq/features/owner_flow/adoption/presentation/cubit/adoption_cubit.dart';
import 'package:rifq/features/owner_flow/adoption/presentation/pages/adoption_tab.dart';
import 'package:rifq/features/owner_flow/adoption/presentation/pages/my_pets_tab.dart';

class AdoptionScreen extends StatelessWidget {
  const AdoptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdoptionCubit(GetIt.I.get<AdoptionUseCase>()),
      child: Scaffold(
        backgroundColor: context.background,
       appBar: CustomAppBar(title: "Adoption"),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.r, horizontal: 26.r),
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                TabBar(
                  labelStyle: context.body2.copyWith(
                    fontWeight: FontWeight.w600,
                    color: context.primary300,
                  ),
                  unselectedLabelColor: context.neutral200,
                  indicatorColor: context.primary300,
                  dividerColor: context.neutral200,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: const [
                    Tab(text: 'for adoption'),
                    Tab(text: 'my pets'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      // For Adoption Tab
                      AdoptionTab(),
                      // My Pets Tab
                      MyPetsTab(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
