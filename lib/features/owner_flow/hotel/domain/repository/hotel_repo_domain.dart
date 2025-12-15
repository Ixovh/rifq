import 'package:multiple_result/multiple_result.dart';
import '../../../../../core/shared/shared_in_owner_flow/shared/entities/provider_entity.dart';
import '../../../../../core/shared/shared_in_owner_flow/shared/entities/provider_items_view_entity.dart';

abstract class HotelRepoDomain {
//كل الفنادق
  Future<Result<List<ProviderEntity>, String>> getAllHotel();
// تفاصيل فندق معين
//   Future<Result<ProviderItemsViewEntity, String>> getHotelById(String id);

  Future<Result<List<ProviderItemsViewEntity>, String>> getHotelById(String id);


}

// abstract class HotelRepoDomain {
//   Future<Result<List<ProviderEntity>, String>> getAllHotel();
// }