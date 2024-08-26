import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj_passion_shoot/features/bloc/get_payment/payment_method_bloc.dart';
import 'package:proj_passion_shoot/features/bloc/get_transaction/transaction_bloc.dart';

class ContentMethodList extends StatelessWidget {
  const ContentMethodList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentMethodBloc, PaymentMethodState>(
      builder: (context, state) {
        if (state is PaymentMethodLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is PaymentMethodLoaded) {
          final paymentMethods = state.methods;
          for (var item in paymentMethods) {
            log(item.method);
          }

          return BlocBuilder<TransactionBloc, TransactionState>(
            builder: (context, transactionState) {
              if (transactionState is TransactionLoaded) {
                final transactions = transactionState.transaksis;

                // Menghitung saldo untuk setiap metode pembayaran
                final Map<int, double> balanceByPaymentMethod = {};
                double totalSaldo = 0.0;

                for (var method in paymentMethods) {
                  double total = 0.0;

                  for (var transaction in transactions) {
                    if (transaction.paymentid == method.id) {
                      if (transaction.typeid == 1) {
                        total += transaction.amount;
                      } else if (transaction.typeid == 2) {
                        total -= transaction.amount;
                      }
                    }
                  }

                  balanceByPaymentMethod[method.id] = total;
                  totalSaldo += total;
                }

                return Column(
                  children: [
                    const SizedBox(height: 10),
                    ListTile(
                      title: const Text(
                        'Total Saldo:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Text(
                        'Rp. ${formatNumberWithDots(totalSaldo)}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: totalSaldo >= 0 ? Colors.green : Colors.red,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: paymentMethods.length,
                        itemBuilder: (context, index) {
                          final method = paymentMethods[index];
                          final balance =
                              balanceByPaymentMethod[method.id] ?? 0.0;

                          return ListTile(
                            title: Text(method.method),
                            trailing: Text(
                              'Rp. ${formatNumberWithDots(balance)}',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: balance > 0 ? Colors.green : Colors.red,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
              return const Center(child: Text('Gagal memuat data'));
            },
          );
        }
        if (state is PaymentMethodError) {
          return Center(
            child: Text(state.error),
          );
        }
        return const Center(
          child: Text('Gagal memuat data'),
        );
      },
    );
  }

  String formatNumberWithDots(double number) {
    String numStr = number.toStringAsFixed(2);
    List<String> parts = numStr.split('.');
    String integerPart = parts[0];

    RegExp regExp = RegExp(r'\B(?=(\d{3})+(?!\d))');
    String formattedIntegerPart =
        integerPart.replaceAllMapped(regExp, (Match match) => '.');

    return formattedIntegerPart;
  }
}
