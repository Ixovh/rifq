import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/common/widgets/button/custome_button_widgets.dart';

class EditProfileScreen extends StatelessWidget {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailController=TextEditingController();
  final TextEditingController nameController=TextEditingController();

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: Colors.white,
     appBar:  AppBar(
       backgroundColor: Colors.white,
       surfaceTintColor: Colors.transparent,
       leading: IconButton(onPressed: (){},
           icon: Icon(Icons.arrow_back_ios)),
     ),
     body: SingleChildScrollView(
       child: Padding(
           padding: EdgeInsets.symmetric(horizontal: 24.w),
           child: Column(
             children: [
               SizedBox(height: 10.h),
               Center(
                 child: CircleAvatar(
                   radius: 60.r,
                   backgroundColor: Color(0xFFBBE9E3),
                   child: Text("S", style: TextStyle(
                     fontSize: 48.sp,
                     color: Colors.white,
                   ),
                   ),
                 ),
               ),
               SizedBox(height: 112.h),
               Form(
                 key: _formkey,
                 child: TextFormField(
                   controller: emailController,
                   decoration: InputDecoration(
                     label: Text("Email"),
                     border: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(18.r)
                     ),),
                   validator: (value) {
                     if (value == null || value.isEmpty) {
                       return "Please Enter Your Email!";
                     } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                       return "Enter a valid email!";
                     }
                     return null;
                     },),
               ),
                SizedBox(height: 26.h),
                TextField(
                 decoration: InputDecoration(
                   label: Text("Name"),
                   border: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(18.r)
                   ),
                 )
                ),
               SizedBox(height: 60.h),
               CustomeButtonWidgets(
                 titel: 'Update',
                 onPressed: () {},
                 buttonWidth: 366.w,
                 buttonhight: 58.h,)
             ],
           ),
         ),
     ),






   );
  }
}

