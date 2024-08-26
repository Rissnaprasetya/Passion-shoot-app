// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:proj_passion_shoot/features/data/model/payment/post_payment_method.dart';
import 'package:proj_passion_shoot/core/api_service.dart';
import 'package:proj_passion_shoot/features/data/model/payment/get_payment_method.dart';
import 'package:proj_passion_shoot/config/theme/app_theme.dart';

class MethodForm extends StatefulWidget {
  const MethodForm({
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _MethodFormState createState() => _MethodFormState();
}

class _MethodFormState extends State<MethodForm> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final Service _service = Service(); // Membuat instance dari Service

  @override
  void dispose() {
    _namaController.dispose();
    super.dispose();
  }

  Future<void> _simpanData() async {
    if (_formKey.currentState!.validate()) {
      final namamethod = _namaController.text;

      try {
        // Ambil data metode pembayaran yang sudah ada dari database
        List<PaymentData> existingMethods = await _service.getmethodpayment();

        // Periksa apakah data yang dimasukkan sudah ada dalam data yang sudah ada,
        // tanpa memperhatikan perbedaan huruf besar atau kecil
        bool exists = existingMethods.any((method) =>
            method.cmethod.toLowerCase() == namamethod.toLowerCase());

        if (exists) {
          // Jika sudah ada, tampilkan peringatan
          _tampilkanDialogDuplikasi();
        } else {
          // Jika belum ada, simpan data
          PostPaymentMethod metodePembayaranBaru =
              PostPaymentMethod(method: namamethod);

          try {
            await _service.savePaymentMethod(metodePembayaranBaru);
            _tampilkanDialogBerhasil();
          } catch (e) {
            // Tangani kesalahan saat menyimpan data
            log('Error menyimpan metode pembayaran: $e');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Gagal menyimpan metode pembayaran: $e'),
              ),
            );
          }
        }
      } catch (e) {
        // Tangani kesalahan saat mengambil data dari database
        log('Error mengambil metode pembayaran: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal mengambil metode pembayaran: $e'),
          ),
        );
      }
    }
  }

  void _tampilkanDialogDuplikasi() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Metode pembayaran sudah ada!'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _tampilkanDialogBerhasil() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Berhasil'),
          content: const Text('Metode pembayaran berhasil disimpan!'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).popAndPushNamed('/');
                
                // Navigator.of(context).pop();
                // Future.delayed(const Duration(seconds: 0), () {
                //   Navigator.of(context).pop(); // Panggil balik ke parent
                //   _navigateToDestinationPage(
                //       context); // Navigasi ke halaman tujuan
                // });
              },
            ),
          ],
        );
      },
    );
  }

  void _navigateToDestinationPage(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/_HomeScreenState');
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(height: 12),
          TextFormField(
            controller: _namaController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
              ),
              hintText: 'Nama Sumber Dana',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Field ini harus diisi';
              }
              return null;
            },
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: secondaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
              ),
              onPressed: _simpanData,
              child: Text(
                'Simpan',
                style: secondaryTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
