import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rifq/features/owner_flow/add_pet/data/models/pet_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final supabase = Supabase.instance.client;

  Future<void> loadHomeData() async {
    emit(HomeLoading());


    final user = supabase.auth.currentUser;

    //-----user isnt logged in
    if (user == null) {
      emit(HomeGuestState());
      return;
    }

    try {
      //----user is logged in
      final profile = await supabase
          .from('users')
          .select('id, name')
          .eq('auth_id', user.id)
          .maybeSingle();

      final username = profile?['name'] ?? "User";
      final ownerId = profile?['id'];

      final petsData = await supabase
          .from('pets')
          .select()
          .eq('owner_id', ownerId);

      final pets = (petsData as List<dynamic>)
          .map((e) => PetModelMapper.fromJson(jsonEncode(e)))
          .toList();

      emit(HomeLoaded(username: username, pets: pets));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
