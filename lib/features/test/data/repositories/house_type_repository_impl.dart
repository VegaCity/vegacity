// import local
import 'package:base/features/test/data/models/response/house_response.dart';
import 'package:base/features/test/data/models/resquest/house_request.dart';
import 'package:base/features/test/data/remote/house_source.dart';
import 'package:base/features/test/domain/repositories/house_type_repository.dart';
import 'package:base/models/request/paging_model.dart';

// utils
import 'package:base/utils/constants/api_constant.dart';
import 'package:base/utils/resources/remote_base_repository.dart';

class HouseTypeRepositoryImpl extends RemoteBaseRepository
    implements HouseTypeRepository {
  final bool addDelay;
  final HouseSource _houseSource;

  HouseTypeRepositoryImpl(this._houseSource, {this.addDelay = true});

  @override
  Future<HouseResponse> getHouseTypeData(
    {
    required String accessToken,
    required PagingModel request,
  }
  ) async {
    // mới
    final houseRequest = HouseRequest(
      // search: request.searchContent,
      page: request.pageNumber,
      size: request.pageSize,
    );

    print('log filter ở đây ${houseRequest.toString()}');
    return getDataOf(
      request: () => _houseSource.getHouseType(
        APIConstants.contentType,
        accessToken,
        houseRequest,
      ),
    );
  }
}
