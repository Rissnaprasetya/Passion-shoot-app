class postTransaksi {
  final int? status;
  final String massage;

  postTransaksi({this.status, required this.massage});

  factory postTransaksi.fromJson(Map<String, dynamic> json) => postTransaksi(
        massage: json['massage'],
        status: json['status'],
      );
}
