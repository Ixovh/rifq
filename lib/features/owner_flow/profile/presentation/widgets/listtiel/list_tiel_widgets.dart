import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq/core/theme/app_theme.dart';

class ListTielWidgets extends StatelessWidget {
  final String images;
  final String text;

  const ListTielWidgets({super.key, required this.images, required this.text});
  @override
  Widget build(BuildContext context) {
   return Card(
     color: context.neutral100,
     elevation: 2,
       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r),
       ),
     margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
     child: ListTile(
       leading:Image.asset(images),
       title: Text(text,style: TextStyle(fontSize: 16.sp)),

     ),
   );
  }
}

//ListTile(
//      leading:Image.asset(images),
//      title: Text(text,style: TextStyle(fontSize: 16.sp)),
//
//    );