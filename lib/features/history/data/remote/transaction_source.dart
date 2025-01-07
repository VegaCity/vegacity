// rest API
import 'package:base/features/history/data/model/request/transaction_request.dart';
import 'package:base/features/history/data/model/response/transaction_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// data impl


// utils
import 'package:base/utils/constants/api_constant.dart';
import 'package:base/utils/providers/common_provider.dart';

part 'transaction_source.g.dart';

@RestApi(
    baseUrl:
APIConstants.baseUrl,
    parser: Parser.MapSerializable)
abstract class TransactionSource {
  factory TransactionSource(Dio dio, {String baseUrl}) = _TransactionSource;

  @GET(APIConstants.historys)
  Future<HttpResponse<TransactionResponse>> getTransaction(
    @Header(APIConstants.contentHeader) String contentType,
    @Header(APIConstants.authHeader) String accessToken,
    @Queries() TransactionRequest request,
  );
}

@riverpod
TransactionSource transactionSource(TransactionSourceRef ref) {
  final dio = ref.read(dioProvider);
  return TransactionSource(dio);
}
