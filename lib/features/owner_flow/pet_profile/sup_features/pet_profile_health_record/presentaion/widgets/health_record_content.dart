// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:rifq/features/owner_flow/pet_profile/sup_features/pet_profile_health_record/domain/entity/health_record_entity.dart';
//
// class HealthRecord {
//   final String title;
//   final String description;
//   final DateTime date;
//
//   HealthRecord({required this.title, required this.description, required this.date});
// }
//
// class HealthRecordTab extends StatelessWidget {
//   final List<HealthRecordEntity> records;
//
//   const HealthRecordTab({super.key, required this.records});
//
//   @override
//   Widget build(BuildContext context) {
//     if (records.isEmpty) {
//       return Center(
//         child: Column(
//           crossAxisAlignment: .center,
//           children: [
//             Image.asset("assets/images/Frame .png"),
//              Text("No Health Record Yet",style: TextStyle(fontSize: 16.sp,color: Color(0xFF939090)),),
//
//           ],
//         ),
//       ) ;
//
//     }
//
//     return ListView.builder(
//       padding: const EdgeInsets.all(16),
//       itemCount: records.length,
//       itemBuilder: (context, index) {
//         final record = records[index];
//         return Card(
//           margin: const EdgeInsets.only(bottom: 12),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//           child: ListTile(
//             title: Text(record.title?? 'No title', style: const TextStyle(fontWeight: FontWeight.bold)),
//             subtitle: Text(record.description?? 'No description'),
//             trailing: Text("${record.date?.year}/${record.date?.month}/${record.date?.day}",
//               style: const TextStyle(fontSize: 12, color: Colors.grey),
//             ),
//
//           ),
//         );
//       },
//     );
//
//
//   }
// }
//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:rifq/core/theme/app_color.dart';
import 'package:rifq/features/owner_flow/pet_profile/sup_features/pet_profile_health_record/domain/entity/health_record_entity.dart';

import '../../../../../../../core/common/widgets/button/custome_button_widgets.dart';
import '../cubit/pet_profile_records_cubit.dart';
import 'add_health_container_widgets.dart';

class HealthRecordTab extends StatelessWidget {
  final List<HealthRecordEntity> records;

  const HealthRecordTab({super.key, required this.records});

  @override
  Widget build(BuildContext context) {
    // الستاك بدال السكافولد لان هذي ويدجت
    return Stack(
      children: [
        records.isEmpty
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/Frame .png"),
              SizedBox(height: 8),
              Text(
                "No Health Record Yet",
                style: TextStyle(
                    fontSize: 16.sp, color: Color(0xFF939090)),
              ),
            ],
          ),
        )
            : ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: records.length,
          itemBuilder: (context, index) {
            final record = records[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: ListTile(
                title: Text(
                  record.type,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle:
                Text(record.description ?? 'No description'),
                trailing: Text(
                  record.date != null
                      ? DateFormat("yyyy/MM/dd").format(record.date!)
                      : "No date",
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),

                // trailing: Text(
                //   "${record.date?.year}/${record.date?.month}/${record.date?.day}",
                //   style: const TextStyle(
                //       fontSize: 12, color: Colors.grey),
                // ),
              ),
            );
          },
        ),

        Positioned(
          bottom: 16,
          right: 16,
          child:FloatingActionButton.extended(
            onPressed: () {
              final typeController = TextEditingController();
              final descriptionController = TextEditingController();
              final clinicController = TextEditingController();
              final dateController = TextEditingController();
              final titleController=TextEditingController();

              final cubit = context.read<PetProfileRecordsCubit>();

              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.r),
                    topRight: Radius.circular(40.r),
                  ),
                ),
                builder: (context) => GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),// الكيبورد يتقفل
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                      left: 16.w,
                      right: 16.w,
                      top: 16.h,
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AddHealthContainerWidgets(
                              typeController: typeController,
                              descriptionController: descriptionController,
                              clinicNameController: clinicController,
                              dateController: dateController,
                              titleController: titleController,
                            ),
                            SizedBox(height: 12.h),
                  
                            CustomeButtonWidgets(
                              titel: 'Save Record',
                              onPressed: () async {
                                final recordDate = DateFormat('d/M/yyyy').parse(dateController.text);
                                final record = HealthRecordEntity(
                                  petId: cubit.state is PetProfileLoaded
                                      ? (cubit.state as PetProfileLoaded).petent.petId
                                      : '',
                                  title: typeController.text,
                                  description: descriptionController.text,
                                  clinicName: clinicController.text,
                                  date: recordDate,
                                  id: '',
                                  type: typeController.text,
                                );
                                await cubit.addHealthRecord(record);
                                context.pop();
                              },
                              buttonWidth: 366.w,
                              buttonhight: 58.h,),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
            backgroundColor: AppColors.primary300,
            icon: const Icon(Icons.add, color: Colors.white),
            label: const Text("Add Health Record", style: TextStyle(color: Colors.white)),
          )

          // FloatingActionButton.extended(
          //   onPressed: () {
          //   },
          //   backgroundColor: AppColors.primary300,
          //   icon:  Icon(Icons.add,color: Colors.white,),
          //   label: Text("Add Health Record",style: TextStyle(color: Colors.white),),
          // ),
        ),
      ],
    );
  }
}

