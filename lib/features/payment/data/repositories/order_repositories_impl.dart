// import local

import 'package:base/features/auth/data/models/request/change_password_request.dart';
import 'package:base/features/auth/data/models/request/order_request.dart';
import 'package:base/features/auth/data/models/response/account_response.dart';
import 'package:base/features/auth/data/models/request/sign_in_request.dart';
import 'package:base/features/auth/data/models/response/order_response.dart';
import 'package:base/features/payment/data/models/response/payment_response.dart';
import 'package:base/features/payment/data/models/resquest/payment_request.dart';
import 'package:base/features/payment/data/remote/order_source.dart';
import 'package:base/features/payment/domain/repositories/order_repository.dart';
import 'package:base/utils/commons/functions/functions_common_export.dart';

import 'package:base/features/auth/data/models/request/otp_verify_request.dart';

// models system
import 'package:base/models/response/success_model.dart';
import 'package:base/models/token_model.dart';

// utils
import 'package:base/utils/constants/api_constant.dart';
import 'package:base/utils/resources/remote_base_repository.dart';

class OrderRepositoriesImpl extends RemoteBaseRepository
    implements OrderRepository {
  final bool addDelay;
  final OrderSource _orderSource;

  OrderRepositoriesImpl(this._orderSource, {this.addDelay = true});

  @override
  Future<OrderResponse> order({
    required String accessToken,
    required OrderRequest request,
  }) async {
    return getDataOf(
      request: () =>
          _orderSource.order(accessToken, APIConstants.contentType, request),
    );
  }

  @override
  Future<PaymentResponse> paymentMomo({
    required String accessToken,
    required PaymentRequest request,
  }) async {
    print('here test ${request.toJson()}  ');

    // exp key : "Momo_2024101914405513"
    final key = request.key;

    final formatPaymentType = key.split('_')[0].toLowerCase();
    print(formatPaymentType);
    return await getDataOf(
      request: () => _orderSource.paymentMomo(
        accessToken,
        APIConstants.contentType,
        request,
        formatPaymentType,
      ),
    );
  }
}
