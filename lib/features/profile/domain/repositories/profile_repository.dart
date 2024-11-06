import 'package:base/features/profile/data/models/response/profile_response.dart';
import 'package:base/features/profile/data/remote/profile_source.dart';
import 'package:base/features/profile/data/repositories/profile_repository_impl.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_repository.g.dart';

abstract class ProfileRepository {
  Future<ProfileResponse> getProfile({
    required String accessToken,
  });

}

@Riverpod(keepAlive: true)
ProfileRepository profileRepository(ProfileRepositoryRef ref) {
  final profileSource = ref.read(profileSourceProvider);
  return ProfileRepositoryImpl(profileSource);
}
