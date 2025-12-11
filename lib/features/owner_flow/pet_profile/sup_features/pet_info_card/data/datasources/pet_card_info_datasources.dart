import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/pet_profile_model.dart';

abstract class PatCard{
  Future<List<PetProfileModel>> getPetsByOwner(String ownerId);
  Future<PetProfileModel> getPetById(String petId);

}

@LazySingleton(as:PatCard )
class PetCardInfoDatasources  implements PatCard {
  final SupabaseClient supabase;
  PetCardInfoDatasources(this.supabase);

  @override
  Future<PetProfileModel> getPetById(String petId) async {
    final response = await supabase
        .from('pet_profile_view')
        .select()
        .eq('id', petId)
        .single();
    return PetProfileModelMapper.fromMap(response);
  }

  @override
  Future<List<PetProfileModel>> getPetsByOwner(String ownerId) async {
    final response = await supabase
        .from('pet_profile_view')
        .select()
        .eq('user_id', ownerId);
    return response.map((e) => PetProfileModelMapper.fromMap(e)).toList();
  }

}