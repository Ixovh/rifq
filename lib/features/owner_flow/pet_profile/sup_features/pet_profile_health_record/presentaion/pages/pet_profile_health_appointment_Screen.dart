// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rifq/core/di/setup.dart';
import 'package:rifq/core/theme/app_theme.dart';
import 'package:rifq/core/common/widgets/lottie_loading/lottie_loding.dart';
import 'package:rifq/features/owner_flow/pet_profile/sup_features/pet_profile_health_record/domain/entity/pet_profile_records_entity.dart';
import 'package:rifq/features/owner_flow/pet_profile/sup_features/pet_profile_health_record/domain/usecase/health_record_usecase.dart';
import 'package:rifq/features/owner_flow/pet_profile/sup_features/pet_profile_health_record/presentaion/cubit/pet_profile_records_cubit.dart';
import '../../../../../../../core/routes/base_routes.dart';
import '../widgets/appointment_content.dart';
import '../widgets/cstoum_tab_bar.dart';
import '../widgets/health_record_content.dart';

class PetHealthAndAppointmentScreen extends StatelessWidget {
  final PetEntity pet;
  const PetHealthAndAppointmentScreen({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: BlocProvider(
        create: (context) =>
            PetProfileRecordsCubit(getIt<HealthRecordUsecase>())
              ..loadPetData(pet),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            title: Text(
              "Pet Profile",
              style: context.h5.copyWith(color: context.primary300),
            ),
            centerTitle: true,
            actions: [
              InkWell(
                onTap: () {
                  context.pop(Routes.editpetprofile);
                },
                child: Image.asset("assets/images/edit.png"),
              ),
            ],
          ),
          body: BlocBuilder<PetProfileRecordsCubit, PetProfileRecordsState>(
            builder: (context, state) {
              if (state is PetProfileLoading || state is AddingHealthRecord) {
                return LottieLoding();
              }
              if (state is PetProfileError) {
                return Center(child: Text(state.massege));
              }
              if (state is PetProfileLoaded) {
                return Column(
                  crossAxisAlignment: .center,
                  children: [
                    CircleAvatar(
                      radius: 60.r,
                      backgroundImage: NetworkImage(state.petent.petPhoto),
                    ),
                    Text(state.petent.petName),
                    Text(state.petent.petBreed),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${DateTime.now().year - state.petent.petBirthdate.year} years",
                        ),
                        SizedBox(width: 5.w),
                        Text(state.petent.petGender),
                      ],
                    ),
                    CustomTabBar(),
                    Expanded(
                      child: TabBarView(
                        children: [
                          HealthRecordTab(records: state.healthRecords),
                          AppointmentTab(appointments: state.reservations),
                        ],
                      ),
                    ),
                  ],
                );
              }
              return SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
