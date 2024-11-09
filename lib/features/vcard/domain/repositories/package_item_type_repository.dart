import 'package:base/features/vcard/data/model/response/packageItem_response.dart';
import 'package:base/features/vcard/data/model/response/vcard_response.dart';
import 'package:base/features/vcard/data/model/response/vcard_response_v2.dart';
import 'package:base/features/vcard/data/remote/package_item_source.dart';
import 'package:base/features/vcard/data/repositories/package_item_type_repository_impl.dart';

import 'package:base/models/request/paging_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'package_item_type_repository.g.dart';

abstract class PackageItemTypeRepository {
  Future<PackageitemResponse> getCard({
    required String accessToken,
    required PagingModel request,
  });
  Future<VcardResponse> getEtagCard({
    required String accessToken,
    required String id,
  });

  Future<VcardResponseV2> getEtagCardV2({
    required String accessToken,
    required String id,
  });
}

@Riverpod(keepAlive: true)
PackageItemTypeRepository packageItemTypeRepository(
    PackageItemTypeRepositoryRef ref) {
  final packageItemSource = ref.read(packageItemSourceProvider);
  return PackageItemTypeRepositoryImpl(packageItemSource);
}
