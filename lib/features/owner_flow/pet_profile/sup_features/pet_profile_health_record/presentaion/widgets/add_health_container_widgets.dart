import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:rifq/core/theme/app_theme.dart';

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
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Text("Add Health Record", textAlign: TextAlign.center, style: context.body1.copyWith(color: context.primary300)),
            SizedBox(height: 12.h),
            Row(
              children: [
                Image.asset("assets/images/title.png"),
                SizedBox(width: 10.h),
                Text("Title",style:context.body2.copyWith(color: context.neutral800),),
              ],),
            SizedBox(height: 8.h),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Image.asset("assets/images/pet_icone.png"),
                SizedBox(width: 10.h),
                Text("Type",style:context.body2.copyWith(color: context.neutral800),),],),
            SizedBox(height: 8.h),
            TextField(
              controller: typeController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Image.asset("assets/images/menu-board.png"),
                SizedBox(width: 10.h),
                Text("Description",style:context.body2.copyWith(color: context.neutral800),),
              ],),
            SizedBox(height: 8.h),
            TextField(
              controller: descriptionController,
              maxLines: 2,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                ),

              ),
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Image.asset("assets/images/Group.png"),
                SizedBox(width: 10.h),
                Text("Clinic Name",style:context.body2.copyWith(color: context.neutral800),),
              ],
            ),
            SizedBox(height: 8.h),
            TextField(
              controller: clinicNameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Image.asset("assets/images/Group.png"),
                SizedBox(width: 10.h),
                Text("Date visit",style:context.body2.copyWith(color: context.neutral800),),
              ],
            ),
            TextField(
              controller: dateController,
              readOnly: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                ),
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
      ),
    );
  }
}
