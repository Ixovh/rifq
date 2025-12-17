import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/common/widgets/lottie_loading/lottie_loding.dart';
import '../../../../../core/di/setup.dart';
import '../../../../../core/routes/base_routes.dart';
import '../../../../../core/shared/shared_in_owner_flow/shared_auth/helpers/auth_helper.dart';
import '../../../pet_profile/sup_features/pet_info_card/domain/usecase/pet_profile_usecase.dart';
import '../../../pet_profile/sup_features/pet_info_card/presentation/cubit/pet_info_cubit.dart';
import '../../domain/entities/user_profile_entity.dart';
import '../../domain/usecases/user_profile_usecase.dart';
import '../cubit/profile_cubit.dart';
import '../../../pet_profile/sup_features/pet_info_card/presentation/widgets/container_pet_card_widgets.dart';
import '../widgets/listtiel/list_tiel_widgets.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../../../auth/domain/usecases/auth_use_case.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = AuthHelper.getUserId();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final cubit = ProfileCubit(getIt<UserProfileUsecase>());
            if (userId != null) {
              cubit.getUserProfile(userId);
            }
            return cubit;
          },
        ),
        BlocProvider(create: (context) => AuthCubit(getIt<AuthUseCase>())),
      ],
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLogoutSuccessState) {
            context.go(Routes.auth);
          } else if (state is AuthErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.msg), backgroundColor: Colors.red),
            );
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            surfaceTintColor: Colors.transparent,
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: Icon(Icons.arrow_back_ios, color: Colors.black),
            ),
          ),
          body: BlocListener<ProfileCubit, ProfileState>(
            listener: (context, state) {
              if (state is ProfileUpdated) {
                context.read<ProfileCubit>().getUserProfile(userId!);
              }
            },
            child: BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                if (state is ProfileLoading) {
                  return Center(child: LottieLoding());
                }
                UserProfileEntity? user;
                if (state is ProfileLoaded) {
                  user = state.user;
                }
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      children: [
                        SizedBox(height: 10.h),
                        Center(
                          child: CircleAvatar(
                            radius: 60.r,
                            backgroundColor: Color(0xFFBBE9E3),
                            child: Text(
                              user != null ? user.name[0].toUpperCase() : "?",
                              style: TextStyle(
                                fontSize: 48.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              user != null ? user.name : "Loading...",
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 6.w),
                            IconButton(
                              onPressed: () {
                                context.push(
                                  Routes.editprofile,
                                  extra: context.read<ProfileCubit>(),
                                );
                              },
                              icon: Icon(Icons.edit_outlined),
                            ),
                          ],
                        ),
                        SizedBox(height: 18.h),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                              decoration: InputDecoration(
                                hintText: user?.email ?? "Email",
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                              decoration: InputDecoration(
                                hintText: user?.name ?? "Name",
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 32.h),
                        user == null
                            ? LottieLoding()
                            : SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: BlocProvider(
                                  create: (context) =>
                                      PetInfoCubit(getIt<PetProfileUsecase>())
                                        ..getPets(user!.id),
                                  child:
                                      BlocBuilder<PetInfoCubit, PetInfoState>(
                                        builder: (context, state) {
                                          if (state is PetLoading) {
                                            return LottieLoding();
                                          }
                                          if (state is PetLoaded) {
                                            return Row(
                                              children: state.pets
                                                  .map(
                                                    (pet) =>
                                                        ContainerPetCardWidgets(
                                                          pet: pet,
                                                        ),
                                                  )
                                                  .toList(),
                                            );
                                          }
                                          if (state is PetError) {
                                            return Text(state.msg);
                                          }
                                          return Container();
                                        },
                                      ),
                                ),
                              ),

                        SizedBox(height: 16.h),
                        ListTielWidgets(
                          images: 'assets/images/material.png',
                          text: 'Security & Privacy',
                        ),
                        SizedBox(height: 13.h),
                        ListTielWidgets(
                          icone: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.language, size: 28.r),
                          ),
                          text: 'Language',
                        ),
                        SizedBox(height: 13.h),
                        InkWell(
                          onTap: () async {
                            await context.read<AuthCubit>().logOut();
                          },
                          child: ListTielWidgets(
                            icone: Icon(Icons.logout, size: 28.r),
                            text: 'Log out',
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
