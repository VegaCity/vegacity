import 'package:base/features/auth/presentation/screens/sign_in/sign_in_controller.dart';
import 'package:base/features/vcard/domain/entities/packageItems_entity.dart';
import 'package:base/features/vcard/domain/repositories/package_item_type_repository.dart';

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

part 'package_item_controller.g.dart';

@riverpod
class PackageItemController extends _$PackageItemController {
  @override
  FutureOr<void> build() {}

  Future<List<PackageItemEntities>> getCard(
    PagingModel request,
    BuildContext context,
  ) async {
    List<PackageItemEntities> cards = [];

    state = const AsyncLoading();
    final packageItemTypeReponsitory = ref.read(packageItemTypeRepositoryProvider);
    final authRepository = ref.read(authRepositoryProvider);
    final user = await SharedPreferencesUtils.getInstance('user_token');

    state = await AsyncValue.guard(() async {
      final response = await packageItemTypeReponsitory.getCard(
        accessToken: APIConstants.prefixToken + user!.tokens.accessToken,
        request: request,
      );
      cards = response.data;
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

          await getCard(request, context);
        },
      );
    }



    return cards;
  }
}

