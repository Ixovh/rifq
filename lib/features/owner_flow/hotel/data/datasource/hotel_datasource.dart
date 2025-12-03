import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../model/hotel_model.dart';

abstract  class BaseHotelDataSourc{
  Future<Result<List<HotelModel>, String>> getAllHotel();
  // تفاصيل فندق معين
  Future<Result<HotelModel, String>> getHotelById(String id);
  //حجز فندق
  Future<Result<bool, String>> bokingHotel();
}

@LazySingleton(as: BaseHotelDataSourc)
class HotelDataBase implements BaseHotelDataSourc {
  final SupabaseClient supabase;
  HotelDataBase(this.supabase);
  @override
  Future<Result<bool, String>> bokingHotel() {
    // TODO: implement bokingHotel
    throw UnimplementedError();
  }

  @override
  Future<Result<List<HotelModel>, String>> getAllHotel() async{
   try{
     final response=await supabase
         .from('provider_service_view').select();
     final data=(response as List).map((e)=>HotelModelMapper.fromMap(e)).toList();
     return Result.success(data);
   }catch(e){
     return Result.error(e.toString());
   }
  }
   //
  //
  @override
  Future<Result<HotelModel, String>> getHotelById(String id) async {
    try {
      final response = await supabase
          .from('provider_service_view')
          .select()
          .eq('provider_id', id)
          .maybeSingle();
      if (response == null) {
        return Result.error("Hotel not found");
      }
      final model = HotelModelMapper.fromMap(response);
      return Result.success(model);
    } catch (e) {
      return Result.error(e.toString());
    }
  }


// @override
  // Future<Result<HotelModel, String>> getHotelById(String id) async {
  //  try{
  //    final response= await supabase
  //        .from('provider_service_view')
  //        .select()
  //        .eq('provider_id', id).maybeSingle();
  //  final model=HotelModelMapper.fromMap(response);
  //  return Result.success(model);
  //  }catch(e){
  //    return Result.error(e.toString());
  //  }
  // }

}

