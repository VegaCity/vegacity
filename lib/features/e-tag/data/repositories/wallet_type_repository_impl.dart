// // import local

// import 'package:base/features/e-tag/data/model/response/wallet_card_response.dart';
// import 'package:base/features/e-tag/data/remote/wallet_card_source.dart';
// import 'package:base/features/e-tag/domain/repositories/wallet_card_repository.dart';
// import 'package:base/features/profile/data/models/response/profile_response.dart';

// import 'package:base/features/profile/data/remote/profile_source.dart';
// import 'package:base/features/profile/domain/entities/wallet_entity.dart';
// import 'package:base/features/profile/domain/repositories/profile_repository.dart';

// import 'package:base/models/request/paging_model.dart';

// // utils
// import 'package:base/utils/constants/api_constant.dart';
// import 'package:base/utils/resources/remote_base_repository.dart';
// import 'package:base/utils/commons/functions/functions_common_export.dart';
// import 'package:retrofit/dio.dart';


// class WallletCardRepositoryImpl extends RemoteBaseRepository
//     implements WalletCardRepository {
//   final bool addDelay;
//   final WalletCardSource _walletCardSource;

//   WallletCardRepositoryImpl(this._walletCardSource, {this.addDelay = true});

//   @override
//   Future<WalletCardResponse> getEtag({
//     required String accessToken,
//   }) async {
//     // mới
    

//     return getDataOf(
//       request: () => _walletCardSource.getWalletEtag(
//         APIConstants.contentType,
//         accessToken,
//         // id,
//         // etagCode,
//       ),
//     );
//   }

    

// }
