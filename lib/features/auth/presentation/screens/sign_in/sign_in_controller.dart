import 'package:base/utils/constants/asset_constant.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';
import 'package:auto_route/auto_route.dart';

import 'package:base/configs/routes/app_router.dart';
import 'package:base/models/user_model.dart';

import 'package:base/features/auth/domain/repositories/auth_repository.dart';
import 'package:base/features/auth/data/models/request/sign_in_request.dart';

import 'package:base/utils/enums/enums_export.dart';
import 'package:base/utils/commons/functions/api_utils.dart';
import 'package:base/utils/commons/widgets/widgets_common_export.dart';
import 'package:base/utils/extensions/extensions_export.dart';
import 'package:base/utils/commons/functions/shared_preference_utils.dart';
import 'package:base/utils/providers/common_provider.dart';

part 'sign_in_controller.g.dart';

@riverpod
class SignInController extends _$SignInController {
  @override
  FutureOr<void> build() {}

  Future<void> signIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = const AsyncLoading();
    final authRepository = ref.read(authRepositoryProvider);

    // Tạo request với email hoặc phone
    final request = SignInRequest(
      email: email,
      password: password,
    );

    print("go here ${request.toString()}");
    print("1");
    state = await AsyncValue.guard(
      () async {
        
        final user = await authRepository.signIn(request: request);
        print("user ${user}");
        final isNotPermission =
            user.data.roleName == 'Admin' || user.data.roleName == 'CashierWeb';
        print("2");
        if (isNotPermission) {
          print("SIGN IN FAIL ");
          throw Exception('ko có quyền truy cập');
        }

        print("SIGN IN OKE ");

        print("3");

        final userModel = UserModel(
          id: user.data.userId,
          email: user.data.email,
          tokens: user.data.tokens,
        );

        ref.read(authProvider.notifier).update(
              (state) => userModel,
            );
        await SharedPreferencesUtils.setInstance(
          userModel,
          'user_token',
        );
        context.router.replaceAll([const TabViewScreenRoute()]);
      },
    );

    if (state.hasError) {
      final error = state.error!;
      if (error is DioException) {
        final statusCode = error.response?.statusCode ?? error.onStatusDio();

        handleAPIError(
          statusCode: statusCode,
          stateError: state.error!,
          context: context,
        );
      } else {
        showSnackBar(
          context: context,
          content: error.toString(),
          icon: AssetsConstants.iconError,
          backgroundColor: Colors.red,
          textColor: AssetsConstants.whiteColor,
        );
      }
    }
  }

  Future<void> signOut(
    BuildContext context,
  ) async {
    state = const AsyncLoading();
    ref.read(modifyProfiver.notifier).update((state) => true);
    final authRepository = ref.read(authRepositoryProvider);
    final user = await SharedPreferencesUtils.getInstance('user_token');

    state = await AsyncValue.guard(
      () async {
        final userDevice = user!.userTokens!.firstWhere(
          (element) => element.fcmToken == user.fcmToken,
        );

        ref.read(authProvider.notifier).update((state) => null);
        await authRepository.signOut();
        // await authRepository.deleteToken(
        //   id: userDevice.userDeviceId!,
        // );

        ref.read(modifyProfiver.notifier).update((state) => false);
        context.router.replaceAll([SignInScreenRoute()]);
      },
    );

    // access expired || other error
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
            ref.read(modifyProfiver.notifier).update((state) => false);
            showExceptionAlertDialog(
              context: context,
              title: 'Thông báo',
              exception: 'Có lỗi rồi không thể đăng xuất.',
            );
            return;
          }

          if (statusCode != StatusCodeType.unauthentication.type) {
            return;
          }

          await signOut(context);
        },
      );
    }
  }
}
