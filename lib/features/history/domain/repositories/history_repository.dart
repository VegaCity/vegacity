import 'package:base/features/history/data/model/response/history_response.dart';
import 'package:base/features/history/data/remote/history_source.dart';
import 'package:base/features/history/data/repositories/history_repository_impl.dart';

import 'package:base/models/request/paging_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'history_repository.g.dart';

abstract class HistoryRepository {
  Future<HistoryResponse> getHistory({
    required String accessToken,
    required PagingModel request,
  });
}

@Riverpod(keepAlive: true)
HistoryRepository historyRepository(HistoryRepositoryRef ref) {
  final historySource = ref.read(historySourceProvider);
  return HistoryRepositoryImpl(historySource);
}
