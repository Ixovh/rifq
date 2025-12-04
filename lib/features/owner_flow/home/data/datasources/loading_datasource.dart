// import 'package:get_storage/get_storage.dart';
// import 'package:injectable/injectable.dart';
// import 'package:multiple_result/multiple_result.dart';
// import '../../../../core/shared/shared_auth/entities/auth_entity.dart';
// import '../../../../core/shared/shared_auth/models/auth_model.dart';

// abstract class BaseLoadingDataSource {
//   Future<Result<AuthEntity, Object>> checkAuth();

// }


// @lazySingleton
// class LocalLoadingDataSource implements BaseLoadingDataSource {
//   final GetStorage _box;

//   LocalLoadingDataSource(this._box);
//   @override
//   Future<Result<AuthEntity, Object>> checkAuth() async {
//     try {
//       if (_box.hasData('login')) {
//         final data = await _box.read('login');
//         return Success(AuthModelMapper.fromJson(data));
//       }
//       return Error(false);
//     } catch (error) {
//       return Error(error);
//     }
//   }
// }
