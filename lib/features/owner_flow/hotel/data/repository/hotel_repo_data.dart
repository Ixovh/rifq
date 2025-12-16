import 'package:injectable/injectable.dart';
import 'package:multiple_result/src/result.dart';
import 'package:rifq/core/shared/shared_in_owner_flow/shared/entities/provider_entity.dart';
import '../../../../../core/shared/shared_in_owner_flow/shared/models/provider_items_view_model.dart';
import '../../../../../core/shared/shared_in_owner_flow/shared/models/provider_model.dart';
import '../../domain/repository/hotel_repo_domain.dart';
import '../datasource/hotel_datasource.dart';


@LazySingleton(as: HotelRepoDomain)
class HotelRepoData implements HotelRepoDomain {
  final BaseHotelDataSourc dataHotel;
  HotelRepoData(this.dataHotel);
  @override
  Future<Result<List<ProviderModel>, String>> getAllHotel() async{
  final result= await dataHotel.getAllHotel();
  return result;
  }



  @override
  Future<Result<List<ProviderItemsViewModel>, String>> getHotelById(String id)async{
  final result= await dataHotel.getHotelById(id);
  return result;
  }
  @override
  Future<Result<List<ProviderEntity>, String>> searchHotels(String query) async {
    final result = await dataHotel.searchHotels(query);

    return result.when(
          (success) => Result.success(
        success.map((m) => m as ProviderEntity).toList(),
      ),
          (error) => Result.error(error),
    );
  }


}