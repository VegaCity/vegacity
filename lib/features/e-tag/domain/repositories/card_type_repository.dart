import 'package:base/features/e-tag/data/model/response/card_response.dart';
import 'package:base/features/e-tag/data/remote/card_source.dart';
import 'package:base/features/e-tag/data/repositories/card_type_repository_impl.dart';

import 'package:base/features/package/data/remote/package_source.dart';

import 'package:base/models/request/paging_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/widgets.dart';

part 'card_type_repository.g.dart';

abstract class CardTypeRepository {
  Future<CardResponse> getCard({
    required String accessToken,
    required PagingModel request,
  });
}

@Riverpod(keepAlive: true)
CardTypeRepository cardTypeRepository(CardTypeRepositoryRef ref) {
  final CardSource = ref.read(cardSourceProvider);
  return CardTypeRepositoryImpl(CardSource);
}
