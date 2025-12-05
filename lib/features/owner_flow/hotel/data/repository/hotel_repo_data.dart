import 'package:injectable/injectable.dart';
import 'package:multiple_result/src/result.dart';
import '../../domain/repository/hotel_repo_domain.dart';
import '../datasource/hotel_datasource.dart';
import '../model/hotel_model.dart';


@LazySingleton(as: HotelRepoDomain)
class HotelRepoData implements HotelRepoDomain {
  final BaseHotelDataSourc dataHotel;
  HotelRepoData(this.dataHotel);
  @override
  Future<Result<List<HotelModel>, String>> getAllHotel() async{
  final result= await dataHotel.getAllHotel();
  return result;
  }

  @override
  Future<Result<HotelModel, String>> getHotelById(String id) async{
  final result= await dataHotel.getHotelById(id);
  return result;
  }

}