// rest API
import 'package:base/features/history/data/model/request/history_request.dart';
import 'package:base/features/history/data/model/response/history_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// data impl


// utils
import 'package:base/utils/constants/api_constant.dart';
import 'package:base/utils/providers/common_provider.dart';

part 'history_source.g.dart';

@RestApi(
    baseUrl:
APIConstants.baseUrl,
    parser: Parser.MapSerializable)
abstract class HistorySource {
  factory HistorySource(Dio dio, {String baseUrl}) = _HistorySource;

  @GET(APIConstants.transactions)
  Future<HttpResponse<HistoryResponse>> getHistory(
    @Header(APIConstants.contentHeader) String contentType,
    @Header(APIConstants.authHeader) String accessToken,
    @Queries() HistoryRequest request,
  );
}

@riverpod
HistorySource historySource(HistorySourceRef ref) {
  final dio = ref.read(dioProvider);
  return HistorySource(dio);
}
