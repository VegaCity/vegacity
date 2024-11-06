import 'package:base/features/vcard/data/model/response/packageItem_response.dart';
import 'package:base/features/vcard/data/model/response/etag_response.dart';
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
  Future<EtagResponse> getEtagCard({
    required String accessToken,
    required String etagCode,
  });
}

@Riverpod(keepAlive: true)
PackageItemTypeRepository packageItemTypeRepository(PackageItemTypeRepositoryRef ref) {
  final PackageItemSource = ref.read(packageItemSourceProvider);
  return PackageItemTypeRepositoryImpl(PackageItemSource);
}
