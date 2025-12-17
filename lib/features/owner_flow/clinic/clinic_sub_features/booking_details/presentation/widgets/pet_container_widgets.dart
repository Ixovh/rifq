import 'package:flutter/material.dart';
import 'package:rifq/core/theme/app_theme.dart';


class PetContainerWidgets extends StatelessWidget {
  final double width;
  final double height;
  final double radius;
  final Widget child;

  const PetContainerWidgets({super.key, required this.width,
    required this.height,required this.radius,required this.child});


  @override
  Widget build(BuildContext context) {
 return Container(
     width: width,
     height: height,
     decoration: BoxDecoration(
       border: Border.all(
         color: context.neutral800,
       ),
       borderRadius: BorderRadius.circular(radius),
     ),
   child: child,
   ) ;

  }

}