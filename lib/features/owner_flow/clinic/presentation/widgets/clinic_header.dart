import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rifq/core/theme/app_theme.dart';
import 'package:rifq/features/owner_flow/home/presentation/widgets/pet_circle_widget.dart';
import 'package:rifq/features/owner_flow/add_pet/data/models/pet_model.dart';

class ClinicHeader extends StatelessWidget {
  final List<PetModel> pets;

  const ClinicHeader({super.key, required this.pets});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF9FE8D1), Color(0xFFA4E3D0)],
        ),
      ),
      padding: const EdgeInsets.only(bottom: 24, left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 12),
          Text(
            "Medical Records",
            style: context.body1.copyWith(color: context.primary500),
          ),
          SizedBox(height: 12),

          //!========= Pets Horizontal List ==========
          SizedBox(
            height: 110,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, i) => PetCircleWidget(
                petName: pets[i].name,
                imageUrl: pets[i].photoUrl,
                onTap: () {
                  // context.push(Ro)
                },
              ),
              separatorBuilder: (_, _) => const SizedBox(width: 10),
              itemCount: pets.length,
            ),
          ),
        ],
      ),
    );
  }
}
