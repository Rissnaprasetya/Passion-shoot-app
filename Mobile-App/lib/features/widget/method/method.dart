import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj_passion_shoot/config/theme/app_theme.dart';
import 'package:proj_passion_shoot/features/bloc/get_payment/payment_method_bloc.dart';
import 'package:proj_passion_shoot/features/bloc/get_transaction/transaction_bloc.dart';
import 'package:proj_passion_shoot/core/network/remote_datasource.dart';
import 'package:proj_passion_shoot/features/pages/method/new_method.dart';
import 'package:proj_passion_shoot/features/widget/add_button.dart';
import 'package:proj_passion_shoot/features/widget/custom_appbar.dart';
import 'package:proj_passion_shoot/features/widget/method/method_list.dart';

class MethodContent extends StatelessWidget {
  const MethodContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              PaymentMethodBloc(RemoteDataSource())..add(LoadPaymentMethod()),
        ),
        BlocProvider(
          create: (context) =>
              TransactionBloc(remotedatasource: RemoteDataSource())
                ..add(LoadTransactions()),
        ),
      ],
      child: Scaffold(
        // appbar
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: CustomAppBar(
            title: 'Sumber Dana',
          ),
        ),
        // end appbar
        body: Container(
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(9),
              ),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            // padding: const EdgeInsets.all(12),
            width: double.infinity,
            // content list
            child: const ContentMethodList()
            // end content list
            // const MethodList
            ),
        // add button
        floatingActionButton: AddButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute<dynamic>(
                  builder: (context) => NewMethodScreen(
                        onPressed: () {},
                      )),
            );
          },
        ),
        // end add button
      ),
    );
  }
}
