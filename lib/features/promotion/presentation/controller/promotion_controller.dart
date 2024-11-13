import 'package:base/features/auth/presentation/screens/sign_in/sign_in_controller.dart';
import 'package:base/features/promotion/domain/entities/promotion_entities.dart';
import 'package:base/features/promotion/domain/repositories/promotion_reponsitory.dart';
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

part 'promotion_controller.g.dart';

@riverpod
class PromotionController extends _$PromotionController {
  @override
  FutureOr<void> build() {}

  Future<List<PromotionEntities>> getPromotions(
    PagingModel request,
    BuildContext context,
  ) async {
    List<PromotionEntities> promotions = [];

    state = const AsyncLoading();
    final promotionReponsitory = ref.read(promotionRepositoryProvider);
    final authRepository = ref.read(authRepositoryProvider);
    final user = await SharedPreferencesUtils.getInstance('user_token');

    state = await AsyncValue.guard(() async {
      final response = await promotionReponsitory.getPromotions(
        accessToken: APIConstants.prefixToken + user!.tokens.accessToken,
        request: request,
      );
      promotions = response.data;
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

          await getPromotions(request, context);
        },
      );
    }



    return promotions;
  }
}

