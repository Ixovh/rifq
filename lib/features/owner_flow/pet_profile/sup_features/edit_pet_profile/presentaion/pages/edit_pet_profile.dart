// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:rifq/core/di/setup.dart';
// import '../../../../../../../core/common/widgets/button/custome_button_widgets.dart';
// import '../../../pet_info_card/domain/entity/pet_profile_entity.dart';
// import '../../domain/usecase/edit_pet_profile_usecase.dart';
// import '../cubit/edit_pet_profile_cubit.dart';
// import '../widgets/custome_text_field_widgets.dart';
//
// class EditPetProfileScreen extends StatelessWidget {
//   final PetProfileEntity pet;
//
//   late final TextEditingController petNameController;
//   late final TextEditingController petAgeController;
//   late final TextEditingController petBreedController;
//
//   EditPetProfileScreen({super.key, required this.pet}) {
//     petNameController = TextEditingController(text: pet.name);
//     petAgeController = TextEditingController(text: pet.birthdate.toString().split('').first,
//     );    petBreedController = TextEditingController(text: pet.breed);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => EditPetProfileCubit(getIt<EditPetProfileUsecase>(), pet: pet),
//       child: BlocBuilder<EditPetProfileCubit, EditPetProfileState>(
//         builder: (context, state) {
//           final currentPet = state.pet;
//           final isLoading = state is EditPetProfileLoading;
//
//           return Scaffold(
//             appBar: AppBar(
//               surfaceTintColor: Colors.transparent,
//             ),
//             body: SingleChildScrollView(
//               padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
//               child: Column(
//                 children: [
//                   Stack(
//                     children: [
//                       CircleAvatar(
//                         radius: 60.r,
//                         backgroundImage: currentPet.photoUrl.isNotEmpty
//                             ? NetworkImage(currentPet.photoUrl)
//                             : null,
//                         child: isLoading
//                             ? CircularProgressIndicator()
//                             : null,
//                       ),
//                       Positioned(
//                         right: 0,
//                         bottom: 0,
//                         child: GestureDetector(
//                           onTap: () async {
//                             final picker = ImagePicker();
//                             final XFile? file = await picker.pickImage(source: ImageSource.gallery);
//                             if (file == null) return;
//
//                             // هنا نحدث الصورة في Cubit
//                             await context.read<EditPetProfileCubit>().updatePet(
//                               newPhotoUrl: file.path,
//                             );
//                           },
//                           child: CircleAvatar(
//                             radius: 18,
//                             backgroundColor: Colors.blue,
//                             child: Icon(Icons.edit, color: Colors.white, size: 18),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//
//                   SizedBox(height: 40.h),
//                   CustomeTextFieldWidgets(
//                     controller: petNameController,
//                     isLoading: true,
//                     lable: "Pet's Name",
//                   ),
//                   SizedBox(height: 20.h),
//                   CustomeTextFieldWidgets(
//                     controller: petAgeController,
//                     isLoading: false,
//                     lable: "Pet's Age",
//                     prefixIcon: Icons.date_range,
//                   ),
//                   SizedBox(height: 20.h),
//                   CustomeTextFieldWidgets(
//                     controller: petBreedController,
//                     isLoading: false,
//                     lable: "Pet's Breed",
//                   ),
//                   SizedBox(height: 30.h),
//                   CustomeButtonWidgets(
//                     titel: 'Save',
//                     buttonWidth: 366.w,
//                     buttonhight: 58.h,
//                     onPressed: () {
//                       context.read<EditPetProfileCubit>().updatePet(
//                         newName: petNameController.text,
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:rifq/core/di/setup.dart';
import '../../../../../../../core/common/widgets/button/custome_button_widgets.dart';
import '../../../../../../../core/theme/app_color.dart';
import '../../../pet_info_card/domain/entity/pet_profile_entity.dart';
import '../../domain/usecase/edit_pet_profile_usecase.dart';
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

    return BlocProvider(
      create: (context) =>
          EditPetProfileCubit(GetIt.I.get<EditPetProfileUsecase>(),pet: pet
            // supabase: Supabase.instance.client, pet: pet,
          ),
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          // leading: IconButton(onPressed: () {},
          //     icon: Icon(Icons.arrow_back_ios)),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: BlocBuilder<EditPetProfileCubit, EditPetProfileState>(
                  builder: (context, state) {
                    PetProfileEntity currentPet;
                    bool isLoading = false;
                    if (state is EditPetProfileInitial) currentPet = state.pet;
                    else if (state is EditPetProfileLoading) {
                      currentPet = state.pet;
                      isLoading = true;
                    } else if (state is EditPetProfileSuccess) currentPet = state.pet;
                    else if (state is EditPetProfileError) currentPet = state.pet;
                    else currentPet = pet;
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
                            onTap: () {
                              // context.read<EditPetProfileCubit>().pickNewPhoto(currentPet);
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
      ),
    );
  }
}