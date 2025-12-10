import 'package:flutter/material.dart';
import 'package:rifq/core/shared/shared_in_owner_flow/shared/entities/provider_entity.dart';
import 'clinic_card.dart';

class ClinicList extends StatelessWidget {
  final List<ProviderEntity> clinics;

  const ClinicList({super.key, required this.clinics});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, i) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: ClinicCard(clinic: clinics[i]),
        ),
        childCount: clinics.length,
      ),
    );
  }
}
