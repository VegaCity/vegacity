// import local

import 'package:base/features/promotion/data/models/request/promotion_request.dart';
import 'package:base/features/promotion/data/models/response/promotion_response.dart';
import 'package:base/features/promotion/data/remote/promotion_source.dart';
import 'package:base/features/promotion/domain/repositories/promotion_reponsitory.dart';

import 'package:base/models/request/paging_model.dart';

// utils
import 'package:base/utils/constants/api_constant.dart';
import 'package:base/utils/resources/remote_base_repository.dart';

class PromotionRepositoryImpl extends RemoteBaseRepository
    implements PromotionReponsitory {
  final bool addDelay;
  final PromotionSource _promotionSource;

  PromotionRepositoryImpl(this._promotionSource, {this.addDelay = true});

  @override
  Future<PromotionResponse> getPromotions(
    {
    required String accessToken,
    required PagingModel request,
  }
  ) async {
    // mới
    final promotionRequest = PromotionRequest(
      page: request.pageNumber,
      size: request.pageSize,
    );

    print('log filter ở đây ${promotionRequest.toString()}');
    print('log filter ở đây $accessToken');
    return getDataOf(
      request: () => _promotionSource.getPromotion(
        APIConstants.contentType,
        accessToken,
        promotionRequest,
      ),
    );
  }
}
