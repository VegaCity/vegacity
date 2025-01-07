import 'dart:convert';

class WalletRequest {
  // final String? systemStatus;
  // final String? partnerOrderStatus;
  // final String? searchDateFrom;
  // final String? searchDateTo;
  // final String? search;
  final int size;
  final int page;

  WalletRequest({
    // this.systemStatus,
    // this.partnerOrderStatus,
    // this.searchDateFrom,
    // this.searchDateTo,
    // this.search,
    this.size = 10,
    required this.page,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    // if (search != null) {
    //   result.addAll({'Search': search});
    // }
    result.addAll({'page': page});
    result.addAll({'size': size});

    return result;
  }

  factory WalletRequest.fromMap(Map<String, dynamic> map) {
    return WalletRequest(
      // systemStatus: map['systemStatus'],
      // partnerOrderStatus: map['partnerOrderStatus'],
      // searchDateFrom: map['searchDateFrom'],
      // searchDateTo: map['searchDateTo'],
      // search: map['Search'],
      size: map['size']?.toInt() ?? 10,
      page: map['page']?.toInt() ?? 1,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'SignUpRequest( page: $page, size: $size)';
  }

  factory WalletRequest.fromJson(String source) =>
      WalletRequest.fromMap(json.decode(source));
}
