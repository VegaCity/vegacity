import 'package:base/features/auth/data/models/request/change_password_request.dart';
import 'package:base/utils/constants/asset_constant.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';

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

part 'change_password_controller.g.dart';

@riverpod
class ChangePasswordController extends _$ChangePasswordController {
  @override
  FutureOr<void> build() {}

  Future<void> changePassword({
    required String email,
    required String oldPassword,
    required String newPassword,
    required BuildContext context,
  }) async {
    state = const AsyncLoading();
    final authRepository = ref.read(authRepositoryProvider);

    // Tạo request
    final request = ChangePasswordRequest(
      email: email,
      oldPassword: oldPassword,
      newPassword: newPassword,
    );

    print("go here ${request.toString()}");
    state = await AsyncValue.guard(
      () async {
        await authRepository.changePassword(request: request);

        print("Change IN OKE ");

        showSnackBar(
          context: context,
          content: "Thay đổi mật khẩu thành công",
          icon: AssetsConstants.iconSuccess,
          backgroundColor: Colors.green,
          textColor: AssetsConstants.whiteColor,
        );
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
}
