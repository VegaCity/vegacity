import 'package:base/features/auth/presentation/screens/sign_in/sign_in_controller.dart';
import 'package:base/features/e-tag/domain/entities/card_entities.dart';
import 'package:base/features/e-tag/domain/repositories/card_type_repository.dart';

import 'package:base/utils/enums/enums_export.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:base/models/request/paging_model.dart';
import 'package:base/utils/commons/functions/shared_preference_utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';

import 'package:base/configs/routes/app_router.dart';

import 'package:base/features/auth/data/models/request/sign_up_request.dart';
import 'package:base/features/auth/domain/repositories/auth_repository.dart';



import 'package:base/utils/constants/asset_constant.dart';
import 'package:base/utils/commons/functions/api_utils.dart';
import 'package:base/utils/commons/widgets/widgets_common_export.dart';
import 'package:base/utils/extensions/extensions_export.dart';
import 'package:base/utils/constants/api_constant.dart';

part 'card_controller.g.dart';

@riverpod
class CardController extends _$CardController {
  @override
  FutureOr<void> build() {}

  Future<List<CardEntities>> getCard(
    PagingModel request,
    BuildContext context,
  ) async {
    List<CardEntities> cards = [];

    state = const AsyncLoading();
    final cardTypeReponsitory = ref.read(cardTypeRepositoryProvider);
    final authRepository = ref.read(authRepositoryProvider);
    final user = await SharedPreferencesUtils.getInstance('user_token');

    state = await AsyncValue.guard(() async {
      final response = await cardTypeReponsitory.getCard(
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

