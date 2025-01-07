// rest API
import 'package:base/features/profile/data/models/request/wallet_request.dart';
import 'package:base/features/profile/data/models/response/wallet_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// data impl

// utils
import 'package:base/utils/constants/api_constant.dart';
import 'package:base/utils/providers/common_provider.dart';

part 'wallet_source.g.dart';

@RestApi(baseUrl: APIConstants.baseUrl, parser: Parser.MapSerializable)
abstract class WalletSource {
  factory WalletSource(Dio dio, {String baseUrl}) = _WalletSource;

  @GET(APIConstants.wallet)
  Future<HttpResponse<WalletResponse>> getWallet(
    @Header(APIConstants.contentHeader) String contentType,
    @Header(APIConstants.authHeader) String accessToken,
    @Queries() WalletRequest request,
  );
}

@riverpod
WalletSource walletSource(WalletSourceRef ref) {
  final dio = ref.read(dioProvider);
  return WalletSource(dio);
}
