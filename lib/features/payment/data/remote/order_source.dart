import 'package:base/features/payment/data/models/response/payment_response.dart';
import 'package:base/features/payment/data/models/resquest/payment_request.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// model system

// data impl
import 'package:base/features/auth/data/models/request/order_request.dart';
import 'package:base/features/auth/data/models/response/order_response.dart';
// utils
import 'package:base/utils/constants/api_constant.dart';
import 'package:base/utils/providers/common_provider.dart';

part 'order_source.g.dart';

@RestApi(baseUrl: APIConstants.baseUrl, parser: Parser.MapSerializable)
abstract class OrderSource {
  factory OrderSource(Dio dio, {String baseUrl}) = _OrderSource;

  @POST(APIConstants.order)
  Future<HttpResponse<OrderResponse>> order(
    @Header(APIConstants.authHeader) String acesstoken,
    @Header(APIConstants.contentHeader) String contentType,
    @Body() OrderRequest request,
  );

  @POST(APIConstants.cash)
  Future<HttpResponse<PaymentResponse>> paymentCash(
    @Header(APIConstants.authHeader) String acesstoken,
    @Header(APIConstants.contentHeader) String contentType,
    @Body() PaymentRequest request,
  );

  @POST('${APIConstants.payment}/{formatPaymentType}')
  Future<HttpResponse<PaymentResponse>> paymentMomo(
    @Header(APIConstants.authHeader) String acesstoken,
    @Header(APIConstants.contentHeader) String contentType,
    @Body() PaymentRequest request,
    @Path('formatPaymentType') String formatPaymentType,
  );
}

@riverpod
OrderSource orderSource(OrderSourceRef ref) {
  final dio = ref.read(dioProvider);
  return OrderSource(dio);
}
