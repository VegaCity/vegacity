// data - domain impl

import 'package:base/features/auth/domain/repositories/auth_repository.dart';
import 'package:base/features/auth/presentation/screens/sign_in/sign_in_controller.dart';

import 'package:base/features/profile/domain/entities/wallet_entity.dart';
import 'package:base/features/profile/domain/repositories/wallet_repository.dart';
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

part 'wallet_controller.g.dart';

@riverpod
class WalletController extends _$WalletController {
  @override
  FutureOr<void> build() {}

  Future<WalletEntity?> getWallet(
    BuildContext context,
  ) async {
    WalletEntity? wallet;

    state = const AsyncLoading();
    final walletRepository = ref.read(walletRepositoryProvider);
    final authRepository = ref.read(authRepositoryProvider);
    final user = await SharedPreferencesUtils.getInstance('user_token');

    state = await AsyncValue.guard(() async {
      final response = await walletRepository.getWallet(
        accessToken: APIConstants.prefixToken + user!.tokens.accessToken,
      );
      
      wallet = response.data;

    });
    print('wallet1: $wallet');

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

          await getWallet(context);
        },
      );
    }

    return wallet;
  }
}
