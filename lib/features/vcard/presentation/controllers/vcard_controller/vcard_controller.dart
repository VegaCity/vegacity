// system
import 'package:base/features/auth/domain/repositories/auth_repository.dart';
import 'package:base/features/auth/presentation/screens/sign_in/sign_in_controller.dart';
import 'package:base/features/vcard/domain/entities/vcard_entity.dart';
import 'package:base/features/vcard/domain/repositories/package_item_type_repository.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';

// utils
import 'package:base/utils/constants/asset_constant.dart';
import 'package:base/utils/commons/functions/api_utils.dart';
import 'package:base/utils/commons/widgets/widgets_common_export.dart';
import 'package:base/utils/extensions/extensions_export.dart';
import 'package:base/utils/constants/api_constant.dart';
import 'package:base/utils/enums/enums_export.dart';
import 'package:base/utils/commons/functions/shared_preference_utils.dart';

part 'vcard_controller.g.dart';

@riverpod
class VcardController extends _$VcardController {
  @override
  FutureOr<void> build() {}

  Future<VcardEntities?> getVCardData(
    BuildContext context,
    String id,
  ) async {
    VcardEntities? vcardCardData;
    state = const AsyncLoading();
    final PackageItemTypeRepository =
        ref.read(packageItemTypeRepositoryProvider);
    final authRepository = ref.read(authRepositoryProvider);
    final user = await SharedPreferencesUtils.getInstance('user_token');

    // data test id: 989fe0c5-dab6-4473-ad70-f4259bdd8f13
    state = await AsyncValue.guard(() async {
      final response = await PackageItemTypeRepository.getEtagCard(
        accessToken: APIConstants.prefixToken + user!.tokens.accessToken,
        id: id,
      );

      vcardCardData = response.data;
      print("vinh check data ${response.data.wallet.walletType.name}");

      final isValidWalletType =
          vcardCardData?.wallet.walletType.name == "ServiceWallet";

      if (!isValidWalletType) {
        showSnackBar(
          context: context,
          content:
              "This vCard is \"Specific\" and cannot be recharged or it has expired",
          icon: AssetsConstants.iconError,
          backgroundColor: Colors.red,
          textColor: AssetsConstants.whiteColor,
        );

        print("go here fail");
        context.router.pop();
      } else {
        showSnackBar(
          context: context,
          content: "valid vcard",
          icon: AssetsConstants.iconSuccess,
          backgroundColor: Colors.green,
          textColor: AssetsConstants.whiteColor,
        );

        print("go here oke");
      }
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

          await getVCardData(context, id);
        },
      );
    }
    return vcardCardData;
  }
}
