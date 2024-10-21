// data - domain impl
import 'package:base/features/auth/domain/repositories/auth_repository.dart';
import 'package:base/features/auth/presentation/screens/sign_in/sign_in_controller.dart';
import 'package:base/features/e-tag/domain/entities/etag_entity.dart';
import 'package:base/features/e-tag/domain/repositories/card_type_repository.dart';

// system
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

// utils
import 'package:base/utils/constants/asset_constant.dart';
import 'package:base/utils/commons/functions/api_utils.dart';
import 'package:base/utils/commons/widgets/widgets_common_export.dart';
import 'package:base/utils/extensions/extensions_export.dart';
import 'package:base/utils/constants/api_constant.dart';
import 'package:base/utils/enums/enums_export.dart';
import 'package:base/utils/commons/functions/shared_preference_utils.dart';

part 'etag_scanner_controller.g.dart';

@riverpod
class EtagScannerController extends _$EtagScannerController {
  @override
  FutureOr<void> build() {}

  Future<EtagEntity?> getEtagCardData(
    BuildContext context,
    String qrcode,
  ) async {
    EtagEntity? etagCardData;

    state = const AsyncLoading();
    final cardRepository = ref.read(cardTypeRepositoryProvider);
    final authRepository = ref.read(authRepositoryProvider);
    final user = await SharedPreferencesUtils.getInstance('user_token');

    // example valid etag code to check date VGC2024101718260399
    // example unvalid etag code to check date VGC2024101900470937

    state = await AsyncValue.guard(() async {
      final response = await cardRepository.getEtagCard(
        accessToken: APIConstants.prefixToken + user!.tokens.accessToken,
        //etagCode: checkEtagCode(qrcode),
        etagCode: "VGC2024101718260399",
      );
      etagCardData = response.data.etag;

      //checkdate
      final now = DateTime.now();
      final isValid = now.isBefore(etagCardData?.endDate ?? DateTime.now());

      //final checkValidDate = deCodeQrCodeData(etagCardData?.qrcode ?? '');

      if (!isValid) {
        showSnackBar(
          context: context,
          content: "Mã Etag hết hạn vui lòng kiểm tra lại",
          icon: AssetsConstants.iconError,
          backgroundColor: Colors.red,
          textColor: AssetsConstants.whiteColor,
        );

        context.router.pop();
      } else {
        showSnackBar(
          context: context,
          content: "Thông tin Etag hợp lệ",
          icon: AssetsConstants.iconSuccess,
          backgroundColor: Colors.green,
          textColor: AssetsConstants.whiteColor,
        );
      }

      print("etagCardData: ${etagCardData?.etagCode}");
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

          await getEtagCardData(context, checkEtagCode(qrcode));
        },
      );
    }

    return etagCardData;
  }

  // check valid date of qr code
  bool deCodeQrCodeData(String qrcode) {
    List<int> bytes = base64Decode(qrcode);

    String decodedString = utf8.decode(bytes);

    decodedString = decodedString.split('_')[1];
    DateTime now = DateTime.now();
    DateTime decoddeDateTime =
        DateFormat('MM/dd/yyyy HH:mm:ss').parse(decodedString);

    final checkValidDate = now.isBefore(decoddeDateTime) ? true : false;

    return checkValidDate;
  }

  String checkEtagCode(String qrcode) {
    List<int> bytes = base64Decode(qrcode);
    String decodedString = utf8.decode(bytes);
    String etagCode =
        decodedString.split('_')[0]; // Extract etagCode before "_"

    // You can modify this to return a Boolean based on your requirements
    // If you just want to return the etagCode, do so here
    return etagCode; // Change this return value as needed
  }
}
