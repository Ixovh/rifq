import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq/core/theme/app_theme.dart';
import '../widgets/appointment_content.dart';
import '../widgets/cstoum_tab_bar.dart';
import '../widgets/health_record_content.dart';



class PetProfile_healthappointment_Screen  extends StatelessWidget{
  const PetProfile_healthappointment_Screen({super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(title: Text("Pet Profile",style: context.h5.copyWith(color: context.primary300),),
          centerTitle: true,
          actions:[
            InkWell(onTap: (){},
                child: Image.asset("assets/images/edit.png")),
          ]
        ),
        body: Column(
            crossAxisAlignment: .center,
            children: [
              CircleAvatar(
                radius: 60.r,
            ),
              Text("Name pet"),
              Text("British Shorthair"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("age"),
                SizedBox(width: 5.w),
                Text("male"),
              ],),
              CustomTabBar(),
              Expanded(
                child: TabBarView(
                  children: [
                    HealthRecordTab(records: []),
                    AppointmentTab(appointments: [])
                  ],
                ),
              ),


            ],
          ),
        ),
      );
  }
}