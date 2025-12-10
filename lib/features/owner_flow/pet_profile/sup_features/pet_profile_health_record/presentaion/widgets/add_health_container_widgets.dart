// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:rifq/core/theme/app_color.dart';
//
// class AddHealthContainerWidgets extends StatelessWidget {
//   final TextEditingController typeControolerfield = TextEditingController();
//   final TextEditingController descrpcontrooler = TextEditingController();
//   final TextEditingController clinicNameControoler = TextEditingController();
//   final TextEditingController dateControoler = TextEditingController();
//
//   AddHealthContainerWidgets({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           Text(
//             "Add Health Record For Pets",
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: 14.sp,
//               color:AppColors.primary300,
//             ),
//           ),
//           SizedBox(height: 12.h),
//           TextField(
//             style: TextStyle(color: Color(0xFFECDFCC)),
//             controller:typeControolerfield ,
//             autofocus: true,
//             decoration: InputDecoration(
//               label: Text('Type', style: TextStyle(fontSize: 13, color:Colors.black ),),
//             ),
//           ),
//
//           SizedBox(height: 12.h),
//           TextField(
//             style: TextStyle(color: Color(0xFFECDFCC)),
//             controller:descrpcontrooler ,
//             maxLines: 2,
//             autofocus: true,
//             decoration: InputDecoration(
//               label: Text('Description ', style: TextStyle(fontSize: 13, color:Colors.black ),),
//             ),
//           ),
//           SizedBox(height: 12.h),
//           TextField(
//             style: TextStyle(color: Color(0xFFECDFCC)),
//             controller:clinicNameControoler ,
//             autofocus: true,
//             decoration: InputDecoration(
//               label: Text('Clinic Name ', style: TextStyle(fontSize: 13, color:Colors.black ),),
//             ),
//           ),
//           SizedBox(height: 12.h),
//           TextField(
//             style: TextStyle(color: Color(0xFFECDFCC)),
//             controller:dateControoler ,
//             autofocus: true,
//             decoration: InputDecoration(
//               label: Text('Date visit ', style: TextStyle(fontSize: 13, color:Colors.black ),),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../../../../core/theme/app_color.dart';

class AddHealthContainerWidgets extends StatelessWidget {
  final TextEditingController typeController;
  final TextEditingController descriptionController;
  final TextEditingController clinicNameController;
  final TextEditingController dateController;
  final TextEditingController titleController;

  const AddHealthContainerWidgets({
    super.key,
    required this.typeController,
    required this.descriptionController,
    required this.clinicNameController,
    required this.dateController,
    required this.titleController,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            "Add Health Record For Pets",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.primary300,
            ),
          ),
          SizedBox(height: 12.h),
          TextField(
            controller: titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          SizedBox(height: 12.h),
          TextField(
            controller: typeController,
            decoration: const InputDecoration(labelText: 'Type'),
          ),
          SizedBox(height: 12.h),
          TextField(
            controller: descriptionController,
            maxLines: 2,
            decoration: const InputDecoration(labelText: 'Description'),
          ),
          SizedBox(height: 12.h),
          TextField(
            controller: clinicNameController,
            decoration: const InputDecoration(labelText: 'Clinic Name'),
          ),
          SizedBox(height: 12.h),
          TextField(
            controller: dateController,
            readOnly: true,
            decoration: InputDecoration(
              labelText: 'Date visit',
            ),
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (pickedDate != null) {
                dateController.text = DateFormat('d/M/yyyy').format(pickedDate);
              }
            },
          ),

        ],
      ),
    );
  }
}
