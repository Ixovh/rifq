// import 'package:flutter/material.dart';
// import 'package:rifq/core/theme/app_theme.dart';

// class RecommendationCard extends StatelessWidget {
//   const RecommendationCard({super.key, required String imagePath});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(right: 12),
//       decoration: BoxDecoration(
//         color: context.neutral100,
//         borderRadius: BorderRadius.circular(24),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha:  0.08),
//             blurRadius: 12,
//             offset: const Offset(0, 6),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             flex: 4,
//             child: ClipRRect(
//               borderRadius: const BorderRadius.horizontal(
//                 left: Radius.circular(24),
//               ),
//               child: Container(
//                 height: double.infinity,
//                 color: Colors.grey[300],
//                 child: Image.asset(
//                 'assets/images/8.png',
//                 height: double.infinity,
//                 fit: BoxFit.cover,
//               ),
//               ),

//               // child: Image.asset(
//               //   'assets/images/modern_clinic.png',
//               //   height: double.infinity,
//               //   fit: BoxFit.cover,
//               // ),

//             ),
//           ),


//         ],
//       ),
//     );
//   }
// }
