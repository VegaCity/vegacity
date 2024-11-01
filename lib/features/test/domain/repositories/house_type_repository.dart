import 'package:base/features/test/data/models/response/house_response.dart';
import 'package:base/models/request/paging_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:base/features/test/data/remote/house_source.dart';
import 'package:base/features/test/data/repositories/house_type_repository_impl.dart';

part 'house_type_repository.g.dart';

abstract class HouseTypeRepository {
  Future<HouseResponse> getHouseTypeData(
    {
    required String accessToken,
    required PagingModel request,
  }
  );
}

@Riverpod(keepAlive: true)
HouseTypeRepository houseTypeRepository(HouseTypeRepositoryRef ref) {
  final houseTypeSource = ref.read(houseSourceProvider);
  return HouseTypeRepositoryImpl(houseTypeSource);
}
