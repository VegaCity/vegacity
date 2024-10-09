import 'dart:convert';

class HouseRequest {
  // final String? systemStatus;
  // final String? partnerOrderStatus;
  // final String? searchDateFrom;
  // final String? searchDateTo;
  // final String? search;
  final int page;
  final int size;

  HouseRequest({
    // this.systemStatus,
    // this.partnerOrderStatus,
    // this.searchDateFrom,
    // this.searchDateTo,
    // this.search,
    required this.page,
    this.size = 10,
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

  factory HouseRequest.fromMap(Map<String, dynamic> map) {
    return HouseRequest(
      // systemStatus: map['systemStatus'],
      // partnerOrderStatus: map['partnerOrderStatus'],
      // searchDateFrom: map['searchDateFrom'],
      // searchDateTo: map['searchDateTo'],
      // search: map['Search'],
      page: map['page']?.toInt() ?? 1,
      size: map['size']?.toInt() ?? 10,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'SignUpRequest( page: $page, size: $size)';
  }

  factory HouseRequest.fromJson(String source) =>
      HouseRequest.fromMap(json.decode(source));
}
