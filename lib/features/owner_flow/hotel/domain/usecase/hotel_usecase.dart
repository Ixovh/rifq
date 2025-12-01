import 'package:multiple_result/multiple_result.dart';

import '../entity/provider_entity.dart';
import '../repository/hotel_repo_domain.dart';

class HotelUsecase {

final HotelRepoDomain hotelDomain;

HotelUsecase(this.hotelDomain);

//كل الفنادق
  Future<Result<List<ProviderEntity>, String>> getAllHotel()async{
    final hotelresult=await hotelDomain.getAllHotel();
    return hotelresult;
  }
  //
  //
  
// تفاصيل فندق معين
  Future<Result<ProviderEntity, String>> getHotelById(String id) async {
    if (id.isEmpty) {
      return Result.error("Hotel ID cannot be empty");
    }try {
      return await hotelDomain.getHotelById(id);
    } catch (e) {
      return Result.error(e.toString());
    }
  }


  //
  //
  
//حجز فندق
//Todo:  احتاج اعرف هل لازم امرر له براميتر ؟

//   Future<Result<bool, String>> bokingHotel()async{
//     return await hotelDomain.bokingHotel();
//   }
}