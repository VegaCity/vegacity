import 'package:base/features/auth/data/models/request/order_request.dart';
import 'package:base/features/auth/data/models/response/order_response.dart';
import 'package:base/features/payment/data/models/response/payment_response.dart';
import 'package:base/features/payment/data/models/resquest/payment_request.dart';
import 'package:base/features/payment/data/remote/order_source.dart';
import 'package:base/features/payment/data/repositories/order_repositories_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// data impl

// model system

part 'order_repository.g.dart';

abstract class OrderRepository {
  Future<OrderResponse> order(
      {required OrderRequest request, required String accessToken});
  Future<PaymentResponse> paymentMomo(
      {required String accessToken, required PaymentRequest request});
  Future<PaymentResponse> paymentCash(
      {required String accessToken, required PaymentRequest request});
}

@Riverpod(keepAlive: false)
OrderRepository orderRepository(OrderRepositoryRef ref) {
  final orderSource = ref.read(orderSourceProvider);
  return OrderRepositoriesImpl(orderSource);
}
