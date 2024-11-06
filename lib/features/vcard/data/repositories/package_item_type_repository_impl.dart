// import local
import 'package:base/features/vcard/data/model/request/packageItem_request.dart';
import 'package:base/features/vcard/data/model/request/etag_request.dart';
import 'package:base/features/vcard/data/model/response/packageItem_response.dart';
import 'package:base/features/vcard/data/model/response/etag_response.dart';
import 'package:base/features/vcard/data/remote/package_item_source.dart';
import 'package:base/features/vcard/domain/repositories/package_item_type_repository.dart';

import 'package:base/models/request/paging_model.dart';

// utils
import 'package:base/utils/constants/api_constant.dart';
import 'package:base/utils/resources/remote_base_repository.dart';

class PackageItemTypeRepositoryImpl extends RemoteBaseRepository
    implements PackageItemTypeRepository {
  final bool addDelay;
  final PackageItemSource _packageItemSource;

  PackageItemTypeRepositoryImpl(this._packageItemSource, {this.addDelay = true});

  @override
  Future<PackageitemResponse> getCard({
    required String accessToken,
    required PagingModel request,
  }) async {
    // mới
    final packageitemRequest = PackageitemRequest(
      page: request.pageNumber,
      size: request.pageSize,
    );

    return getDataOf(
      request: () => _packageItemSource.getCard(
        APIConstants.contentType,
        accessToken,
        packageitemRequest,
      ),
    );
  }

  @override
  Future<EtagResponse> getEtagCard({
    required String accessToken,
    required String etagCode,
  }) async {
    // mới
    final etagRequest = EtagRequest(
      etagCode: etagCode,
    );

    print('EtagcodeLog: $etagCode');

    return getDataOf(
      request: () => _packageItemSource.getEtagCard(
        APIConstants.contentType,
        accessToken,
        etagRequest,
      ),
    );
  }
}
