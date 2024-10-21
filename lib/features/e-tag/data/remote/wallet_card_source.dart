// rest API
import 'package:base/features/e-tag/data/model/response/wallet_card_response.dart';
import 'package:base/features/profile/data/models/response/wallet_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// 

// utils
import 'package:base/utils/constants/api_constant.dart';
import 'package:base/utils/providers/common_provider.dart';

part 'wallet_card_source.g.dart';

@RestApi(baseUrl: APIConstants.baseUrl, parser: Parser.MapSerializable)
abstract class WalletCardSource {
  factory WalletCardSource(Dio dio, {String baseUrl}) = _WalletCardSource;

  @GET(APIConstants.etag)
  Future<HttpResponse<WalletCardResponse>> getWalletEtag(
    @Header(APIConstants.contentHeader) String contentType,
    @Header(APIConstants.authHeader) String accessToken,
    @Query('id') String id,
    @Query('etagCode') String etagCode,
  );

}

@riverpod
WalletCardSource walletCardSource(WalletCardSourceRef ref) {
  final dio = ref.read(dioProvider);
  return WalletCardSource(dio);
}
