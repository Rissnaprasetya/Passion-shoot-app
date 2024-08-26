class PaymentData {
  String cid;
  String cmethod;

  PaymentData({
    required this.cid,
    required this.cmethod,
  });

  factory PaymentData.fromJson(Map<String, dynamic> json) {
    return PaymentData(
      cid: json['id'].toString(),
      cmethod: json['method'],
    );
  }

  static List<PaymentData> parseDataListacc(dynamic json) {
    if (json['success'] == true &&
        json['data'] != null &&
        json['data']['data'] is List) {
      var list = json['data']['data'] as List;
      List<PaymentData> dataList =
          list.map((data) => PaymentData.fromJson(data)).toList();
      return dataList;
    } else {
      throw Exception('Invalid JSON structure');
    }
  }
}
