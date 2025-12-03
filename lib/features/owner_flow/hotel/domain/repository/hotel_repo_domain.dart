import 'package:multiple_result/multiple_result.dart';
import '../entity/provider_service_entity.dart';

abstract class HotelRepoDomain {
//كل الفنادق
  Future<Result<List<ProviderServiceViewEntity>, String>> getAllHotel();
// تفاصيل فندق معين
  Future<Result<ProviderServiceViewEntity, String>> getHotelById(String id);
//حجز فندق
  Future<Result<bool, String>> bokingHotel();

}