import 'package:base/features/package/data/model/response/packages_response.dart';
import 'package:base/features/package/data/remote/package_source.dart';
import 'package:base/features/package/data/repositories/package_type_repository_impl.dart';

import 'package:base/models/request/paging_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/widgets.dart';

part 'package_type_reponsitory.g.dart';

abstract class PackageTypeReponsitory {
  Future<PackageResponse> getPackages({
    required String accessToken,
    required PagingModel request,
  });
}

@Riverpod(keepAlive: true)
PackageTypeReponsitory packageTypeRepository(PackageTypeRepositoryRef ref) {
  final packageTypeSource = ref.read(packageSourceProvider);
  return PackageTypeRepositoryImpl(packageTypeSource);
}
