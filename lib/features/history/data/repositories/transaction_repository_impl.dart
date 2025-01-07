// import local
import 'package:base/features/history/data/model/request/transaction_request.dart';
import 'package:base/features/history/data/model/response/transaction_response.dart';
import 'package:base/features/history/data/remote/transaction_source.dart';

import 'package:base/features/history/domain/repositories/transaction_repository.dart';
import 'package:base/models/request/paging_model.dart';

// utils
import 'package:base/utils/constants/api_constant.dart';
import 'package:base/utils/resources/remote_base_repository.dart';

class TransactionRepositoryImpl extends RemoteBaseRepository
    implements TransactionRepository {
  final bool addDelay;
  final TransactionSource _transactionSource;

  TransactionRepositoryImpl(this._transactionSource, {this.addDelay = true});

  @override
  Future<TransactionResponse> getTransaction({
    required String accessToken,
    required PagingModel request,
  }) async {
    // mới
    final transactionRequest = TransactionRequest(
      size: request.pageSize,
      page: request.pageNumber,
      status: request.status,
    );

    print('log filter ở đây ${transactionRequest.toString()}');
    print('log filter ở đây $accessToken');
    return getDataOf(
      request: () => _transactionSource.getTransaction(
        APIConstants.contentType,
        accessToken,
        transactionRequest,
      ),
    );
  }
}
