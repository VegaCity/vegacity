// rest API
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// data impl
import 'package:base/features/package/data/model/response/packages_response.dart';
import 'package:base/features/package/data/model/request/packages_request.dart';

// utils
import 'package:base/utils/constants/api_constant.dart';
import 'package:base/utils/providers/common_provider.dart';

part 'package_source.g.dart';

@RestApi(
    baseUrl:
APIConstants.baseUrl,
    parser: Parser.MapSerializable)
abstract class PackageSource {
  factory PackageSource(Dio dio, {String baseUrl}) = _PackageSource;

  @GET(APIConstants.packages)
  Future<HttpResponse<PackageResponse>> getPackageType(
    @Header(APIConstants.contentHeader) String contentType,
    @Header(APIConstants.authHeader) String accessToken,
    @Queries() PackageRequest request,
  );
}

@riverpod
PackageSource packageSource(PackageSourceRef ref) {
  final dio = ref.read(dioProvider);
  return PackageSource(dio);
}
