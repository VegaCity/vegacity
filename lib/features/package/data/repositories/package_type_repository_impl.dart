// import local
import 'package:base/features/package/data/model/request/packages_request.dart';
import 'package:base/features/package/data/model/response/packages_response.dart';
import 'package:base/features/package/data/remote/package_source.dart';
import 'package:base/features/package/domain/repositories/package_type_reponsitory.dart';

import 'package:base/models/request/paging_model.dart';

// utils
import 'package:base/utils/constants/api_constant.dart';
import 'package:base/utils/resources/remote_base_repository.dart';
import 'package:retrofit/dio.dart';

class PackageTypeRepositoryImpl extends RemoteBaseRepository
    implements PackageTypeReponsitory {
  final bool addDelay;
  final PackageSource _packageSource;

  PackageTypeRepositoryImpl(this._packageSource, {this.addDelay = true});

  @override
  Future<PackageResponse> getPackages(
    {
    required String accessToken,
    required PagingModel request,
  }
  ) async {
    // mới
    final packageRequest = PackageRequest(
      page: request.pageNumber,
      size: request.pageSize,
    );

    print('log filter ở đây ${packageRequest.toString()}');
    print('log filter ở đây ${accessToken}');
    return getDataOf(
      request: () => _packageSource.getPackageType(
        APIConstants.contentType,
        accessToken,
        packageRequest,
      ),
    );
  }
}
