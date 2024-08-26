class DataTransaksi {
  final List<Transaksi> data;
  DataTransaksi({required this.data});
  factory DataTransaksi.fromJson(Map<String, dynamic> json) => DataTransaksi(
      data: List.from(
          json['data'].map((transaksi) => Transaksi.fromModel(transaksi))));

  toJson() {}
}

class Transaksi {
  final int id;
  final int typeid;
  final int paymentid;
  final double amount;
  final String date;
  final String title;
  final String description;

  Transaksi({
    required this.date,
    required this.id,
    required this.typeid,
    required this.paymentid,
    required this.amount,
    required this.title,
    required this.description,
  });

  factory Transaksi.fromModel(Map<String, dynamic> json) => Transaksi(
      date: json['date'],
      id: json['id'],
      typeid: json['typeid'],
      paymentid: json['paymentid'],
      amount:
          (json['amount'] as num).toDouble(), // Konversi nilai amount ke double
      title: json['title'],
      description: json['description']);
}
