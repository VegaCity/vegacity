// system
import 'package:base/features/auth/domain/repositories/auth_repository.dart';
import 'package:base/features/auth/presentation/screens/sign_in/sign_in_controller.dart';
import 'package:base/features/vcard/domain/entities/vcard_entity.dart';
import 'package:base/features/vcard/domain/repositories/package_item_type_repository.dart';
import 'package:base/utils/commons/widgets/snack_bar.dart';
import 'package:base/utils/constants/asset_constant.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';

// utils
import 'package:base/utils/commons/functions/api_utils.dart';
import 'package:base/utils/extensions/extensions_export.dart';
import 'package:base/utils/constants/api_constant.dart';
import 'package:base/utils/enums/enums_export.dart';
import 'package:base/utils/commons/functions/shared_preference_utils.dart';

part 'vcard_controller.g.dart';

@riverpod
class VcardController extends _$VcardController {
  @override
  FutureOr<void> build() {}
  final _cache = <String, VcardEntities>{};
  Future<VcardEntities?> getVCardData(
    BuildContext context,
    String id, {
    bool forceRefresh = false, // Thêm parameter để force refresh
  }) async {
    if (!forceRefresh && _cache.containsKey(id)) {
      return _cache[id];
    }
    VcardEntities? vcardCardData;
    state = const AsyncLoading();
    final packageItemTypeRepository =
        ref.read(packageItemTypeRepositoryProvider);
    final authRepository = ref.read(authRepositoryProvider);
    final user = await SharedPreferencesUtils.getInstance('user_token');
    // final validWalletTypes = ["StoreWallet", "UserWallet", "ServiceWallet"];

    // data test id: 989fe0c5-dab6-4473-ad70-f4259bdd8f13
    state = await AsyncValue.guard(() async {
      final response = await packageItemTypeRepository.getEtagCard(
        accessToken: APIConstants.prefixToken + user!.tokens.accessToken,
        id: id,
      );
      vcardCardData = response.data;
      if (vcardCardData != null) {
        _cache[id] = vcardCardData!;
      }
      final isValidPackageType =
          vcardCardData?.wallets[0].walletType.name == "SpecificWallet";

      if (isValidPackageType) {
        showSnackBar(
          context: context,
          content:
              "VCard is \"Specific\" and cannot be recharged or it has expired",
          icon: AssetsConstants.iconError,
          backgroundColor: Colors.red,
          textColor: AssetsConstants.whiteColor,
        );

        print("go here fail");
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
          if (statusCode == 404) {
            state = const AsyncData(null);
            return;
          }
          // if refresh token expired
          if (state.hasError) {
            await ref.read(signInControllerProvider.notifier).signOut(context);
            return;
          }

          if (statusCode != StatusCodeType.unauthentication.type) {
            return;
          }
        },
      );
    }
    return vcardCardData;
  }

  void clearCache() {
    _cache.clear();
  }

  // Thêm method để remove một item khỏi cache
  void removeFromCache(String id) {
    _cache.remove(id);
  }
}
