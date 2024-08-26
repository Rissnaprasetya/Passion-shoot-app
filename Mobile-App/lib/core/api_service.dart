import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:proj_passion_shoot/features/data/model/event_calender/get_event.dart';
import 'package:proj_passion_shoot/features/data/model/payment/post_payment_method.dart';
import 'package:proj_passion_shoot/features/data/model/event_calender/post_event.dart';
import 'package:proj_passion_shoot/features/data/model/transaction/get_transaction.dart';
import 'package:proj_passion_shoot/features/data/model/payment/get_payment_method.dart';
import 'package:proj_passion_shoot/features/data/model/transaction/post_transaction.dart';
import 'package:proj_passion_shoot/features/data/model/type_transaction/body/type_transaction_body.dart';

class Service {
  final String baseUrl = 'http://10.0.2.2:8000/api/';

  Future<List<TransactionData>> getallTransaction() async {
    final response = await http.get(Uri.parse('${baseUrl}all_transaksi'));
    if (response.statusCode == 200) {
      List<TransactionData> transactions =
          parseDataList(json.decode(response.body));
      return transactions;
    } else {
      throw Exception('Failed to load Data');
    }
  }

  Future<List<TransactionData>> getdateallTransaction(
      DateTime selectedDate) async {
    final response = await http.get(Uri.parse(
        '${baseUrl}all_transaksi?date=${selectedDate.toIso8601String()}'));

    if (response.statusCode == 200) {
      List<TransactionData> transactions =
          parseDataList(json.decode(response.body));
      return transactions;
    } else {
      throw Exception('Failed to load transactions');
    }
  }

  Future<List<PaymentData>> getmethodpayment() async {
    try {
      final response = await http.get(Uri.parse('${baseUrl}payment_method'));
      if (response.statusCode == 200) {
        List<PaymentData> payments =
            parseDataListacc(json.decode(response.body));
        return payments;
      } else {
        throw Exception('Failed to load Data: ${response.statusCode}');
      }
    } catch (e) {
      log('Error fetching payment methods: $e');
      throw Exception('Failed to fetch payment methods: $e');
    }
  }

  Future<List<TypeTransaksiData>> getTypeTransaksi() async {
    final response = await http.get(Uri.parse('${baseUrl}type_transaksi'));
    if (response.statusCode == 200) {
      List<TypeTransaksiData> type =
          parseDataListtype(json.decode(response.body));
      return type;
    } else {
      throw Exception('Failed to load Data');
    }
  }

  //POST PAYMENTMETHOD
  Future<void> savePaymentMethod(PostPaymentMethod paymentMethod) async {
    final response = await http.post(
      Uri.parse('${baseUrl}payment_method'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(paymentMethod.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      log('Berhasil menyimpan payment method');
    } else if (response.statusCode == 409) {
      throw Exception('Payment method already exists');
    } else {
      log('Gagal menyimpan payment method: ${response.statusCode}');
      if (response.body.isNotEmpty) {
        log('Detail Kesalahan: ${response.body}');
      }
      throw Exception('Failed to save payment method');
    }
  }

  //POST PENAMBAHAN TRANSAKSI
  Future<void> saveTransaction(Transaction transaction) async {
    final response = await http.post(
      Uri.parse('${baseUrl}all_transaksi'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(transaction.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      log('Berhasil menyimpan transaksi');
    } else {
      log('Gagal menyimpan transaksi: ${response.statusCode}');
      if (response.body.isNotEmpty) {
        log('Detail Kesalahan: ${response.body}');
      }
      throw Exception('Failed to save transaction');
    }
  }

  //EVENT

  Future<List<GetEvent>> getEvents() async {
    final response = await http.get(Uri.parse('${baseUrl}event'));
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      try {
        return GetEvent.parseDataList(jsonResponse);
      } catch (e) {
        log('Error parsing JSON: $e');
        throw Exception('Failed to parse events');
      }
    } else {
      log('Failed to load events: ${response.statusCode}');
      log('Response body: ${response.body}');
      throw Exception('Failed to load events');
    }
  }

  Future<void> postDataToServer(PostEvent event) async {
    final String url = '${baseUrl}event'; // URL for posting event data

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(event.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        log('Data berhasil dipost ke server');
      } else {
        throw Exception(
            'Gagal memposting data ke server: ${response.statusCode}');
      }
    } catch (e) {
      log('Error: $e');
      throw Exception('Terjadi kesalahan saat memposting data');
    }
  }

  Future<void> createEvent(PostEvent event) async {
    final response = await http.post(
      Uri.parse('${baseUrl}event'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(event.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      log('Berhasil menyimpan transaksi');
    } else {
      log('Gagal menyimpan transaksi: ${response.statusCode}');
      if (response.body.isNotEmpty) {
        log('Detail Kesalahan: ${response.body}');
      }
      throw Exception('Failed to save transaction');
    }
  }

  List<TransactionData> parseDataList(dynamic json) {
    if (json['data'] is List) {
      var list = json['data'] as List;
      return list.map((data) => TransactionData.fromJson(data)).toList();
    } else {
      throw Exception('Failed to parse data: JSON is not a list');
    }
  }

  List<PaymentData> parseDataListacc(dynamic json) {
    if (json['success'] == true && json['data'] is List) {
      var list = json['data'] as List;
      return list.map((data) => PaymentData.fromJson(data)).toList();
    } else {
      throw Exception('Failed to parse payment methods data');
    }
  }

  List<TypeTransaksiData> parseDataListtype(dynamic json) {
    if (json['success'] == true && json['data']['data'] is List) {
      var list = json['data']['data'] as List;
      return list.map((data) => TypeTransaksiData.fromJson(data)).toList();
    } else {
      throw Exception('Failed to parse type transactions data');
    }
  }
}
