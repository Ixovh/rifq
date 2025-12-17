import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/clinic_cubit.dart';

class ClinicSearchBar extends StatelessWidget {
  const ClinicSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ClinicCubit>();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        onChanged: (value) {
          if (value.isEmpty) {
            cubit.loadClinicScreen();
          } else {
            cubit.searchClinics(value);
          }
        },
        decoration: InputDecoration(
          hintText: "Search for nearby clinics",
          prefixIcon: const Icon(Icons.search),
          suffixIcon: const Icon(Icons.tune),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.all(14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
