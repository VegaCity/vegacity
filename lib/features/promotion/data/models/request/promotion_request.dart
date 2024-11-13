import 'dart:convert';

class PromotionRequest {
  // final String? systemStatus;
  // final String? partnerOrderStatus;
  // final String? searchDateFrom;
  // final String? searchDateTo;
  // final String? search;
  final int page;
  final int size;
  

  PromotionRequest({
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

  factory PromotionRequest.fromMap(Map<String, dynamic> map) {
    return PromotionRequest(
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

  factory PromotionRequest.fromJson(String source) =>
      PromotionRequest.fromMap(json.decode(source));
}
