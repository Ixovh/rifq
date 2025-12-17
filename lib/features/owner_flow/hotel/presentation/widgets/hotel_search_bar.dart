import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/hotel_cubit.dart';

class HotelSearchBar extends StatelessWidget {
  const HotelSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HotelCubit>();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        onChanged: (value) {
          if (value.isEmpty) {
            cubit.fetchAllHotels();
          } else {
            cubit.searchHotels(value);
          }
        },
        decoration: InputDecoration(
          hintText: "Search for nearby Hotel",
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
