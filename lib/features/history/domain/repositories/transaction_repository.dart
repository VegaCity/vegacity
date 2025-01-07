import 'package:base/features/history/data/model/response/transaction_response.dart';
import 'package:base/features/history/data/remote/transaction_source.dart';
import 'package:base/features/history/data/repositories/transaction_repository_impl.dart';

import 'package:base/models/request/paging_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transaction_repository.g.dart';

abstract class TransactionRepository {
  Future<TransactionResponse> getTransaction({
    required String accessToken,
    required PagingModel request,
  });
}

@Riverpod(keepAlive: true)
TransactionRepository transactionRepository(TransactionRepositoryRef ref) {
  final transactionSource = ref.read(transactionSourceProvider);
  return TransactionRepositoryImpl(transactionSource);
}
