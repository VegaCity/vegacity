import 'package:base/features/auth/presentation/screens/sign_in/sign_in_controller.dart';
import 'package:base/features/package/domain/entities/packages_entities.dart';
import 'package:base/features/package/domain/repositories/package_type_reponsitory.dart';
import 'package:base/utils/enums/enums_export.dart';
import 'package:flutter/material.dart';

import 'package:base/models/request/paging_model.dart';
import 'package:base/utils/commons/functions/shared_preference_utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';


import 'package:base/features/auth/domain/repositories/auth_repository.dart';



import 'package:base/utils/commons/functions/api_utils.dart';
import 'package:base/utils/extensions/extensions_export.dart';
import 'package:base/utils/constants/api_constant.dart';

part 'package_controller.g.dart';

@riverpod
class PackageController extends _$PackageController {
  @override
  FutureOr<void> build() {}

  Future<List<PackageEntities>> getPackages(
    PagingModel request,
    BuildContext context,
  ) async {
    List<PackageEntities> packages = [];

    state = const AsyncLoading();
    final packageTypeReponsitory = ref.read(packageTypeRepositoryProvider);
    final authRepository = ref.read(authRepositoryProvider);
    final user = await SharedPreferencesUtils.getInstance('user_token');

    state = await AsyncValue.guard(() async {
      final response = await packageTypeReponsitory.getPackages(
        accessToken: APIConstants.prefixToken + user!.tokens.accessToken,
        request: request,
      );
      packages = response.data;
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

          await getPackages(request, context);
        },
      );
    }



    return packages;
  }
}

