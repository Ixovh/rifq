import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rifq/core/theme/app_theme.dart';

class AddPetScreen extends StatelessWidget {
  const AddPetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.background,
      appBar: AppBar(
        leading: Icon(CupertinoIcons.back, color: context.neutral1000 ,size: 30,),
        backgroundColor: context.background,
        title: Text('Add Your Pet', style: context.body1),
        centerTitle: true,
      ),
    );
  }
}