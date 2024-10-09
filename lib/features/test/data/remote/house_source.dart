// rest API
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// data impl
import 'package:base/features/test/data/models/response/house_response.dart';
import 'package:base/features/test/data/models/resquest/house_request.dart';

// utils
import 'package:base/utils/constants/api_constant.dart';
import 'package:base/utils/providers/common_provider.dart';

part 'house_source.g.dart';

//test
@RestApi(
    baseUrl: APIConstants.baseUrl
//  "https://dummyjson.com/c/daa3-02b0-479a-be2d"
    ,
    parser: Parser.MapSerializable)
abstract class HouseSource {
  factory HouseSource(Dio dio, {String baseUrl}) = _HouseSource;

  @GET(APIConstants.packages)
  Future<HttpResponse<HouseResponse>> getHouseType(
    @Header(APIConstants.contentHeader) String contentType,
    @Header(APIConstants.authHeader) String accessToken,
    @Queries() HouseRequest request,
  );
}

@riverpod
HouseSource houseSource(HouseSourceRef ref) {
  final dio = ref.read(dioProvider);
  return HouseSource(dio);
}
