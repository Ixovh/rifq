import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import '../../../../../core/shared/shared_in_owner_flow/shared/entities/provider_entity.dart';
import '../../../../../core/shared/shared_in_owner_flow/shared/entities/provider_items_view_entity.dart';
import '../repository/hotel_repo_domain.dart';

@lazySingleton
class HotelUsecase {
  final HotelRepoDomain hotelDomain;
  HotelUsecase(this.hotelDomain);

//كل الفنادق
  Future<Result<List<ProviderEntity>, String>> getAllHotel()async{
    final hotelresult=await hotelDomain.getAllHotel();
    return hotelresult;
  }
// تفاصيل فندق معين
  Future<Result<List<ProviderItemsViewEntity>, String>> getHotelById(String id)async {
    if (id.isEmpty) {
      return Result.error("Hotel ID cannot be empty");
    }try {
      return await hotelDomain.getHotelById(id);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  Future<Result<List<ProviderEntity>, String>> searchHotels(String query) {
    return hotelDomain.searchHotels(query);
  }


}