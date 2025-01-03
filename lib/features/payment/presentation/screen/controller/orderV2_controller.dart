import 'package:base/features/payment/data/models/response/payment_response.dart';
import 'package:base/features/payment/data/models/resquest/orderV2_request.dart';
import 'package:base/features/payment/data/models/resquest/payment_request.dart';
import 'package:base/features/payment/domain/repositories/order_repository.dart';
import 'package:base/utils/constants/api_constant.dart';
import 'package:base/utils/constants/asset_constant.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';

import 'package:base/utils/commons/functions/api_utils.dart';
import 'package:base/utils/commons/widgets/widgets_common_export.dart';
import 'package:base/utils/extensions/extensions_export.dart';
import 'package:base/utils/commons/functions/shared_preference_utils.dart';
import 'package:url_launcher/url_launcher.dart';

part 'orderV2_controller.g.dart';

@riverpod
class Orderv2Controller extends _$Orderv2Controller {
  @override
  FutureOr<void> build() {}

  Future<void> orderv2({
    required String packageOrderId,
    required int chargeAmount,
    required String cccdPassport,
    required String paymentType,
    required BuildContext context,
  }) async {
    state = const AsyncLoading();
    print("log tes 0");
    final orderRepository = ref.read(orderRepositoryProvider);
    final user = await SharedPreferencesUtils.getInstance('user_token');
    // final token = "${APIConstants.prefixToken} ${user!.tokens.accessToken}";
    // print("Final Token: $token");

    // print("User token: ${user?.tokens.accessToken}");

    final request = OrderV2Request(
      packageOrderId: packageOrderId,
      chargeAmount: chargeAmount,
      cccdPassport: cccdPassport,
      paymentType: paymentType,
    );

    print("Request: ${request.toJson()}"); // Debugging
    print('Test 1 : ${APIConstants.prefixToken + user!.tokens.accessToken}');
    state = await AsyncValue.guard(
      () async {
        final orderResponse = await orderRepository.orderv2(
            request: request,
            accessToken: APIConstants.prefixToken +
                user.tokens.accessToken); // Kiểm tra prefix

        print("ORDER IN OK");

        print(orderResponse.data.toJson()); // Debugging

        showSnackBar(
          context: context,
          content: "Tạo đơn hàng thành công",
          icon: AssetsConstants.iconSuccess,
          backgroundColor: Colors.green,
          textColor: AssetsConstants.whiteColor,
        );

        //payment request here
        final paymentRequest = PaymentRequest(
          invoiceId: orderResponse.data.invoiceId,
          packageItemId: orderResponse.data.packageItemId,
          packageOrderId: orderResponse.data.packageOrderId,
          transactionChargeId: orderResponse.data.transactionChargeId,
          key: orderResponse.data.key,
          urlDirect: orderResponse.data.urlDirect,
          urlIpn: orderResponse.data.urlIpn,
        );

        print("vinh log 1 ${paymentRequest.toJson()}");
        PaymentResponse? paymentResponse;
        switch (request.paymentType.toLowerCase()) {
          case "cash":
            print("thanh toán cash ");
            paymentResponse = await orderRepository.paymentCash(
              accessToken: APIConstants.prefixToken + user.tokens.accessToken,
              request: paymentRequest,
            );
            print("thanh toán cash thành công");
            break;

          default:
            // Tất cả các phương thức thanh toán online khác
            paymentResponse = await orderRepository.paymentMomo(
              accessToken: APIConstants.prefixToken + user.tokens.accessToken,
              request: paymentRequest,
            );

            await launchUrl(
                Uri.parse(paymentResponse.data.payUrl ??
                    paymentResponse.data.vnPayResponse ??
                    paymentResponse.data.checkoutUrl ??
                    paymentResponse.data.order_url!),
                mode: LaunchMode.externalApplication);
            break;
        }

        print("paymentResponse IN OK");
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
          content: "nhập không đúng hoặc thiếu thông tin",
          icon: AssetsConstants.iconError,
          backgroundColor: Colors.red,
          textColor: AssetsConstants.whiteColor,
        );
      }
    }
  }
}

// scan -> package -> check wallet => confirm
