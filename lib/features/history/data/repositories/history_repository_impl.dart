// import local

import 'package:base/features/history/data/model/request/history_request.dart';
import 'package:base/features/history/data/model/response/history_response.dart';
import 'package:base/features/history/data/remote/history_source.dart';
import 'package:base/features/history/domain/repositories/history_repository.dart';
import 'package:base/models/request/paging_model.dart';

// utils
import 'package:base/utils/constants/api_constant.dart';
import 'package:base/utils/resources/remote_base_repository.dart';
import 'package:retrofit/dio.dart';

class HistoryRepositoryImpl extends RemoteBaseRepository
    implements HistoryRepository {
  final bool addDelay;
  final HistorySource _historySource;

  HistoryRepositoryImpl(this._historySource, {this.addDelay = true});

  @override
  Future<HistoryResponse> getHistory({
    required String accessToken,
    required PagingModel request,
  }) async {
    // mới
    final historyRequest = HistoryRequest(
      size: request.pageSize,
      page: request.pageNumber,
    );

    print('log filter ở đây ${historyRequest.toString()}');
    print('log filter ở đây $accessToken');
    return getDataOf(
      request: () => _historySource.getHistory(
        APIConstants.contentType,
        accessToken,
        historyRequest,
      ),
    );
  }
}
