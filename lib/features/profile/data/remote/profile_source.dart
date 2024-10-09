// rest API
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// data impl
import 'package:base/features/profile/data/models/response/profile_response.dart';

// utils
import 'package:base/utils/constants/api_constant.dart';
import 'package:base/utils/providers/common_provider.dart';

part 'profile_source.g.dart';

@RestApi(baseUrl: APIConstants.baseUrl, parser: Parser.MapSerializable)
abstract class ProfileSource {
  factory ProfileSource(Dio dio, {String baseUrl}) = _ProfileSource;

  @GET('${APIConstants.user}/{id}')
  Future<HttpResponse<ProfileResponse>> getProfile(
    @Header(APIConstants.contentHeader) String contentType,
    @Header(APIConstants.authHeader) String accessToken,
    @Path('id') String id,
  );
}

@riverpod
ProfileSource profileSource(ProfileSourceRef ref) {
  final dio = ref.read(dioProvider);
  return ProfileSource(dio);
}
