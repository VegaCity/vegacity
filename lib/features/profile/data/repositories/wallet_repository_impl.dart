// import local

import 'package:base/features/history/data/remote/history_source.dart';
import 'package:base/features/history/domain/repositories/history_repository.dart';
import 'package:base/features/profile/data/models/request/wallet_request.dart';
import 'package:base/features/profile/data/models/response/wallet_response.dart';
import 'package:base/features/profile/data/remote/wallet_source.dart';
import 'package:base/features/profile/domain/repositories/wallet_repository.dart';
import 'package:base/models/request/paging_model.dart';

// utils
import 'package:base/utils/constants/api_constant.dart';
import 'package:base/utils/resources/remote_base_repository.dart';

class WalletRepositoryImpl extends RemoteBaseRepository
    implements WalletRepository {
  final bool addDelay;
  final WalletSource _walletSource;

  WalletRepositoryImpl(this._walletSource, {this.addDelay = true});

  @override
  Future<WalletResponse> getWallet({
    required String accessToken,
    required PagingModel request,
  }) async {
    // mới
    final walletRequest = WalletRequest(
      size: request.pageSize,
      page: request.pageNumber,
    );

    print('log filter ở đây ${walletRequest.toString()}');
    print('log filter ở đây $accessToken');
    return getDataOf(
      request: () => _walletSource.getWallet(
        APIConstants.contentType,
        accessToken,
        walletRequest,
      ),
    );
  }
}