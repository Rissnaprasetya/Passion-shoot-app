class DataPaymentMethod {
  final List<PaymentMethod> data;

  DataPaymentMethod({required this.data});

  factory DataPaymentMethod.fromJson(Map<String, dynamic> json) =>
      DataPaymentMethod(
          data: List.from(json['data'].map(
        (paymentMethod) => PaymentMethod.fromJson(paymentMethod),
      )));
}

class PaymentMethod {
  final int id;
  final String method;

  PaymentMethod({
    required this.id,
    required this.method,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
        id: json['id'],
        method: json['method'],
      );
}
