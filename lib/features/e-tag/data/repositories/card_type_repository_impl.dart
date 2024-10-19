// import local
import 'package:base/features/e-tag/data/model/request/card_request.dart';
import 'package:base/features/e-tag/data/model/response/card_response.dart';
import 'package:base/features/e-tag/data/remote/card_source.dart';
import 'package:base/features/e-tag/domain/repositories/card_type_repository.dart';



import 'package:base/models/request/paging_model.dart';

// utils
import 'package:base/utils/constants/api_constant.dart';
import 'package:base/utils/resources/remote_base_repository.dart';
import 'package:retrofit/dio.dart';

class CardTypeRepositoryImpl extends RemoteBaseRepository
    implements CardTypeRepository {
  final bool addDelay;
  final CardSource _cardSource;

  CardTypeRepositoryImpl(this._cardSource, {this.addDelay = true});

  @override
  Future<CardResponse> getCard(
    {
    required String accessToken,
    required PagingModel request,
  }
  ) async {
    // mới
    final cardRequest = CardRequest(
      page: request.pageNumber,
      size: request.pageSize,
    );

    print('log filter ở đây ${cardRequest.toString()}');
    print('log filter ở đây ${accessToken}');
    return getDataOf(
      request: () => _cardSource.getCard(
        APIConstants.contentType,
        accessToken,
        cardRequest,
      ),
    );
  }
}
