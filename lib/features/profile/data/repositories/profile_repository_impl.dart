// import local

import 'package:base/features/profile/data/models/response/profile_response.dart';
import 'package:base/features/profile/data/remote/profile_source.dart';
import 'package:base/features/profile/domain/repositories/profile_repository.dart';


// utils
import 'package:base/utils/constants/api_constant.dart';
import 'package:base/utils/resources/remote_base_repository.dart';
import 'package:base/utils/commons/functions/functions_common_export.dart';


class ProfileRepositoryImpl extends RemoteBaseRepository
    implements ProfileRepository {
  final bool addDelay;
  final ProfileSource _profileSource;

  ProfileRepositoryImpl(this._profileSource, {this.addDelay = true});

  @override
  Future<ProfileResponse> getProfile({
    required String accessToken,
  }) async {
    // mới
    final user = await SharedPreferencesUtils.getInstance('user_token');
    final userId = user?.id;

    return getDataOf(
      request: () => _profileSource.getProfile(
        APIConstants.contentType,
        accessToken,
        userId ?? '',
      ),
    );
  }

    

}
