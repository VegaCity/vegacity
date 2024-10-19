import 'package:base/features/package/data/model/response/packages_response.dart';
import 'package:base/features/package/data/remote/package_source.dart';
import 'package:base/features/package/data/repositories/package_type_repository_impl.dart';
import 'package:base/features/profile/data/models/response/profile_response.dart';
import 'package:base/features/profile/data/models/response/wallet_response.dart';
import 'package:base/features/profile/data/remote/profile_source.dart';
import 'package:base/features/profile/data/repositories/profile_repository_impl.dart';

import 'package:base/models/request/paging_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/widgets.dart';

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
