import 'package:multiple_result/multiple_result.dart';

import '../entity/provider_entity.dart';

abstract class HotelRepoDomain {
//كل الفنادق
  Future<Result<List<ProviderEntity>, String>> getAllHotel();
// تفاصيل فندق معين
  Future<Result<ProviderEntity, String>> getHotelById(String id);
//حجز فندق
  Future<Result<bool, String>> bokingHotel();

}