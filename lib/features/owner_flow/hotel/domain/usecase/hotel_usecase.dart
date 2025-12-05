import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import '../entity/provider_service_entity.dart';
import '../repository/hotel_repo_domain.dart';

@lazySingleton
class HotelUsecase {
  final HotelRepoDomain hotelDomain;
  HotelUsecase(this.hotelDomain);

//كل الفنادق
  Future<Result<List<ProviderServiceViewEntity>, String>> getAllHotel()async{
    final hotelresult=await hotelDomain.getAllHotel();
    return hotelresult;
  }
  //
  //
  
// تفاصيل فندق معين
  Future<Result<ProviderServiceViewEntity, String>> getHotelById(String id) async {
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


}