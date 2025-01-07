import 'dart:convert';

class TransactionRequest {
  final int size;
  final int page;
  final String? status;

  TransactionRequest({
    this.size = 10,
    required this.page,
    this.status = 'ALL',
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({'page': page});
    result.addAll({'size': size});
    if (status != null) {
      result.addAll({'status': status});
    }
    return result;
  }

  factory TransactionRequest.fromMap(Map<String, dynamic> map) {
    return TransactionRequest(
      size: map['size']?.toInt() ?? 10,
      page: map['page']?.toInt() ?? 1,
      status: map['status'],
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'TransactionRequest(page: $page, size: $size, status: $status)';
  }

  factory TransactionRequest.fromJson(String source) =>
      TransactionRequest.fromMap(json.decode(source));
}
