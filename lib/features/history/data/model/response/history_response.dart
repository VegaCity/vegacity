import 'dart:convert';

import 'package:base/features/history/domain/entities/history_entity.dart';

class HistoryResponse {
  final List<HistoryEntity> data;

  HistoryResponse({
    required this.data,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({'data': data.map((x) => x.toMap()).toList()});
    return result;
  }

  factory HistoryResponse.fromMap(Map<String, dynamic> map) {
    return HistoryResponse(
      data: List<HistoryEntity>.from(
          map['data']?.map((x) => HistoryEntity.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory HistoryResponse.fromJson(String source) =>
      HistoryResponse.fromMap(json.decode(source));
}
