// rest API

import 'package:base/features/vcard/data/model/request/etag_request.dart';
import 'package:base/features/vcard/data/model/response/vcard_response.dart';
import 'package:base/features/vcard/data/model/response/vcard_response_v2.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// data impl
import 'package:base/features/vcard/data/model/response/packageItem_response.dart';
import 'package:base/features/vcard/data/model/request/packageItem_request.dart';

// utils
import 'package:base/utils/constants/api_constant.dart';
import 'package:base/utils/providers/common_provider.dart';

part 'package_item_source.g.dart';

@RestApi(baseUrl: APIConstants.baseUrl, parser: Parser.MapSerializable)
abstract class PackageItemSource {
  factory PackageItemSource(Dio dio, {String baseUrl}) = _PackageItemSource;

  @GET(APIConstants.packageitem)
  Future<HttpResponse<PackageitemResponse>> getCard(
    @Header(APIConstants.contentHeader) String contentType,
    @Header(APIConstants.authHeader) String accessToken,
    @Queries() PackageitemRequest request,
  );

  @GET(APIConstants.card)
  Future<HttpResponse<VcardResponse>> getEtagCard(
    @Header(APIConstants.contentHeader) String contentType,
    @Header(APIConstants.authHeader) String accessToken,
    @Queries() VcardRequest request,
    // @Path('id') String id,
  );
  @GET(APIConstants.card)
  Future<HttpResponse<VcardResponseV2>> getEtagCardV2(
    @Header(APIConstants.contentHeader) String contentType,
    @Header(APIConstants.authHeader) String accessToken,
    @Queries() VcardRequest request,
    // @Path('id') String id,
  );
}

@riverpod
PackageItemSource packageItemSource(PackageItemSourceRef ref) {
  final dio = ref.read(dioProvider);
  return PackageItemSource(dio);
}
