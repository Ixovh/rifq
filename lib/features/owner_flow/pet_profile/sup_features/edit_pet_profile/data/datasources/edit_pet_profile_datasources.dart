import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class BaseEditPetProfile {
  Future<Result<Map<String, dynamic>, Object>> updatePetProfile(
    String id,
    String name,
    String imageUrl,
  );
}

@LazySingleton(as: BaseEditPetProfile)
class EditPetProfileDatasources implements BaseEditPetProfile {
  final SupabaseClient supabase;
  EditPetProfileDatasources(this.supabase);

  @override
  Future<Result<Map<String, dynamic>, Object>> updatePetProfile(
    String id,
    String name,
    String imageUrl,
  ) async {
    try {
      final response = await supabase
          .from('pets')
          .update({'name': name, 'photo': imageUrl})
          .eq('id', id)
          .select()
          .single();
      return Success(response);
    } catch (e) {
      return Error(e);
    }
  }
}
