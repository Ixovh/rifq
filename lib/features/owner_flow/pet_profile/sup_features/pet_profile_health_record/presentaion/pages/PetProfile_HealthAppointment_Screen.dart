import 'package:flutter/material.dart';
import 'package:rifq/core/theme/app_theme.dart';

class PetProfile_healthappointment_Screen  extends StatelessWidget{
  const PetProfile_healthappointment_Screen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pet Profile",style: context.h5.copyWith(color: context.primary300),),
        leading: InkWell(onTap: (){},
            child: Image.asset("assets/images/edit.png")),
      ),
    );
  }
}