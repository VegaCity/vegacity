// data - domain impl
import 'package:base/features/auth/domain/repositories/auth_repository.dart';
import 'package:base/features/auth/presentation/screens/sign_in/sign_in_controller.dart';
import 'package:base/features/profile/domain/entities/profile_entity.dart';
import 'package:base/features/profile/domain/repositories/profile_repository.dart';
import 'package:base/utils/enums/enums_export.dart';

// system
import 'package:flutter/material.dart';
import 'package:base/utils/commons/functions/shared_preference_utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';

// utils
import 'package:base/utils/commons/functions/api_utils.dart';
import 'package:base/utils/extensions/extensions_export.dart';
import 'package:base/utils/constants/api_constant.dart';

part 'profile_controller.g.dart';

@riverpod
class ProfileController extends _$ProfileController {
  @override
  FutureOr<void> build() {}

  Future<ProfileEntity?> getUser(
    BuildContext context,
 
  ) async {
    ProfileEntity? profile ;

    state = const AsyncLoading();
    final profileRepository = ref.read(profileRepositoryProvider);
    final authRepository = ref.read(authRepositoryProvider);
    final user = await SharedPreferencesUtils.getInstance('user_token');

        state = await AsyncValue.guard(() async {
      final response = await profileRepository.getProfile(
        accessToken: APIConstants.prefixToken + user!.tokens.accessToken,
      );
      profile = response.data;

    });

    if (state.hasError) {
      state = await AsyncValue.guard(
        () async {
          final statusCode = (state.error as DioException).onStatusDio();
          await handleAPIError(
            statusCode: statusCode,
            stateError: state.error!,
            context: context,
            onCallBackGenerateToken: () => reGenerateToken(
              authRepository,
              context,
            ),
          );

          // if refresh token expired
          if (state.hasError) {
            await ref.read(signInControllerProvider.notifier).signOut(context);
            return;
          }

          if (statusCode != StatusCodeType.unauthentication.type) {
            return;
          }

          await getUser(context);
        },
      );
    }

    return profile;
  }
}
