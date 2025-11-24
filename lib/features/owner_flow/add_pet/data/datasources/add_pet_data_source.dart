import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:rifq/features/owner_flow/add_pet/data/models/pet_model.dart';

abstract class BaseAddPetDataSource {
  Future<PetModel> addPet({
    required String ownerId,
    required String name,
    required String species,
    required String gender,
    required String breed,
    required DateTime birthdate,
    required File photoFile,
  });
}

class AddPetDataSource implements BaseAddPetDataSource {
  final SupabaseClient supabase;

  AddPetDataSource(this.supabase);

  @override
  Future<PetModel> addPet({
    required String ownerId,
    required String name,
    required String species,
    required String gender,
    required String breed,
    required DateTime birthdate,
    required File photoFile,
  }) async {

    final fileName = '${DateTime.now().millisecondsSinceEpoch}_${photoFile.path.split('/').last}';

    // final uploadResult = await supabase.storage
    //     .from('pets')
    //     .upload(fileName, photoFile);

    final photoUrl = supabase.storage
        .from('pets')
        .getPublicUrl(fileName);

    final response = await supabase.from('pets').insert({
      'owner_id': ownerId,
      'name': name,
      'species': species,
      'gender': gender,
      'breed': breed,
      'birthdate': birthdate.toIso8601String(),
      'photo': photoUrl,
    }).select().single();

    return PetModelMapper.fromMap(response);
  }
}
