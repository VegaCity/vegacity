import 'package:base/features/auth/data/models/request/order_request.dart';
import 'package:base/features/auth/data/models/response/order_response.dart';
import 'package:base/features/payment/data/models/response/payment_response.dart';
import 'package:base/features/payment/data/models/resquest/payment_request.dart';
import 'package:base/features/payment/data/remote/order_source.dart';
import 'package:base/features/payment/data/repositories/order_repositories_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// data impl
import 'package:base/features/auth/data/remote/auth_source.dart';
import 'package:base/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:base/features/auth/data/models/response/account_response.dart';
import 'package:base/features/auth/data/models/request/sign_in_request.dart';
import 'package:base/features/auth/data/models/request/sign_up_request.dart';
import 'package:base/features/auth/data/models/request/otp_verify_request.dart';
import 'package:base/features/auth/data/models/request/change_password_request.dart';

// model system
import 'package:base/models/response/success_model.dart';
import 'package:base/models/token_model.dart';

part 'order_repository.g.dart';


abstract class OrderRepository {
  Future<OrderResponse> order({required OrderRequest request, required String accessToken});
  Future<PaymentResponse> paymentMomo({ required String accessToken, required PaymentRequest request});

}

@Riverpod(keepAlive: false)
OrderRepository orderRepository(OrderRepositoryRef ref) {
  final orderSource = ref.read(orderSourceProvider);
  return OrderRepositoriesImpl(orderSource);
}