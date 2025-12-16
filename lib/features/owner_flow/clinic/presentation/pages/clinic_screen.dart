import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rifq/core/common/widgets/appbar/custom_app_bar.dart';
import 'package:rifq/core/di/setup.dart';
import 'package:rifq/features/owner_flow/clinic/presentation/cubit/clinic_cubit.dart';
import '../../../../../core/common/widgets/lottie_loading/lottie_loding.dart';
import '../widgets/clinic_header.dart';
import '../widgets/clinic_search_bar.dart';
import '../widgets/clinic_section_title.dart';
import '../widgets/clinic_list.dart';
import 'package:rifq/core/common/widgets/guest_card/guest_card_widget.dart';

class ClinicScreen extends StatelessWidget {
  const ClinicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ClinicCubit>()..loadClinicScreen(),
      child: const _ClinicView(),
    );
  }
}

class _ClinicView extends StatelessWidget {
  const _ClinicView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Clinics"),
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: BlocBuilder<ClinicCubit, ClinicState>(
          builder: (context, state) {
            if (state is ClinicLoading) {
              return const Center(child: LottieLoding());
            }

            //!!--------------Guest View------------
            if (state is ClinicGuestState) {
              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(child: ClinicHeader(pets: [])),
                  SliverToBoxAdapter(child: const GuestCard()),
                  const SliverToBoxAdapter(child: SizedBox(height: 12)),
                  SliverToBoxAdapter(child: ClinicSearchBar()),
                  const ClinicSectionTitle(title: "Veterinary Clinics"),
                  ClinicList(clinics: state.clinics),
                ],
              );
            }

            //!!-----------logged in View-----------
            if (state is ClinicScreenLoaded) {
              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(child: ClinicHeader(pets: state.pets)),
                  SliverToBoxAdapter(child: ClinicSearchBar()),
                  const ClinicSectionTitle(title: "Veterinary Clinics"),
                  ClinicList(clinics: state.clinics),
                ],
              );
            }

            //!!-----------Error View-----------
            if (state is ClinicError) {
              return Center(child: Text(state.message));
            }

            return SizedBox();
          },
        ),
      ),
    );
  }
}
