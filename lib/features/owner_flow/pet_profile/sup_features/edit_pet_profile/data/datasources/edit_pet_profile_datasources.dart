import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class BaseEditPetProfile {
  Future<Result<Null,Object>>updatePetProfile(String id,String name,String imageUrl );
}

@LazySingleton(as: BaseEditPetProfile)
class EditPetProfileDatasources implements BaseEditPetProfile {
  final SupabaseClient supabase;
  EditPetProfileDatasources(this.supabase);

  @override
  Future<Result<Null,Object>> updatePetProfile(String id, String name, String imageUrl) async {
    try {
      await supabase.from('pets')
          .update({'name': name, 'photo': imageUrl})
          .eq('id', id);
      return Success(null);
    } catch (e) {
      return Error(e);
    }
  }

//   Future<Result<Null, Object>> updatePetProfile(String name, String imageUrl) async {
//       try {
//         final response = await supabase
//             .from('pets')
//             .select('id')
//             .single();
//  await supabase
//         .from('pets')
//         .update({'name':name,'photo':imageUrl})
//         .eq('id', response['id']);
//     return Success(null);
//   } catch (e) {
//         return Error(e);
//     // throw Exception("Error updating pet profile: ${e.toString()}");
//   }
// }

  }




