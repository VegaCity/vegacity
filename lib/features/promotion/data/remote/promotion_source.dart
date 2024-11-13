// rest API
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// data impl
import 'package:base/features/promotion/data/models/request/promotion_request.dart';
import 'package:base/features/promotion/data/models/response/promotion_response.dart';
// utils
import 'package:base/utils/constants/api_constant.dart';
import 'package:base/utils/providers/common_provider.dart';

part 'promotion_source.g.dart';

@RestApi(baseUrl: APIConstants.baseUrl, parser: Parser.MapSerializable)
abstract class PromotionSource {
  factory PromotionSource(Dio dio, {String baseUrl}) = _PromotionSource;

  @GET(APIConstants.promotions)
  Future<HttpResponse<PromotionResponse>> getPromotion(
    @Header(APIConstants.contentHeader) String contentType,
    @Header(APIConstants.authHeader) String accessToken,
    @Queries() PromotionRequest request,
  );
}

@riverpod
PromotionSource promotionSource(PromotionSourceRef ref) {
  final dio = ref.read(dioProvider);
  return PromotionSource(dio);
}
