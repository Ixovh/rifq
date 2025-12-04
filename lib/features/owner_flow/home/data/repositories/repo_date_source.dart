// // ignore_for_file: implementation_imports

// import 'package:injectable/injectable.dart';
// import 'package:multiple_result/src/result.dart';
// import 'package:weekend_projct_2/core/shared/shared_auth/entities/auth_entity.dart';
// import 'package:weekend_projct_2/features/loading/data/datasources/loading_datasource.dart';
// import 'package:weekend_projct_2/features/loading/domain/repositories/loading_repo_domain.dart';

// @Injectable(as: LoadingRepoDomain)
// @lazySingleton
// class RepoLoadingDateSource implements LoadingRepoDomain {
//   final LocalLoadingDataSource dataSource;

//   RepoLoadingDateSource({required this.dataSource});

//   @override
//   Future<Result<AuthEntity, Object>> checkAuth() {
//     return dataSource.checkAuth();
//   }
// }
