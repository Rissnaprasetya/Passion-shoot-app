class PostPaymentMethod{
  final String method;

  PostPaymentMethod({required this.method});

  Map<String, dynamic> toJson() {
    return {
      'method': method,
    };
  }
}
