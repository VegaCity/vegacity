// import local

import 'package:base/features/profile/data/models/response/wallet_response.dart';
import 'package:base/features/profile/data/remote/wallet_source.dart';
import 'package:base/features/profile/domain/repositories/wallet_repository.dart';


// utils
import 'package:base/utils/constants/api_constant.dart';
import 'package:base/utils/resources/remote_base_repository.dart';

class WalletRepositoryImpl extends RemoteBaseRepository
    implements WalletRepository {
  final bool addDelay;
  final WalletSource _walletSource;

  WalletRepositoryImpl(this._walletSource, {this.addDelay = true});

  // @override
  // Future<ProfileResponse> getProfile({
  //   required String accessToken,
  // }) async {
  //   // mới
  //   final user = await SharedPreferencesUtils.getInstance('user_token');
  //   final userId = user?.id;

  //   return getDataOf(
  //     request: () => _profileSource.getProfile(
  //       APIConstants.contentType,
  //       accessToken,
  //       userId ?? '',
  //     ),
  //   );
  // }

  @override
  Future<WalletResponse> getWallet({
    required String accessToken,
  }) async {
    print('test"');
    return getDataOf(
      request: () =>
          _walletSource.getWallet(APIConstants.contentType, accessToken),
    );
  }
}
