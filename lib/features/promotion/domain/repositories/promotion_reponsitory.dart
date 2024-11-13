
import 'package:base/features/promotion/data/models/response/promotion_response.dart';
import 'package:base/features/promotion/data/remote/promotion_source.dart';
import 'package:base/features/promotion/data/repositories/promotion_repository_impl.dart';

import 'package:base/models/request/paging_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'promotion_reponsitory.g.dart';

abstract class PromotionReponsitory {
  Future<PromotionResponse> getPromotions({
    required String accessToken,
    required PagingModel request,
  });
}

@Riverpod(keepAlive: true)
PromotionReponsitory promotionRepository(PromotionRepositoryRef ref) {
  final promotionSource = ref.read(promotionSourceProvider);
  return PromotionRepositoryImpl(promotionSource);
}
