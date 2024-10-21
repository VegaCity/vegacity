// rest API


import 'package:base/features/e-tag/data/model/request/etag_request.dart';
import 'package:base/features/e-tag/data/model/response/etag_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// data impl
import 'package:base/features/e-tag/data/model/response/card_response.dart';
import 'package:base/features/e-tag/data/model/request/card_request.dart';

// utils
import 'package:base/utils/constants/api_constant.dart';
import 'package:base/utils/providers/common_provider.dart';

part 'card_source.g.dart';

@RestApi(
    baseUrl:
APIConstants.baseUrl,
    parser: Parser.MapSerializable)
abstract class CardSource {
  factory CardSource(Dio dio, {String baseUrl}) = _CardSource;

  @GET(APIConstants.cards)
  Future<HttpResponse<CardResponse>> getCard(
    @Header(APIConstants.contentHeader) String contentType,
    @Header(APIConstants.authHeader) String accessToken,
    @Queries() CardRequest request,
  );

    @GET(APIConstants.etag)
  Future<HttpResponse<EtagResponse>> getEtagCard(
    @Header(APIConstants.contentHeader) String contentType,
    @Header(APIConstants.authHeader) String accessToken,
    @Queries() EtagRequest request,
  );
}

@riverpod
CardSource cardSource(CardSourceRef ref) {
  final dio = ref.read(dioProvider);
  return CardSource(dio);
}