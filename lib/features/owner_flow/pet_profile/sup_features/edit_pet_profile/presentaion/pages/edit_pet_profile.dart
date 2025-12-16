import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../core/common/widgets/button/custome_button_widgets.dart';
import '../../../../../../../core/theme/app_color.dart';
import '../../../pet_info_card/domain/entity/pet_entity.dart';
import '../cubit/edit_pet_profile_cubit.dart';
import '../widgets/custome_text_field_widgets.dart';

class EditPetProfileScreen extends StatelessWidget {
  late final TextEditingController petNameController;
  late final TextEditingController petAgeController;
  late final TextEditingController petBreedController;
  final PetProfileEntity pet;
  EditPetProfileScreen({super.key,required this.pet}){
    petNameController = TextEditingController(text: pet.name);
    petAgeController = TextEditingController(text: pet.birthdate.toIso8601String());
    petBreedController = TextEditingController(text: pet.breed);
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,

        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: BlocBuilder<EditPetProfileCubit, EditPetProfileState>(
                  builder: (context, state) {
                    PetProfileEntity currentPet;
                    bool isLoading = false;
                    if (state is EditPetProfileInitial) {
                      currentPet = state.pet;
                    } else if (state is EditPetProfileLoading) {
                      currentPet = state.pet;
                      isLoading = true;
                    } else if (state is EditPetProfileSuccess) {currentPet = state.pet;}
                    else if (state is EditPetProfileError) {currentPet = state.pet;}
                    else {currentPet = pet;}
                    return Stack(
                      children: [
                        CircleAvatar(
                          radius: 60.r,
                          backgroundImage: currentPet.photoUrl.isNotEmpty
                              ? NetworkImage(currentPet.photoUrl)
                              : null,
                          child: isLoading
                              ? CircularProgressIndicator(color: AppColors.primary300)
                              : null,),
                        Positioned(
                          right: 0,
                          bottom: 2,
                          child: GestureDetector(
                            onTap: () async {
                              final cubit = context.read<EditPetProfileCubit>();
                              final newUrl = await cubit.pickAndUploadPhoto();

                              if (newUrl != null) {
                                cubit.updatePet(newPhotoUrl: newUrl);
                              }
                            },
                            child: CircleAvatar(
                              radius: 18,
                              backgroundColor: AppColors.primary300,
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              SizedBox(height: 99.h),
              CustomeTextFieldWidgets(
                controller: petNameController,
                isLoading: true, // اسمح للمستخدم انه يعدل الاسم
                lable: 'Pet’s Name',),
              SizedBox(height: 44.h),
              CustomeTextFieldWidgets(
                controller: petAgeController,
                isLoading: false,
                lable: 'Pet’s age',
                prefixIcon: Icons.date_range,
              ),

              SizedBox(height: 44.h),
              CustomeTextFieldWidgets(
                controller: petBreedController,
                isLoading: false,
                lable: 'Pet’s breed',
              ),

              SizedBox(height: 80.h,),

              CustomeButtonWidgets(
                titel: 'Save', onPressed: () {
                context.read<EditPetProfileCubit>().updatePet(
                  newName: petNameController.text,
                );
              },
                buttonWidth: 366.w,
                buttonhight: 58.h,)

            ],
          ),
        ),
      );

  }
}